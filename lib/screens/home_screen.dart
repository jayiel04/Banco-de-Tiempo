import 'package:flutter/material.dart';
import '../components/add_task_footer.dart';
import '../components/dialogs.dart';
import '../components/main_appbar.dart';
import '../components/task_list.dart';
import '../constants/app_color.dart';
import '../models/task.dart';
import 'calendar_screen.dart';
import 'completed_tasks_screen.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _showNamePrompt());
  }

  void _showNamePrompt() async {
    if (_namePromptShown) return;
    _namePromptShown = true;
    final name = await showNamePromptDialog(context);
    if (mounted) {
      setState(() => _userName = name ?? 'Usuario');
    }
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
      }
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

  void _showBuyRestTime() async {
    if (_totalGemas <= 0) {
      if (mounted) {
        await showAnimatedDialog(
          context: context,
          builder: (ctx) => Card(
            margin: const EdgeInsets.all(24),
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'No tienes gemas',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Completa tareas para ganar gemas',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: AppColor.fontColor,
                      side: const BorderSide(
                        color: AppColor.secundaryColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: const Text('OK', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return;
    }

    final gemasGastar = await showBuyRestTimeDialog(context, _totalGemas);
    if (gemasGastar == null || !mounted) return;

    setState(() {
      _totalGemas -= gemasGastar;
      _totalRestSeconds += gemasGastar * 3 * 60;
    });
  }

  void _showCalendar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CalendarScreen(tasks: _tasks),
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
                    _showBuyRestTime();
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
                          'Comprar tiempo libre',
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
      appBar: MainAppbar(gemas: _totalGemas, userName: _userName, focusSeconds: _totalFocusSeconds, restSeconds: _totalRestSeconds),
      body: Column(
        children: [
          Expanded(
            child: SectionedTaskList(
              tasks: _tasks,
              onTaskTap: _onTaskTap,
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
