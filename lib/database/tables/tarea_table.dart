import 'package:drift/drift.dart';
import 'usuario_table.dart';

class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get dificultad => text()();
  BoolColumn get completada => boolean().withDefault(const Constant(false))();
  DateTimeColumn get fechaLimite => dateTime().nullable()();
  DateTimeColumn get fechaCreacion => dateTime()();
  DateTimeColumn get fechaCompletada => dateTime().nullable()();
}
