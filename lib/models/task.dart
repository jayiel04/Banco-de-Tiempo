import 'dificultad.dart';

class Task {
  String titulo;
  Dificultad dificultad;
  bool temporizada;
  bool esHabito;
  DateTime? fechaLimite;
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

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'dificultad': dificultad.name,
        'temporizada': temporizada,
        'esHabito': esHabito,
        'fechaLimite': fechaLimite?.millisecondsSinceEpoch,
        'ultimaCompletacion': ultimaCompletacion?.millisecondsSinceEpoch,
        'racha': racha,
        'completada': completada,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        titulo: json['titulo'] as String,
        dificultad: Dificultad.values.firstWhere((d) => d.name == json['dificultad']),
        temporizada: json['temporizada'] as bool,
        esHabito: json['esHabito'] as bool,
        fechaLimite: json['fechaLimite'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['fechaLimite'] as int)
            : null,
        ultimaCompletacion: json['ultimaCompletacion'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['ultimaCompletacion'] as int)
            : null,
        racha: json['racha'] as int? ?? 0,
        completada: json['completada'] as bool? ?? false,
      );
}
