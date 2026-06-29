// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _saldoMinutosMeta = const VerificationMeta(
    'saldoMinutos',
  );
  @override
  late final GeneratedColumn<double> saldoMinutos = GeneratedColumn<double>(
    'saldo_minutos',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fechaCreacionMeta = const VerificationMeta(
    'fechaCreacion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>(
        'fecha_creacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    email,
    saldoMinutos,
    fechaCreacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('saldo_minutos')) {
      context.handle(
        _saldoMinutosMeta,
        saldoMinutos.isAcceptableOrUnknown(
          data['saldo_minutos']!,
          _saldoMinutosMeta,
        ),
      );
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      saldoMinutos: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saldo_minutos'],
      )!,
      fechaCreacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_creacion'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nombre;
  final String email;
  final double saldoMinutos;
  final DateTime fechaCreacion;
  const Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.saldoMinutos,
    required this.fechaCreacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['email'] = Variable<String>(email);
    map['saldo_minutos'] = Variable<double>(saldoMinutos);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      email: Value(email),
      saldoMinutos: Value(saldoMinutos),
      fechaCreacion: Value(fechaCreacion),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      email: serializer.fromJson<String>(json['email']),
      saldoMinutos: serializer.fromJson<double>(json['saldoMinutos']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'email': serializer.toJson<String>(email),
      'saldoMinutos': serializer.toJson<double>(saldoMinutos),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
    };
  }

  Usuario copyWith({
    int? id,
    String? nombre,
    String? email,
    double? saldoMinutos,
    DateTime? fechaCreacion,
  }) => Usuario(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    email: email ?? this.email,
    saldoMinutos: saldoMinutos ?? this.saldoMinutos,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      email: data.email.present ? data.email.value : this.email,
      saldoMinutos: data.saldoMinutos.present
          ? data.saldoMinutos.value
          : this.saldoMinutos,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('email: $email, ')
          ..write('saldoMinutos: $saldoMinutos, ')
          ..write('fechaCreacion: $fechaCreacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, email, saldoMinutos, fechaCreacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.email == this.email &&
          other.saldoMinutos == this.saldoMinutos &&
          other.fechaCreacion == this.fechaCreacion);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> email;
  final Value<double> saldoMinutos;
  final Value<DateTime> fechaCreacion;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.email = const Value.absent(),
    this.saldoMinutos = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String email,
    this.saldoMinutos = const Value.absent(),
    required DateTime fechaCreacion,
  }) : nombre = Value(nombre),
       email = Value(email),
       fechaCreacion = Value(fechaCreacion);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? email,
    Expression<double>? saldoMinutos,
    Expression<DateTime>? fechaCreacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (email != null) 'email': email,
      if (saldoMinutos != null) 'saldo_minutos': saldoMinutos,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
    });
  }

  UsuariosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? email,
    Value<double>? saldoMinutos,
    Value<DateTime>? fechaCreacion,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      saldoMinutos: saldoMinutos ?? this.saldoMinutos,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (saldoMinutos.present) {
      map['saldo_minutos'] = Variable<double>(saldoMinutos.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('email: $email, ')
          ..write('saldoMinutos: $saldoMinutos, ')
          ..write('fechaCreacion: $fechaCreacion')
          ..write(')'))
        .toString();
  }
}

class $TareasTable extends Tareas with TableInfo<$TareasTable, Tarea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dificultadMeta = const VerificationMeta(
    'dificultad',
  );
  @override
  late final GeneratedColumn<String> dificultad = GeneratedColumn<String>(
    'dificultad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completadaMeta = const VerificationMeta(
    'completada',
  );
  @override
  late final GeneratedColumn<bool> completada = GeneratedColumn<bool>(
    'completada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fechaLimiteMeta = const VerificationMeta(
    'fechaLimite',
  );
  @override
  late final GeneratedColumn<DateTime> fechaLimite = GeneratedColumn<DateTime>(
    'fecha_limite',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaCreacionMeta = const VerificationMeta(
    'fechaCreacion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>(
        'fecha_creacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fechaCompletadaMeta = const VerificationMeta(
    'fechaCompletada',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCompletada =
      GeneratedColumn<DateTime>(
        'fecha_completada',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    titulo,
    descripcion,
    dificultad,
    completada,
    fechaLimite,
    fechaCreacion,
    fechaCompletada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tareas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('dificultad')) {
      context.handle(
        _dificultadMeta,
        dificultad.isAcceptableOrUnknown(data['dificultad']!, _dificultadMeta),
      );
    } else if (isInserting) {
      context.missing(_dificultadMeta);
    }
    if (data.containsKey('completada')) {
      context.handle(
        _completadaMeta,
        completada.isAcceptableOrUnknown(data['completada']!, _completadaMeta),
      );
    }
    if (data.containsKey('fecha_limite')) {
      context.handle(
        _fechaLimiteMeta,
        fechaLimite.isAcceptableOrUnknown(
          data['fecha_limite']!,
          _fechaLimiteMeta,
        ),
      );
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    if (data.containsKey('fecha_completada')) {
      context.handle(
        _fechaCompletadaMeta,
        fechaCompletada.isAcceptableOrUnknown(
          data['fecha_completada']!,
          _fechaCompletadaMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarea(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      dificultad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dificultad'],
      )!,
      completada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completada'],
      )!,
      fechaLimite: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_limite'],
      ),
      fechaCreacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_creacion'],
      )!,
      fechaCompletada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_completada'],
      ),
    );
  }

  @override
  $TareasTable createAlias(String alias) {
    return $TareasTable(attachedDatabase, alias);
  }
}

class Tarea extends DataClass implements Insertable<Tarea> {
  final int id;
  final int usuarioId;
  final String titulo;
  final String? descripcion;
  final String dificultad;
  final bool completada;
  final DateTime? fechaLimite;
  final DateTime fechaCreacion;
  final DateTime? fechaCompletada;
  const Tarea({
    required this.id,
    required this.usuarioId,
    required this.titulo,
    this.descripcion,
    required this.dificultad,
    required this.completada,
    this.fechaLimite,
    required this.fechaCreacion,
    this.fechaCompletada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['titulo'] = Variable<String>(titulo);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['dificultad'] = Variable<String>(dificultad);
    map['completada'] = Variable<bool>(completada);
    if (!nullToAbsent || fechaLimite != null) {
      map['fecha_limite'] = Variable<DateTime>(fechaLimite);
    }
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    if (!nullToAbsent || fechaCompletada != null) {
      map['fecha_completada'] = Variable<DateTime>(fechaCompletada);
    }
    return map;
  }

  TareasCompanion toCompanion(bool nullToAbsent) {
    return TareasCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      titulo: Value(titulo),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      dificultad: Value(dificultad),
      completada: Value(completada),
      fechaLimite: fechaLimite == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaLimite),
      fechaCreacion: Value(fechaCreacion),
      fechaCompletada: fechaCompletada == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaCompletada),
    );
  }

  factory Tarea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarea(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      dificultad: serializer.fromJson<String>(json['dificultad']),
      completada: serializer.fromJson<bool>(json['completada']),
      fechaLimite: serializer.fromJson<DateTime?>(json['fechaLimite']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
      fechaCompletada: serializer.fromJson<DateTime?>(json['fechaCompletada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String?>(descripcion),
      'dificultad': serializer.toJson<String>(dificultad),
      'completada': serializer.toJson<bool>(completada),
      'fechaLimite': serializer.toJson<DateTime?>(fechaLimite),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
      'fechaCompletada': serializer.toJson<DateTime?>(fechaCompletada),
    };
  }

  Tarea copyWith({
    int? id,
    int? usuarioId,
    String? titulo,
    Value<String?> descripcion = const Value.absent(),
    String? dificultad,
    bool? completada,
    Value<DateTime?> fechaLimite = const Value.absent(),
    DateTime? fechaCreacion,
    Value<DateTime?> fechaCompletada = const Value.absent(),
  }) => Tarea(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    dificultad: dificultad ?? this.dificultad,
    completada: completada ?? this.completada,
    fechaLimite: fechaLimite.present ? fechaLimite.value : this.fechaLimite,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    fechaCompletada: fechaCompletada.present
        ? fechaCompletada.value
        : this.fechaCompletada,
  );
  Tarea copyWithCompanion(TareasCompanion data) {
    return Tarea(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      dificultad: data.dificultad.present
          ? data.dificultad.value
          : this.dificultad,
      completada: data.completada.present
          ? data.completada.value
          : this.completada,
      fechaLimite: data.fechaLimite.present
          ? data.fechaLimite.value
          : this.fechaLimite,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
      fechaCompletada: data.fechaCompletada.present
          ? data.fechaCompletada.value
          : this.fechaCompletada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarea(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('dificultad: $dificultad, ')
          ..write('completada: $completada, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('fechaCompletada: $fechaCompletada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    titulo,
    descripcion,
    dificultad,
    completada,
    fechaLimite,
    fechaCreacion,
    fechaCompletada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarea &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.dificultad == this.dificultad &&
          other.completada == this.completada &&
          other.fechaLimite == this.fechaLimite &&
          other.fechaCreacion == this.fechaCreacion &&
          other.fechaCompletada == this.fechaCompletada);
}

class TareasCompanion extends UpdateCompanion<Tarea> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> titulo;
  final Value<String?> descripcion;
  final Value<String> dificultad;
  final Value<bool> completada;
  final Value<DateTime?> fechaLimite;
  final Value<DateTime> fechaCreacion;
  final Value<DateTime?> fechaCompletada;
  const TareasCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.dificultad = const Value.absent(),
    this.completada = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
    this.fechaCompletada = const Value.absent(),
  });
  TareasCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String titulo,
    this.descripcion = const Value.absent(),
    required String dificultad,
    this.completada = const Value.absent(),
    this.fechaLimite = const Value.absent(),
    required DateTime fechaCreacion,
    this.fechaCompletada = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       titulo = Value(titulo),
       dificultad = Value(dificultad),
       fechaCreacion = Value(fechaCreacion);
  static Insertable<Tarea> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? dificultad,
    Expression<bool>? completada,
    Expression<DateTime>? fechaLimite,
    Expression<DateTime>? fechaCreacion,
    Expression<DateTime>? fechaCompletada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (dificultad != null) 'dificultad': dificultad,
      if (completada != null) 'completada': completada,
      if (fechaLimite != null) 'fecha_limite': fechaLimite,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
      if (fechaCompletada != null) 'fecha_completada': fechaCompletada,
    });
  }

  TareasCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<String>? titulo,
    Value<String?>? descripcion,
    Value<String>? dificultad,
    Value<bool>? completada,
    Value<DateTime?>? fechaLimite,
    Value<DateTime>? fechaCreacion,
    Value<DateTime?>? fechaCompletada,
  }) {
    return TareasCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      dificultad: dificultad ?? this.dificultad,
      completada: completada ?? this.completada,
      fechaLimite: fechaLimite ?? this.fechaLimite,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
      fechaCompletada: fechaCompletada ?? this.fechaCompletada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (dificultad.present) {
      map['dificultad'] = Variable<String>(dificultad.value);
    }
    if (completada.present) {
      map['completada'] = Variable<bool>(completada.value);
    }
    if (fechaLimite.present) {
      map['fecha_limite'] = Variable<DateTime>(fechaLimite.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    if (fechaCompletada.present) {
      map['fecha_completada'] = Variable<DateTime>(fechaCompletada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareasCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('dificultad: $dificultad, ')
          ..write('completada: $completada, ')
          ..write('fechaLimite: $fechaLimite, ')
          ..write('fechaCreacion: $fechaCreacion, ')
          ..write('fechaCompletada: $fechaCompletada')
          ..write(')'))
        .toString();
  }
}

class $RecompensasTable extends Recompensas
    with TableInfo<$RecompensasTable, Recompensa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecompensasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoMinutosMeta = const VerificationMeta(
    'costoMinutos',
  );
  @override
  late final GeneratedColumn<double> costoMinutos = GeneratedColumn<double>(
    'costo_minutos',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _canjeadaMeta = const VerificationMeta(
    'canjeada',
  );
  @override
  late final GeneratedColumn<bool> canjeada = GeneratedColumn<bool>(
    'canjeada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("canjeada" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _fechaCreacionMeta = const VerificationMeta(
    'fechaCreacion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCreacion =
      GeneratedColumn<DateTime>(
        'fecha_creacion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    descripcion,
    costoMinutos,
    canjeada,
    fechaCreacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recompensas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recompensa> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('costo_minutos')) {
      context.handle(
        _costoMinutosMeta,
        costoMinutos.isAcceptableOrUnknown(
          data['costo_minutos']!,
          _costoMinutosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoMinutosMeta);
    }
    if (data.containsKey('canjeada')) {
      context.handle(
        _canjeadaMeta,
        canjeada.isAcceptableOrUnknown(data['canjeada']!, _canjeadaMeta),
      );
    }
    if (data.containsKey('fecha_creacion')) {
      context.handle(
        _fechaCreacionMeta,
        fechaCreacion.isAcceptableOrUnknown(
          data['fecha_creacion']!,
          _fechaCreacionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaCreacionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recompensa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recompensa(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      costoMinutos: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}costo_minutos'],
      )!,
      canjeada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}canjeada'],
      )!,
      fechaCreacion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_creacion'],
      )!,
    );
  }

  @override
  $RecompensasTable createAlias(String alias) {
    return $RecompensasTable(attachedDatabase, alias);
  }
}

class Recompensa extends DataClass implements Insertable<Recompensa> {
  final int id;
  final int usuarioId;
  final String descripcion;
  final double costoMinutos;
  final bool canjeada;
  final DateTime fechaCreacion;
  const Recompensa({
    required this.id,
    required this.usuarioId,
    required this.descripcion,
    required this.costoMinutos,
    required this.canjeada,
    required this.fechaCreacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['descripcion'] = Variable<String>(descripcion);
    map['costo_minutos'] = Variable<double>(costoMinutos);
    map['canjeada'] = Variable<bool>(canjeada);
    map['fecha_creacion'] = Variable<DateTime>(fechaCreacion);
    return map;
  }

  RecompensasCompanion toCompanion(bool nullToAbsent) {
    return RecompensasCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      descripcion: Value(descripcion),
      costoMinutos: Value(costoMinutos),
      canjeada: Value(canjeada),
      fechaCreacion: Value(fechaCreacion),
    );
  }

  factory Recompensa.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recompensa(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      costoMinutos: serializer.fromJson<double>(json['costoMinutos']),
      canjeada: serializer.fromJson<bool>(json['canjeada']),
      fechaCreacion: serializer.fromJson<DateTime>(json['fechaCreacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'descripcion': serializer.toJson<String>(descripcion),
      'costoMinutos': serializer.toJson<double>(costoMinutos),
      'canjeada': serializer.toJson<bool>(canjeada),
      'fechaCreacion': serializer.toJson<DateTime>(fechaCreacion),
    };
  }

  Recompensa copyWith({
    int? id,
    int? usuarioId,
    String? descripcion,
    double? costoMinutos,
    bool? canjeada,
    DateTime? fechaCreacion,
  }) => Recompensa(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    descripcion: descripcion ?? this.descripcion,
    costoMinutos: costoMinutos ?? this.costoMinutos,
    canjeada: canjeada ?? this.canjeada,
    fechaCreacion: fechaCreacion ?? this.fechaCreacion,
  );
  Recompensa copyWithCompanion(RecompensasCompanion data) {
    return Recompensa(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      costoMinutos: data.costoMinutos.present
          ? data.costoMinutos.value
          : this.costoMinutos,
      canjeada: data.canjeada.present ? data.canjeada.value : this.canjeada,
      fechaCreacion: data.fechaCreacion.present
          ? data.fechaCreacion.value
          : this.fechaCreacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recompensa(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoMinutos: $costoMinutos, ')
          ..write('canjeada: $canjeada, ')
          ..write('fechaCreacion: $fechaCreacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    descripcion,
    costoMinutos,
    canjeada,
    fechaCreacion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recompensa &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.descripcion == this.descripcion &&
          other.costoMinutos == this.costoMinutos &&
          other.canjeada == this.canjeada &&
          other.fechaCreacion == this.fechaCreacion);
}

class RecompensasCompanion extends UpdateCompanion<Recompensa> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> descripcion;
  final Value<double> costoMinutos;
  final Value<bool> canjeada;
  final Value<DateTime> fechaCreacion;
  const RecompensasCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.costoMinutos = const Value.absent(),
    this.canjeada = const Value.absent(),
    this.fechaCreacion = const Value.absent(),
  });
  RecompensasCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String descripcion,
    required double costoMinutos,
    this.canjeada = const Value.absent(),
    required DateTime fechaCreacion,
  }) : usuarioId = Value(usuarioId),
       descripcion = Value(descripcion),
       costoMinutos = Value(costoMinutos),
       fechaCreacion = Value(fechaCreacion);
  static Insertable<Recompensa> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? descripcion,
    Expression<double>? costoMinutos,
    Expression<bool>? canjeada,
    Expression<DateTime>? fechaCreacion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (descripcion != null) 'descripcion': descripcion,
      if (costoMinutos != null) 'costo_minutos': costoMinutos,
      if (canjeada != null) 'canjeada': canjeada,
      if (fechaCreacion != null) 'fecha_creacion': fechaCreacion,
    });
  }

  RecompensasCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<String>? descripcion,
    Value<double>? costoMinutos,
    Value<bool>? canjeada,
    Value<DateTime>? fechaCreacion,
  }) {
    return RecompensasCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      descripcion: descripcion ?? this.descripcion,
      costoMinutos: costoMinutos ?? this.costoMinutos,
      canjeada: canjeada ?? this.canjeada,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (costoMinutos.present) {
      map['costo_minutos'] = Variable<double>(costoMinutos.value);
    }
    if (canjeada.present) {
      map['canjeada'] = Variable<bool>(canjeada.value);
    }
    if (fechaCreacion.present) {
      map['fecha_creacion'] = Variable<DateTime>(fechaCreacion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecompensasCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoMinutos: $costoMinutos, ')
          ..write('canjeada: $canjeada, ')
          ..write('fechaCreacion: $fechaCreacion')
          ..write(')'))
        .toString();
  }
}

class $TransaccionesTable extends Transacciones
    with TableInfo<$TransaccionesTable, Transaccione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransaccionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptoMeta = const VerificationMeta(
    'concepto',
  );
  @override
  late final GeneratedColumn<String> concepto = GeneratedColumn<String>(
    'concepto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenciaIdMeta = const VerificationMeta(
    'referenciaId',
  );
  @override
  late final GeneratedColumn<int> referenciaId = GeneratedColumn<int>(
    'referencia_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    tipo,
    cantidad,
    concepto,
    referenciaId,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transacciones';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaccione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('concepto')) {
      context.handle(
        _conceptoMeta,
        concepto.isAcceptableOrUnknown(data['concepto']!, _conceptoMeta),
      );
    } else if (isInserting) {
      context.missing(_conceptoMeta);
    }
    if (data.containsKey('referencia_id')) {
      context.handle(
        _referenciaIdMeta,
        referenciaId.isAcceptableOrUnknown(
          data['referencia_id']!,
          _referenciaIdMeta,
        ),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaccione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaccione(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      concepto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concepto'],
      )!,
      referenciaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}referencia_id'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $TransaccionesTable createAlias(String alias) {
    return $TransaccionesTable(attachedDatabase, alias);
  }
}

class Transaccione extends DataClass implements Insertable<Transaccione> {
  final int id;
  final int usuarioId;
  final String tipo;
  final double cantidad;
  final String concepto;
  final int? referenciaId;
  final DateTime fecha;
  const Transaccione({
    required this.id,
    required this.usuarioId,
    required this.tipo,
    required this.cantidad,
    required this.concepto,
    this.referenciaId,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<int>(usuarioId);
    map['tipo'] = Variable<String>(tipo);
    map['cantidad'] = Variable<double>(cantidad);
    map['concepto'] = Variable<String>(concepto);
    if (!nullToAbsent || referenciaId != null) {
      map['referencia_id'] = Variable<int>(referenciaId);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  TransaccionesCompanion toCompanion(bool nullToAbsent) {
    return TransaccionesCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      tipo: Value(tipo),
      cantidad: Value(cantidad),
      concepto: Value(concepto),
      referenciaId: referenciaId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenciaId),
      fecha: Value(fecha),
    );
  }

  factory Transaccione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaccione(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      concepto: serializer.fromJson<String>(json['concepto']),
      referenciaId: serializer.fromJson<int?>(json['referenciaId']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<int>(usuarioId),
      'tipo': serializer.toJson<String>(tipo),
      'cantidad': serializer.toJson<double>(cantidad),
      'concepto': serializer.toJson<String>(concepto),
      'referenciaId': serializer.toJson<int?>(referenciaId),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  Transaccione copyWith({
    int? id,
    int? usuarioId,
    String? tipo,
    double? cantidad,
    String? concepto,
    Value<int?> referenciaId = const Value.absent(),
    DateTime? fecha,
  }) => Transaccione(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    tipo: tipo ?? this.tipo,
    cantidad: cantidad ?? this.cantidad,
    concepto: concepto ?? this.concepto,
    referenciaId: referenciaId.present ? referenciaId.value : this.referenciaId,
    fecha: fecha ?? this.fecha,
  );
  Transaccione copyWithCompanion(TransaccionesCompanion data) {
    return Transaccione(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      concepto: data.concepto.present ? data.concepto.value : this.concepto,
      referenciaId: data.referenciaId.present
          ? data.referenciaId.value
          : this.referenciaId,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaccione(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('concepto: $concepto, ')
          ..write('referenciaId: $referenciaId, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, usuarioId, tipo, cantidad, concepto, referenciaId, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaccione &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.tipo == this.tipo &&
          other.cantidad == this.cantidad &&
          other.concepto == this.concepto &&
          other.referenciaId == this.referenciaId &&
          other.fecha == this.fecha);
}

class TransaccionesCompanion extends UpdateCompanion<Transaccione> {
  final Value<int> id;
  final Value<int> usuarioId;
  final Value<String> tipo;
  final Value<double> cantidad;
  final Value<String> concepto;
  final Value<int?> referenciaId;
  final Value<DateTime> fecha;
  const TransaccionesCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.concepto = const Value.absent(),
    this.referenciaId = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  TransaccionesCompanion.insert({
    this.id = const Value.absent(),
    required int usuarioId,
    required String tipo,
    required double cantidad,
    required String concepto,
    this.referenciaId = const Value.absent(),
    required DateTime fecha,
  }) : usuarioId = Value(usuarioId),
       tipo = Value(tipo),
       cantidad = Value(cantidad),
       concepto = Value(concepto),
       fecha = Value(fecha);
  static Insertable<Transaccione> custom({
    Expression<int>? id,
    Expression<int>? usuarioId,
    Expression<String>? tipo,
    Expression<double>? cantidad,
    Expression<String>? concepto,
    Expression<int>? referenciaId,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (tipo != null) 'tipo': tipo,
      if (cantidad != null) 'cantidad': cantidad,
      if (concepto != null) 'concepto': concepto,
      if (referenciaId != null) 'referencia_id': referenciaId,
      if (fecha != null) 'fecha': fecha,
    });
  }

  TransaccionesCompanion copyWith({
    Value<int>? id,
    Value<int>? usuarioId,
    Value<String>? tipo,
    Value<double>? cantidad,
    Value<String>? concepto,
    Value<int?>? referenciaId,
    Value<DateTime>? fecha,
  }) {
    return TransaccionesCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      tipo: tipo ?? this.tipo,
      cantidad: cantidad ?? this.cantidad,
      concepto: concepto ?? this.concepto,
      referenciaId: referenciaId ?? this.referenciaId,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (concepto.present) {
      map['concepto'] = Variable<String>(concepto.value);
    }
    if (referenciaId.present) {
      map['referencia_id'] = Variable<int>(referenciaId.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransaccionesCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('tipo: $tipo, ')
          ..write('cantidad: $cantidad, ')
          ..write('concepto: $concepto, ')
          ..write('referenciaId: $referenciaId, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $TareasTable tareas = $TareasTable(this);
  late final $RecompensasTable recompensas = $RecompensasTable(this);
  late final $TransaccionesTable transacciones = $TransaccionesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    tareas,
    recompensas,
    transacciones,
  ];
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      required String nombre,
      required String email,
      Value<double> saldoMinutos,
      required DateTime fechaCreacion,
    });
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> email,
      Value<double> saldoMinutos,
      Value<DateTime> fechaCreacion,
    });

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TareasTable, List<Tarea>> _tareasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tareas,
    aliasName: 'usuarios__id__tareas__usuario_id',
  );

  $$TareasTableProcessedTableManager get tareasRefs {
    final manager = $$TareasTableTableManager(
      $_db,
      $_db.tareas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tareasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecompensasTable, List<Recompensa>>
  _recompensasRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recompensas,
    aliasName: 'usuarios__id__recompensas__usuario_id',
  );

  $$RecompensasTableProcessedTableManager get recompensasRefs {
    final manager = $$RecompensasTableTableManager(
      $_db,
      $_db.recompensas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recompensasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransaccionesTable, List<Transaccione>>
  _transaccionesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transacciones,
    aliasName: 'usuarios__id__transacciones__usuario_id',
  );

  $$TransaccionesTableProcessedTableManager get transaccionesRefs {
    final manager = $$TransaccionesTableTableManager(
      $_db,
      $_db.transacciones,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transaccionesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saldoMinutos => $composableBuilder(
    column: $table.saldoMinutos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tareasRefs(
    Expression<bool> Function($$TareasTableFilterComposer f) f,
  ) {
    final $$TareasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TareasTableFilterComposer(
            $db: $db,
            $table: $db.tareas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recompensasRefs(
    Expression<bool> Function($$RecompensasTableFilterComposer f) f,
  ) {
    final $$RecompensasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recompensas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecompensasTableFilterComposer(
            $db: $db,
            $table: $db.recompensas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transaccionesRefs(
    Expression<bool> Function($$TransaccionesTableFilterComposer f) f,
  ) {
    final $$TransaccionesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transacciones,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaccionesTableFilterComposer(
            $db: $db,
            $table: $db.transacciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saldoMinutos => $composableBuilder(
    column: $table.saldoMinutos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<double> get saldoMinutos => $composableBuilder(
    column: $table.saldoMinutos,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  Expression<T> tareasRefs<T extends Object>(
    Expression<T> Function($$TareasTableAnnotationComposer a) f,
  ) {
    final $$TareasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TareasTableAnnotationComposer(
            $db: $db,
            $table: $db.tareas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recompensasRefs<T extends Object>(
    Expression<T> Function($$RecompensasTableAnnotationComposer a) f,
  ) {
    final $$RecompensasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recompensas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecompensasTableAnnotationComposer(
            $db: $db,
            $table: $db.recompensas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transaccionesRefs<T extends Object>(
    Expression<T> Function($$TransaccionesTableAnnotationComposer a) f,
  ) {
    final $$TransaccionesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transacciones,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaccionesTableAnnotationComposer(
            $db: $db,
            $table: $db.transacciones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({
            bool tareasRefs,
            bool recompensasRefs,
            bool transaccionesRefs,
          })
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<double> saldoMinutos = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nombre: nombre,
                email: email,
                saldoMinutos: saldoMinutos,
                fechaCreacion: fechaCreacion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String email,
                Value<double> saldoMinutos = const Value.absent(),
                required DateTime fechaCreacion,
              }) => UsuariosCompanion.insert(
                id: id,
                nombre: nombre,
                email: email,
                saldoMinutos: saldoMinutos,
                fechaCreacion: fechaCreacion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                tareasRefs = false,
                recompensasRefs = false,
                transaccionesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (tareasRefs) db.tareas,
                    if (recompensasRefs) db.recompensas,
                    if (transaccionesRefs) db.transacciones,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (tareasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Tarea
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._tareasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).tareasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recompensasRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Recompensa
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._recompensasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).recompensasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transaccionesRefs)
                        await $_getPrefetchedData<
                          Usuario,
                          $UsuariosTable,
                          Transaccione
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._transaccionesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).transaccionesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.usuarioId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({
        bool tareasRefs,
        bool recompensasRefs,
        bool transaccionesRefs,
      })
    >;
typedef $$TareasTableCreateCompanionBuilder =
    TareasCompanion Function({
      Value<int> id,
      required int usuarioId,
      required String titulo,
      Value<String?> descripcion,
      required String dificultad,
      Value<bool> completada,
      Value<DateTime?> fechaLimite,
      required DateTime fechaCreacion,
      Value<DateTime?> fechaCompletada,
    });
typedef $$TareasTableUpdateCompanionBuilder =
    TareasCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<String> titulo,
      Value<String?> descripcion,
      Value<String> dificultad,
      Value<bool> completada,
      Value<DateTime?> fechaLimite,
      Value<DateTime> fechaCreacion,
      Value<DateTime?> fechaCompletada,
    });

final class $$TareasTableReferences
    extends BaseReferences<_$AppDatabase, $TareasTable, Tarea> {
  $$TareasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias('tareas__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TareasTableFilterComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dificultad => $composableBuilder(
    column: $table.dificultad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completada => $composableBuilder(
    column: $table.completada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableOrderingComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dificultad => $composableBuilder(
    column: $table.dificultad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completada => $composableBuilder(
    column: $table.completada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dificultad => $composableBuilder(
    column: $table.dificultad,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completada => $composableBuilder(
    column: $table.completada,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaLimite => $composableBuilder(
    column: $table.fechaLimite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCompletada => $composableBuilder(
    column: $table.fechaCompletada,
    builder: (column) => column,
  );

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareasTable,
          Tarea,
          $$TareasTableFilterComposer,
          $$TareasTableOrderingComposer,
          $$TareasTableAnnotationComposer,
          $$TareasTableCreateCompanionBuilder,
          $$TareasTableUpdateCompanionBuilder,
          (Tarea, $$TareasTableReferences),
          Tarea,
          PrefetchHooks Function({bool usuarioId})
        > {
  $$TareasTableTableManager(_$AppDatabase db, $TareasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String> dificultad = const Value.absent(),
                Value<bool> completada = const Value.absent(),
                Value<DateTime?> fechaLimite = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
                Value<DateTime?> fechaCompletada = const Value.absent(),
              }) => TareasCompanion(
                id: id,
                usuarioId: usuarioId,
                titulo: titulo,
                descripcion: descripcion,
                dificultad: dificultad,
                completada: completada,
                fechaLimite: fechaLimite,
                fechaCreacion: fechaCreacion,
                fechaCompletada: fechaCompletada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required String titulo,
                Value<String?> descripcion = const Value.absent(),
                required String dificultad,
                Value<bool> completada = const Value.absent(),
                Value<DateTime?> fechaLimite = const Value.absent(),
                required DateTime fechaCreacion,
                Value<DateTime?> fechaCompletada = const Value.absent(),
              }) => TareasCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                titulo: titulo,
                descripcion: descripcion,
                dificultad: dificultad,
                completada: completada,
                fechaLimite: fechaLimite,
                fechaCreacion: fechaCreacion,
                fechaCompletada: fechaCompletada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TareasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable: $$TareasTableReferences
                                    ._usuarioIdTable(db),
                                referencedColumn: $$TareasTableReferences
                                    ._usuarioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TareasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareasTable,
      Tarea,
      $$TareasTableFilterComposer,
      $$TareasTableOrderingComposer,
      $$TareasTableAnnotationComposer,
      $$TareasTableCreateCompanionBuilder,
      $$TareasTableUpdateCompanionBuilder,
      (Tarea, $$TareasTableReferences),
      Tarea,
      PrefetchHooks Function({bool usuarioId})
    >;
typedef $$RecompensasTableCreateCompanionBuilder =
    RecompensasCompanion Function({
      Value<int> id,
      required int usuarioId,
      required String descripcion,
      required double costoMinutos,
      Value<bool> canjeada,
      required DateTime fechaCreacion,
    });
typedef $$RecompensasTableUpdateCompanionBuilder =
    RecompensasCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<String> descripcion,
      Value<double> costoMinutos,
      Value<bool> canjeada,
      Value<DateTime> fechaCreacion,
    });

final class $$RecompensasTableReferences
    extends BaseReferences<_$AppDatabase, $RecompensasTable, Recompensa> {
  $$RecompensasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias('recompensas__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecompensasTableFilterComposer
    extends Composer<_$AppDatabase, $RecompensasTable> {
  $$RecompensasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costoMinutos => $composableBuilder(
    column: $table.costoMinutos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canjeada => $composableBuilder(
    column: $table.canjeada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecompensasTableOrderingComposer
    extends Composer<_$AppDatabase, $RecompensasTable> {
  $$RecompensasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costoMinutos => $composableBuilder(
    column: $table.costoMinutos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canjeada => $composableBuilder(
    column: $table.canjeada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecompensasTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecompensasTable> {
  $$RecompensasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costoMinutos => $composableBuilder(
    column: $table.costoMinutos,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canjeada =>
      $composableBuilder(column: $table.canjeada, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaCreacion => $composableBuilder(
    column: $table.fechaCreacion,
    builder: (column) => column,
  );

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecompensasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecompensasTable,
          Recompensa,
          $$RecompensasTableFilterComposer,
          $$RecompensasTableOrderingComposer,
          $$RecompensasTableAnnotationComposer,
          $$RecompensasTableCreateCompanionBuilder,
          $$RecompensasTableUpdateCompanionBuilder,
          (Recompensa, $$RecompensasTableReferences),
          Recompensa,
          PrefetchHooks Function({bool usuarioId})
        > {
  $$RecompensasTableTableManager(_$AppDatabase db, $RecompensasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecompensasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecompensasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecompensasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<double> costoMinutos = const Value.absent(),
                Value<bool> canjeada = const Value.absent(),
                Value<DateTime> fechaCreacion = const Value.absent(),
              }) => RecompensasCompanion(
                id: id,
                usuarioId: usuarioId,
                descripcion: descripcion,
                costoMinutos: costoMinutos,
                canjeada: canjeada,
                fechaCreacion: fechaCreacion,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required String descripcion,
                required double costoMinutos,
                Value<bool> canjeada = const Value.absent(),
                required DateTime fechaCreacion,
              }) => RecompensasCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                descripcion: descripcion,
                costoMinutos: costoMinutos,
                canjeada: canjeada,
                fechaCreacion: fechaCreacion,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecompensasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable: $$RecompensasTableReferences
                                    ._usuarioIdTable(db),
                                referencedColumn: $$RecompensasTableReferences
                                    ._usuarioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecompensasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecompensasTable,
      Recompensa,
      $$RecompensasTableFilterComposer,
      $$RecompensasTableOrderingComposer,
      $$RecompensasTableAnnotationComposer,
      $$RecompensasTableCreateCompanionBuilder,
      $$RecompensasTableUpdateCompanionBuilder,
      (Recompensa, $$RecompensasTableReferences),
      Recompensa,
      PrefetchHooks Function({bool usuarioId})
    >;
typedef $$TransaccionesTableCreateCompanionBuilder =
    TransaccionesCompanion Function({
      Value<int> id,
      required int usuarioId,
      required String tipo,
      required double cantidad,
      required String concepto,
      Value<int?> referenciaId,
      required DateTime fecha,
    });
typedef $$TransaccionesTableUpdateCompanionBuilder =
    TransaccionesCompanion Function({
      Value<int> id,
      Value<int> usuarioId,
      Value<String> tipo,
      Value<double> cantidad,
      Value<String> concepto,
      Value<int?> referenciaId,
      Value<DateTime> fecha,
    });

final class $$TransaccionesTableReferences
    extends BaseReferences<_$AppDatabase, $TransaccionesTable, Transaccione> {
  $$TransaccionesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) =>
      db.usuarios.createAlias('transacciones__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransaccionesTableFilterComposer
    extends Composer<_$AppDatabase, $TransaccionesTable> {
  $$TransaccionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenciaId => $composableBuilder(
    column: $table.referenciaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaccionesTableOrderingComposer
    extends Composer<_$AppDatabase, $TransaccionesTable> {
  $$TransaccionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenciaId => $composableBuilder(
    column: $table.referenciaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaccionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransaccionesTable> {
  $$TransaccionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get concepto =>
      $composableBuilder(column: $table.concepto, builder: (column) => column);

  GeneratedColumn<int> get referenciaId => $composableBuilder(
    column: $table.referenciaId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaccionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransaccionesTable,
          Transaccione,
          $$TransaccionesTableFilterComposer,
          $$TransaccionesTableOrderingComposer,
          $$TransaccionesTableAnnotationComposer,
          $$TransaccionesTableCreateCompanionBuilder,
          $$TransaccionesTableUpdateCompanionBuilder,
          (Transaccione, $$TransaccionesTableReferences),
          Transaccione,
          PrefetchHooks Function({bool usuarioId})
        > {
  $$TransaccionesTableTableManager(_$AppDatabase db, $TransaccionesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransaccionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransaccionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransaccionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<String> concepto = const Value.absent(),
                Value<int?> referenciaId = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => TransaccionesCompanion(
                id: id,
                usuarioId: usuarioId,
                tipo: tipo,
                cantidad: cantidad,
                concepto: concepto,
                referenciaId: referenciaId,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int usuarioId,
                required String tipo,
                required double cantidad,
                required String concepto,
                Value<int?> referenciaId = const Value.absent(),
                required DateTime fecha,
              }) => TransaccionesCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                tipo: tipo,
                cantidad: cantidad,
                concepto: concepto,
                referenciaId: referenciaId,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransaccionesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable: $$TransaccionesTableReferences
                                    ._usuarioIdTable(db),
                                referencedColumn: $$TransaccionesTableReferences
                                    ._usuarioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransaccionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransaccionesTable,
      Transaccione,
      $$TransaccionesTableFilterComposer,
      $$TransaccionesTableOrderingComposer,
      $$TransaccionesTableAnnotationComposer,
      $$TransaccionesTableCreateCompanionBuilder,
      $$TransaccionesTableUpdateCompanionBuilder,
      (Transaccione, $$TransaccionesTableReferences),
      Transaccione,
      PrefetchHooks Function({bool usuarioId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$TareasTableTableManager get tareas =>
      $$TareasTableTableManager(_db, _db.tareas);
  $$RecompensasTableTableManager get recompensas =>
      $$RecompensasTableTableManager(_db, _db.recompensas);
  $$TransaccionesTableTableManager get transacciones =>
      $$TransaccionesTableTableManager(_db, _db.transacciones);
}
