import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/usuario_table.dart';
import 'tables/tarea_table.dart';
import 'tables/recompensa_table.dart';
import 'tables/transaccion_table.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Usuarios,
    Tareas,
    Recompensas,
    Transacciones,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'banco_de_tiempo');
}
