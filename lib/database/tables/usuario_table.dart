import 'package:drift/drift.dart';

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get email => text().unique()();
  RealColumn get saldoMinutos => real().withDefault(const Constant(0))();
  DateTimeColumn get fechaCreacion => dateTime()();
}
