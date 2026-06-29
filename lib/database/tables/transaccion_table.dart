import 'package:drift/drift.dart';
import 'usuario_table.dart';

class Transacciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
  TextColumn get tipo => text()();
  RealColumn get cantidad => real()();
  TextColumn get concepto => text()();
  IntColumn get referenciaId => integer().nullable()();
  DateTimeColumn get fecha => dateTime()();
}
