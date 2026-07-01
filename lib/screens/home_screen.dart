import 'package:flutter/material.dart';
import '../components/add_task_footer.dart';
import '../components/dialogs.dart';
import '../components/main_appbar.dart';
import '../components/task_list.dart';
import '../constants/app_color.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import 'calendar_screen.dart';
import 'completed_tasks_screen.dart';
import 'profile_screen.dart';
import 'rest_screen.dart';
import 'timer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tasks = <Task>[];
  final _titleController = TextEditingController();
  int _totalGemas = 0;
  int _totalFocusSeconds = 0;
  int _totalRestSeconds = 0;
  String _userName = '';
  bool _namePromptShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadState());
  }

  Future<void> _loadState() async {
    final name = await StorageService.loadUserName();
    final gemas = await StorageService.loadTotalGemas();
    final focusSeconds = await StorageService.loadTotalFocusSeconds();
    final restSeconds = await StorageService.loadTotalRestSeconds();
    final tasks = await StorageService.loadTasks();
    if (!mounted) return;
    setState(() {
      _userName = name ?? '';
      _totalGemas = gemas;
      _totalFocusSeconds = focusSeconds;
      _totalRestSeconds = restSeconds;
      _tasks.addAll(tasks);
    });
    if (name == null || name.isEmpty) {
      _showNamePrompt();
    }
  }

  Future<void> _saveState() async {
    await Future.wait([
      StorageService.saveUserName(_userName),
      StorageService.saveTotalGemas(_totalGemas),
      StorageService.saveTotalFocusSeconds(_totalFocusSeconds),
      StorageService.saveTotalRestSeconds(_totalRestSeconds),
      StorageService.saveTasks(_tasks),
    ]);
  }

  void _showNamePrompt() async {
    if (_namePromptShown) return;
    _namePromptShown = true;
    final name = await showNamePromptDialog(context);
    if (mounted && name != null) {
      setState(() => _userName = name);
      _saveState();
      _requestNotificationPermission();
    }
  }

  Future<void> _requestNotificationPermission() async {
    final alreadyAsked = await StorageService.hasAskedNotificationPermission();
    if (alreadyAsked) return;
    await NotificationService.requestPermission();
    await StorageService.markNotificationPermissionAsked();
  }

  void _addTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final result = await showCreateTaskDialog(context);
    if (result == null || !mounted) return;
    final (dificultad, deadline, temporizada, esHabito) = result;

    setState(() {
      _tasks.add(Task(
        titulo: title,
        dificultad: dificultad,
        temporizada: esHabito ? false : temporizada,
        esHabito: esHabito,
        fechaLimite: esHabito ? null : deadline,
      ));
      _titleController.clear();
    });
    _saveState();
  }

  void _onTaskTap(Task task) async {
    if (task.temporizada) {
      final shouldStart = await showTimerStartDialog(context, task.titulo);
      if (shouldStart == true) {
        if (!mounted) return;
        final result = await Navigator.push<(int, int)>(
          context,
          MaterialPageRoute(builder: (_) => TimerScreen(task: task)),
        );
        if (!mounted) return;
        if (result != null) {
          final (gemas, seconds) = result;
          setState(() {
            _totalGemas += gemas;
            _totalFocusSeconds += seconds;
          });
          _saveState();
        }
      }
    } else if (task.esHabito) {
      final today = DateTime.now();
      final lastComp = task.ultimaCompletacion;
      final completedToday = lastComp != null &&
          lastComp.year == today.year &&
          lastComp.month == today.month &&
          lastComp.day == today.day;

      if (completedToday) {
        await showHabitAlreadyDoneDialog(context, task.racha);
      } else {
        final shouldComplete = await showHabitConfirmDialog(
          context,
          task.titulo,
          task.dificultad.gemas,
        );
        if (shouldComplete == true) {
          if (!mounted) return;
          setState(() {
            final yesterday = today.subtract(const Duration(days: 1));
            if (lastComp != null &&
                lastComp.year == yesterday.year &&
                lastComp.month == yesterday.month &&
                lastComp.day == yesterday.day) {
              task.racha += 1;
            } else {
              task.racha = 1;
            }
            task.ultimaCompletacion = today;
            _totalGemas += task.dificultad.gemas;
          });
          _saveState();
        }
      }
    } else {
      final shouldComplete = await showTaskCompleteDialog(context, task.titulo);
        if (shouldComplete == true) {
          if (!mounted) return;
          setState(() {
            task.completada = true;
            _totalGemas += task.dificultad.gemas;
          });
          _saveState();
        }
    }
  }

  void _onTaskLongPress(Task task) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: AppColor.timeColor),
              title: const Text('Editar', style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pop(ctx);
                _editTask(task);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.redAccent),
              title: const Text('Eliminar', style: TextStyle(fontSize: 15)),
              onTap: () {
                Navigator.pop(ctx);
                _deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editTask(Task task) async {
    final result = await showEditTaskDialog(context, task);
    if (result == null || !mounted) return;
    final (title, dificultad, deadline, temporizada, esHabito) = result;
    setState(() {
      task.titulo = title;
      task.dificultad = dificultad;
      task.fechaLimite = deadline;
      task.temporizada = esHabito ? false : temporizada;
      task.esHabito = esHabito;
    });
    _saveState();
  }

  void _deleteTask(Task task) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
          elevation: 12,
          shadowColor: Colors.black87,
          color: AppColor.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: AppColor.secundaryColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Eliminar tarea?',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  task.titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.secundaryColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: AppColor.backgraundColor,
                        side: const BorderSide(
                          color: Colors.redAccent,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: const Text('Si', style: TextStyle(fontSize: 13)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColor.secundaryColor,
                        side: BorderSide(
                          color: AppColor.secundaryColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: const Text('No', style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (confirm == true && mounted) {
      setState(() => _tasks.remove(task));
      _saveState();
    }
  }

  void _showCompletedTasks() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CompletedTasksScreen(
          tasks: _tasks.where((t) => t.completada && !t.esHabito).toList(),
        ),
      ),
    );
  }

  void _showRestScreen() async {
    final result = await Navigator.push<(int, int)>(
      context,
      MaterialPageRoute(
        builder: (_) => RestScreen(
          gemasDisponibles: _totalGemas,
          restSecondsDisponibles: _totalRestSeconds,
        ),
      ),
    );
    if (result != null && mounted) {
      final (gemas, restSeconds) = result;
      setState(() {
        _totalGemas = gemas;
        _totalRestSeconds = restSeconds;
      });
      _saveState();
    }
  }

  void _showCalendar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CalendarScreen(tasks: _tasks),
      ),
    );
  }

  void _showProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          totalFocusSeconds: _totalFocusSeconds,
          totalRestSeconds: _totalRestSeconds,
          tasks: _tasks,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: AppColor.surfaceColor,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: AppColor.primaryColor),
                child: const Text('Menu', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showCalendar();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.fontColor,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: AppColor.timeColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Calendario',
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showCompletedTasks();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.fontColor,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColor.secundaryColor,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Tareas Completadas',
                          style: TextStyle(fontSize: 15),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.fontColor,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColor.fontColor,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Perfil',
                          style: TextStyle(fontSize: 15),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showRestScreen();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.fontColor,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.free_breakfast,
                        color: AppColor.gemColor,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                          child: Text(
                            'Tiempo libre',
                            style: TextStyle(fontSize: 15),
                            softWrap: true,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: MainAppbar(
        gemas: _totalGemas,
        userName: _userName,
        focusSeconds: _totalFocusSeconds,
        restSeconds: _totalRestSeconds,
        onAvatarTap: _showProfile,
      ),
      body: Column(
        children: [
          Expanded(
            child: SectionedTaskList(
              tasks: _tasks,
              onTaskTap: _onTaskTap,
              onTaskLongPress: _onTaskLongPress,
            ),
          ),
          AddTaskFooter(
            controller: _titleController,
            onAdd: _addTask,
          ),
        ],
      ),
    );
  }
}
