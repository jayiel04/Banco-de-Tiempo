import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/task.dart';

class HabitCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const HabitCard({super.key, required this.task, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final completedToday = task.ultimaCompletacion != null &&
        DateTime(task.ultimaCompletacion!.year, task.ultimaCompletacion!.month,
                task.ultimaCompletacion!.day)
            .isAtSameMomentAs(today);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor.gemColor, width: 2),
        borderRadius: BorderRadius.circular(2),
      ),
      color: AppColor.gemColor.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 12, 12, 12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  completedToday
                      ? Icons.local_fire_department
                      : Icons.repeat,
                  color: completedToday
                      ? AppColor.timeColor
                      : Colors.grey.shade500,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.titulo,
                      style: TextStyle(
                        fontSize: 18,
                        color: completedToday
                            ? AppColor.timeColor
                            : AppColor.fontColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${task.dificultad.gemas} gemas',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColor.gemColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Racha ${task.racha}',
                          style: TextStyle(
                            fontSize: 11,
                            color: completedToday
                                ? AppColor.timeColor
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'HABITO',
                style: TextStyle(
                  color: AppColor.gemColor.withValues(alpha: 0.5),
                  fontSize: 9,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TaskCard({super.key, required this.task, required this.onTap, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColor.secundaryColor.withValues(alpha: 0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      color: AppColor.surfaceColor,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
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
                        children: [
                          TextSpan(
                            text: '${task.dificultad.gemas} gemas',
                            style: const TextStyle(color: AppColor.gemColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text.rich(
                      TextSpan(
                        text: 'Temporizada: ',
                        children: [
                          TextSpan(
                            text: task.temporizada ? 'Si' : 'No',
                            style: const TextStyle(color: AppColor.timeColor),
                          ),
                        ],
                      ),
                    ),
                    if (task.fechaLimite != null) ...[
                      const SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          text: 'Fecha limite: ',
                          children: [
                            TextSpan(
                              text:
                                  '${task.fechaLimite!.day.toString().padLeft(2, '0')}/${task.fechaLimite!.month.toString().padLeft(2, '0')}/${task.fechaLimite!.year}',
                              style: const TextStyle(
                                color: AppColor.timeColor,
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
                color: task.completada
                    ? AppColor.secundaryColor
                    : Colors.grey.shade600,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
