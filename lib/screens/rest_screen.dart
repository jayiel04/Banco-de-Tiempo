import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../components/dialogs.dart';
import '../services/notification_service.dart';

class RestScreen extends StatefulWidget {
  final int gemasDisponibles;
  final int restSecondsDisponibles;

  const RestScreen({
    super.key,
    required this.gemasDisponibles,
    required this.restSecondsDisponibles,
  });

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  static const _notificationId = 2;
  static const _countdownNotificationId = 102;
  late int _gemas;
  late int _restSeconds;
  final _minutesController = TextEditingController(text: '10');
  Timer? _timer;
  int _remainingSeconds = 0;
  int _totalSeconds = 0;
  DateTime? _startTime;
  bool _isRunning = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _gemas = widget.gemasDisponibles;
    _restSeconds = widget.restSecondsDisponibles;
  }

  @override
  void dispose() {
    _timer?.cancel();
    NotificationService.cancelNotification(_notificationId);
    NotificationService.cancelNotification(_countdownNotificationId);
    _minutesController.dispose();
    super.dispose();
  }

  int _maxRestMinutes() => _restSeconds ~/ 60;

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _formatRestBalance(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  void _startRestTimer() {
    final minutes = int.tryParse(_minutesController.text.trim()) ?? 0;
    if (minutes <= 0) return;
    if (minutes > _maxRestMinutes()) return;

    final total = minutes * 60;
    setState(() {
      _restSeconds -= total;
      _totalSeconds = total;
      _remainingSeconds = total;
      _startTime = DateTime.now();
      _isRunning = true;
      _isFinished = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final elapsed = DateTime.now().difference(_startTime!).inSeconds;
      final remaining = _totalSeconds - elapsed;
      if (remaining <= 0) {
        _timer?.cancel();
        NotificationService.cancelNotification(_notificationId);
        NotificationService.cancelNotification(_countdownNotificationId);
        setState(() {
          _remainingSeconds = 0;
          _isRunning = false;
          _isFinished = true;
        });
      } else {
        setState(() => _remainingSeconds = remaining);
        NotificationService.showCountdownNotification(
          id: _countdownNotificationId,
          title: 'Descanso',
          body: 'Tiempo restante: ${_formatTime(remaining)}',
        );
      }
    });

    final endTime = DateTime.now().add(Duration(seconds: total));
    NotificationService.scheduleTimerEndNotification(
      endTime: endTime,
      id: _notificationId,
      title: 'Descanso completado',
      body: 'Tu tiempo de descanso ha terminado',
    );
    NotificationService.showCountdownNotification(
      id: _countdownNotificationId,
      title: 'Descanso',
      body: 'Tiempo restante: ${_formatTime(total)}',
    );
  }

  void _stopRestTimer() {
    _timer?.cancel();
    NotificationService.cancelNotification(_notificationId);
    NotificationService.cancelNotification(_countdownNotificationId);
    _restSeconds += _remainingSeconds;
    setState(() {
      _isRunning = false;
      _remainingSeconds = 0;
    });
  }

  void _buyMore() async {
    final gemasGastar = await showBuyRestTimeDialog(context, _gemas);
    if (gemasGastar == null || !mounted) return;
    setState(() {
      _gemas -= gemasGastar;
      _restSeconds += gemasGastar * 3 * 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        Navigator.pop(context, (_gemas, _restSeconds));
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tiempo libre', style: TextStyle(fontSize: 18)),
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.fontColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, (_gemas, _restSeconds)),
          ),
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
                              Icons.self_improvement,
                              size: 64,
                              color: AppColor.gemColor,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Descanso completado!',
                              style: TextStyle(fontSize: 18, color: AppColor.gemColor),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Has disfrutado de $_totalSeconds segundos de descanso',
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
                                  : 'Descanso',
                              style: TextStyle(
                                fontSize: _isRunning ? 56 : 40,
                                color: _isRunning
                                    ? AppColor.gemColor
                                    : AppColor.secundaryColor,
                              ),
                            ),
                            if (!_isRunning) ...[
                              const SizedBox(height: 12),
                              Text(
                                'Disponible: ${_formatRestBalance(_restSeconds)}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColor.gemColor,
                                ),
                              ),
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
                              if (_maxRestMinutes() > 0)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Max: ${_maxRestMinutes()} min',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColor.secundaryColor,
                                    ),
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
                        onPressed: () => Navigator.pop(context, (_gemas, _restSeconds)),
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
                        child: const Text('Volver', style: TextStyle(fontSize: 13)),
                      )
                    else if (_isRunning)
                      ElevatedButton(
                        onPressed: _stopRestTimer,
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
                      if (_restSeconds <= 0) ...[
                        ElevatedButton(
                          onPressed: _buyMore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: AppColor.fontColor,
                            side: const BorderSide(
                              color: AppColor.gemColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text('Comprar', style: TextStyle(fontSize: 13)),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: _startRestTimer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: AppColor.fontColor,
                            side: const BorderSide(
                              color: AppColor.gemColor,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text('Iniciar', style: TextStyle(fontSize: 13)),
                        ),
                        ElevatedButton(
                          onPressed: _buyMore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: AppColor.gemColor,
                            side: BorderSide(
                              color: AppColor.gemColor.withValues(alpha: 0.5),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          child: const Text('Comprar mas', style: TextStyle(fontSize: 13)),
                        ),
                      ],
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, (_gemas, _restSeconds)),
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
      ),
    );
  }
}
