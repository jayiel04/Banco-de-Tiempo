import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/task.dart';

class CompletedTasksScreen extends StatelessWidget {
  final List<Task> tasks;

  const CompletedTasksScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final completedTasks = tasks.where((t) => t.completada).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completadas', style: TextStyle(fontSize: 18)),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.fontColor,
      ),
      body: Container(
        color: AppColor.backgraundColor,
        child: completedTasks.isEmpty
            ? const Center(
                child: Text(
                  'No hay tareas completadas',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
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
                            const Icon(
                              Icons.check_circle,
                              size: 24,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
