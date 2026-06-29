import 'package:flutter/material.dart';
import '../components/main_appbar.dart';
import '../constants/app_color.dart';
import '../models/dificultad.dart';
import 'calendar_screen.dart';
import 'completed_tasks_screen.dart';
import 'timer_screen.dart';

class Task {
  final String titulo;
  final Dificultad dificultad;
  final bool temporizada;
  final DateTime? fechaLimite;
  bool completada = false;

  Task({
    required this.titulo,
    required this.dificultad,
    required this.temporizada,
    this.fechaLimite,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tasks = <Task>[];
  final _titleController = TextEditingController();
  int _totalGemas = 0;

  Future<T?> _showAnimatedDialog<T>({
    required WidgetBuilder builder,
  }) {
    return showGeneralDialog<T>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(
            opacity: animation,
            child: builder(context),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  void _addTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final result = await _showAnimatedDialog<(Dificultad, DateTime?)>(
      builder: (ctx) {
        Dificultad selected = Dificultad.facil;
        DateTime? deadline;

        return StatefulBuilder(
          builder: (ctx, setDialogState) => Card(
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
                    'Selecciona la dificultad',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ...Dificultad.values.map(
                    (d) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => setDialogState(() => selected = d),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selected == d
                                ? AppColor.secundaryColor
                                : AppColor.primaryColor,
                            foregroundColor: selected == d
                                ? AppColor.backgraundColor
                                : AppColor.fontColor,
                            side: BorderSide(
                              color: selected == d
                                  ? AppColor.fontColor
                                  : AppColor.secundaryColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: '${d.name} - ',
                              style: const TextStyle(fontSize: 15),
                              children: [
                                TextSpan(
                                  text: '${d.gemas} gemas',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColor.gemColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: AppColor.secundaryColor),
                  const SizedBox(height: 8),
                  const Text(
                    'Fecha limite',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: ctx,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          setDialogState(() => deadline = date);
                        }
                      },
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        deadline != null
                            ? '${deadline!.day}/${deadline!.month}/${deadline!.year}'
                            : 'Seleccionar fecha',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  if (deadline != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => setDialogState(() => deadline = null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.red.shade300,
                          side: BorderSide(
                            color: Colors.red.shade300.withValues(alpha: 0.5),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: const Text(
                          'Quitar fecha',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(
                          ctx,
                          (selected, deadline),
                        ),
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
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(ctx, null),
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
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (result == null || !mounted) return;
    final (dificultad, deadline) = result;

    final temporizada = await _showAnimatedDialog<bool>(
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
                'Es una tarea temporizada?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
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
                    child: const Text('Si', style: TextStyle(fontSize: 15)),
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
                    child: const Text('No', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, null),
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
                child: const Text('Cancelar', style: TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );

    if (temporizada == null || !mounted) return;

    setState(() {
      _tasks.add(Task(
        titulo: title,
        dificultad: dificultad,
        temporizada: temporizada,
        fechaLimite: deadline,
      ));
      _titleController.clear();
    });
  }

  void _onTaskTap(Task task) async {
    if (task.temporizada) {
      final shouldStart = await _showAnimatedDialog<bool>(
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
                'Listo para empezar\nla tarea?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                task.titulo,
                style: TextStyle(
                  color: AppColor.secundaryColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
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
                    child: const Text('Sí', style: TextStyle(fontSize: 15)),
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
                    child: const Text('No', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

      if (shouldStart == true) {
        if (!mounted) return;
        final gemasObtenidas = await Navigator.push<int>(
          context,
          MaterialPageRoute(builder: (_) => TimerScreen(task: task)),
        );

        if (!mounted) return;
        if (gemasObtenidas != null) {
          setState(() => _totalGemas += gemasObtenidas);
        }
      }
    } else {
      final shouldComplete = await _showAnimatedDialog<bool>(
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
                  'Marcar como completada?',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  task.titulo,
                  style: TextStyle(
                    color: AppColor.secundaryColor,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
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
                      child: const Text('Si', style: TextStyle(fontSize: 15)),
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
                      child: const Text('No', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

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
        builder: (_) => CompletedTasksScreen(tasks: _tasks),
      ),
    );
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
              SizedBox(height: 8),
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
              SizedBox(height: 8),
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
                      Expanded(
                        child: Text(
                          'Tareas Completadas',
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
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
      appBar: MainAppbar(gemas: _totalGemas),
      body: Column(
        children: [
          Expanded(
            child: (() {
              final pendingTasks = _tasks.where((t) => !t.completada).toList();
              if (pendingTasks.isEmpty) {
                return const Center(
                  child: Text('No hay tareas', style: TextStyle(fontSize: 18)),
                );
              }
              return ListView.builder(
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final task = pendingTasks[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                            side: BorderSide(
                              color: AppColor.secundaryColor.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          color: AppColor.surfaceColor,
                          elevation: 0,
                            child: InkWell(
                            onTap: () => _onTaskTap(task),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.titulo,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(height: 6),
                                        Text.rich(
                                          TextSpan(
                                            text: '${task.dificultad.name} - ',
                                            style: TextStyle(
                                              color: AppColor.secundaryColor,
                                              fontSize: 13,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${task.dificultad.gemas} gemas',
                                                style: TextStyle(
                                                  color: AppColor.gemColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text.rich(
                                          TextSpan(
                                            text: 'Temporizada: ',
                                            style: TextStyle(
                                              color: AppColor.secundaryColor.withValues(alpha: 0.6),
                                              fontSize: 11,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: task.temporizada ? 'Si' : 'No',
                                                style: TextStyle(
                                                  color: AppColor.timeColor,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (task.fechaLimite != null) ...[
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            TextSpan(
                                              text: 'Fecha limite: ',
                                              style: TextStyle(
                                                color: AppColor.secundaryColor.withValues(alpha: 0.6),
                                                fontSize: 11,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '${task.fechaLimite!.day}/${task.fechaLimite!.month}/${task.fechaLimite!.year}',
                                                  style: const TextStyle(
                                                    color: AppColor.timeColor,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    task.completada
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    size: 24,
                                    color: task.completada
                                        ? AppColor.secundaryColor
                                        : Colors.grey.shade600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    );
                  },
                );
              })(),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            decoration: BoxDecoration(
              color: AppColor.surfaceColor,
              border: Border(
                top: BorderSide(
                  color: AppColor.secundaryColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Nueva tarea...',
                          hintStyle: const TextStyle(fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(
                              color: AppColor.secundaryColor.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: BorderSide(
                              color: AppColor.secundaryColor.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                            borderSide: const BorderSide(
                              color: AppColor.secundaryColor,
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addTask,
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: const Text('OK', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
