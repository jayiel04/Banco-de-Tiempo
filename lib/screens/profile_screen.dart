import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/app_color.dart';
import '../models/dificultad.dart';
import '../models/task.dart';
import '../services/storage_service.dart';

class ProfileScreen extends StatefulWidget {
  final int totalFocusSeconds;
  final int totalRestSeconds;
  final List<Task> tasks;

  const ProfileScreen({
    super.key,
    required this.totalFocusSeconds,
    required this.totalRestSeconds,
    required this.tasks,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }

  Future<void> _loadPhoto() async {
    final path = await StorageService.loadProfilePhotoPath();
    if (mounted) setState(() => _photoPath = path);
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final dir = await getApplicationDocumentsDirectory();
    final file = File(picked.path);
    final saved = await file.copy('${dir.path}/profile_pic.jpg');
    final path = saved.path;

    await StorageService.saveProfilePhotoPath(path);
    if (mounted) setState(() => _photoPath = path);
  }

  String _formatHours(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    return '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context) {
    final completed = widget.tasks.where((t) => t.completada).toList();
    final facil = completed.where((t) => t.dificultad == Dificultad.facil).length;
    final intermedio = completed.where((t) => t.dificultad == Dificultad.intermedio).length;
    final dificil = completed.where((t) => t.dificultad == Dificultad.dificil).length;
    final muyDificil = completed.where((t) => t.dificultad == Dificultad.muyDificil).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil', style: TextStyle(fontSize: 18)),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.fontColor,
      ),
      body: Container(
        color: AppColor.backgraundColor,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickPhoto,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColor.surfaceColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppColor.secundaryColor,
                          width: 3,
                        ),
                      ),
                      child: _photoPath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(_photoPath!),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 50,
                              color: AppColor.secundaryColor,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColor.secundaryColor,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: AppColor.fontColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                _photoPath != null ? 'Toca para cambiar foto' : 'Toca para agregar foto',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColor.secundaryColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Tiempo total',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.surfaceColor,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: AppColor.secundaryColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 24, color: AppColor.timeColor),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enfoque',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        _formatHours(widget.totalFocusSeconds),
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColor.timeColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.free_breakfast, size: 24, color: AppColor.gemColor),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Descanso',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        _formatHours(widget.totalRestSeconds),
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColor.gemColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tareas completadas',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.surfaceColor,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: AppColor.secundaryColor.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  _difficultyRow('Facil', facil, Dificultad.facil.gemas),
                  const Divider(color: AppColor.secundaryColor),
                  _difficultyRow('Intermedio', intermedio, Dificultad.intermedio.gemas),
                  const Divider(color: AppColor.secundaryColor),
                  _difficultyRow('Dificil', dificil, Dificultad.dificil.gemas),
                  const Divider(color: AppColor.secundaryColor),
                  _difficultyRow('Muy dificil', muyDificil, Dificultad.muyDificil.gemas),
                ],
              ),
            ),
            if (completed.isNotEmpty) ...[
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Total: ${completed.length} tareas',
                  style: const TextStyle(fontSize: 13, color: AppColor.secundaryColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _difficultyRow(String label, int count, int gemasPorTarea) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            child: Text(
              '$count',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, color: AppColor.gemColor),
            ),
          ),
          Expanded(
            child: Text(
              '${count * gemasPorTarea} gemas',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 11,
                color: AppColor.gemColor.withValues(alpha: 0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
