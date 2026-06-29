import 'dificultad.dart';

class Task {
  final String titulo;
  final Dificultad dificultad;
  final bool temporizada;
  final bool esHabito;
  final DateTime? fechaLimite;
  DateTime? ultimaCompletacion;
  int racha = 0;
  bool completada = false;

  Task({
    required this.titulo,
    required this.dificultad,
    required this.temporizada,
    required this.esHabito,
    this.fechaLimite,
    this.ultimaCompletacion,
    this.racha = 0,
    this.completada = false,
  });
}
