import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/task.dart';
import 'task_card.dart';

class SectionedTaskList extends StatelessWidget {
  final List<Task> tasks;
  final void Function(Task) onTaskTap;
  final void Function(Task) onTaskLongPress;

  const SectionedTaskList({
    super.key,
    required this.tasks,
    required this.onTaskTap,
    required this.onTaskLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasks = tasks.where((t) => !t.completada).toList();

    if (pendingTasks.isEmpty) {
      return const Center(
        child: Text('No hay tareas', style: TextStyle(fontSize: 18)),
      );
    }

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    final habitos = pendingTasks.where((t) => t.esHabito).toList();
    final hoy = pendingTasks.where((t) {
      final fl = t.fechaLimite;
      if (fl == null) return false;
      final flDate = DateTime(fl.year, fl.month, fl.day);
      return flDate == todayStart;
    }).toList();
    final futuras = pendingTasks.where((t) {
      final fl = t.fechaLimite;
      if (fl == null) return false;
      final flDate = DateTime(fl.year, fl.month, fl.day);
      return flDate.isAfter(todayStart);
    }).toList();
    final sinFecha = pendingTasks.where((t) => t.fechaLimite == null && !t.esHabito).toList();

    final sections = <Widget>[];

    void addSection(String title, List<Task> tasksInSection, {required bool isHabito}) {
      if (tasksInSection.isEmpty) return;
      sections.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColor.secundaryColor,
              fontSize: 11,
            ),
          ),
        ),
      );
      for (final task in tasksInSection) {
        sections.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: isHabito
                ? HabitCard(task: task, onTap: () => onTaskTap(task), onLongPress: () => onTaskLongPress(task))
                : TaskCard(task: task, onTap: () => onTaskTap(task), onLongPress: () => onTaskLongPress(task)),
          ),
        );
      }
    }

    addSection('Habitos', habitos, isHabito: true);
    addSection('Hoy', hoy, isHabito: false);
    addSection('Tareas futuras', futuras, isHabito: false);
    addSection('Sin fecha limite', sinFecha, isHabito: false);

    return ListView(children: sections);
  }
}
