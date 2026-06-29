import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/task.dart';

class TimerScreen extends StatefulWidget {
  final Task task;

  const TimerScreen({super.key, required this.task});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final _minutesController = TextEditingController(text: '25');
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;
  bool _isFinished = false;

  void _startTimer() {
    final minutes = int.tryParse(_minutesController.text.trim()) ?? 0;
    if (minutes <= 0) return;

    setState(() {
      _remainingSeconds = minutes * 60;
      _isRunning = true;
      _isFinished = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _isRunning = false;
          _isFinished = true;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  String _formatTime(int totalSeconds) {
    final min = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final sec = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _minutesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.task.titulo,
          style: const TextStyle(fontSize: 18),
        ),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.fontColor,
      ),
      body: Container(
        color: AppColor.backgraundColor,
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: _isFinished
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 64,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Tiempo completado!',
                            style: TextStyle(fontSize: 18, color: AppColor.timeColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Has trabajado en:\n${widget.task.titulo}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.secundaryColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _isRunning
                                ? _formatTime(_remainingSeconds)
                                : '${_minutesController.text}:00',
                            style: TextStyle(
                               fontSize: _isRunning ? 56 : 40,
                               color: _isRunning
                                   ? AppColor.timeColor
                                   : AppColor.secundaryColor,
                            ),
                          ),
                          if (!_isRunning) ...[
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 120,
                              child: TextField(
                                controller: _minutesController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  labelText: 'Minutos',
                                  labelStyle: const TextStyle(fontSize: 13),
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
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColor.surfaceColor,
                border: Border(
                  top: BorderSide(
                    color: AppColor.secundaryColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_isFinished)
                    ElevatedButton(
                      onPressed: () {
                        widget.task.completada = true;
                        Navigator.pop(context, widget.task.dificultad.gemas);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: const Text('Completar', style: TextStyle(fontSize: 13)),
                    )
                  else if (_isRunning)
                    ElevatedButton(
                      onPressed: _stopTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: const Text('Detener', style: TextStyle(fontSize: 13)),
                    )
                  else ...[
                    ElevatedButton(
                      onPressed: _startTimer,
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
                      child: const Text('Iniciar', style: TextStyle(fontSize: 13)),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
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
                      child: const Text('Volver', style: TextStyle(fontSize: 13)),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
