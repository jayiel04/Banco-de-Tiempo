import 'package:drift/drift.dart';
import 'usuario_table.dart';

class Recompensas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  TextColumn get descripcion => text()();
  RealColumn get costoMinutos => real()();
  BoolColumn get canjeada => boolean().withDefault(const Constant(false))();
  DateTimeColumn get fechaCreacion => dateTime()();
}
