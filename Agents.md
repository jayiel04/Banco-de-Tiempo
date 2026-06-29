# Agents.md — Banco de Tiempo

## Stack
- **Flutter**: 3.44.4 | **Dart**: 3.12.2 | **DevTools**: 2.57.0
- **Drift** 2.34.0 (ORM sobre SQLite) | **drift_dev** 2.34.1 | **drift_flutter** 0.3.0
- **google_fonts** 6.3.3 (PressStart2P para estética pixel art)

## Arquitectura
```
lib/
├── main.dart                  # Entry point
├── constants/                 # Colores, strings, temas
├── components/                # Widgets reutilizables
├── screens/                   # Pantallas / páginas
├── database/                  # Capa de datos local
│   ├── database.dart          # AppDatabase (Drift)
│   └── tables/
│       ├── usuario_table.dart
│       ├── tarea_table.dart
│       ├── recompensa_table.dart
│       └── transaccion_table.dart
├── models/                    # (futuro) Modelos de datos
└── services/                  # (futuro) Lógica de negocio
```

## Base de datos (Drift / SQLite)
| Tabla | Columnas clave |
|---|---|
| `Usuarios` | id, nombre, email (unique), saldoMinutos, fechaCreacion |
| `Tareas` | id, usuarioId (FK), titulo, descripcion, dificultad, completada, fechaLimite, fechaCreacion, fechaCompletada |
| `Recompensas` | id, usuarioId (FK), descripcion, costoMinutos, canjeada, fechaCreacion |
| `Transacciones` | id, usuarioId (FK), tipo, cantidad, concepto, referenciaId, fecha |

## Dificultad de tareas
| Nivel | Gemas |
|---|---|
| `facil` | 1 |
| `intermedio` | 3 |
| `dificil` | 6 |
| `muyDificil` | 12 |

Modelo en `lib/models/dificultad.dart` usando `enum Dificultad` con getter `.gemas`.

### Reglas
- `AppDatabase` se genera con `build_runner` → `database.g.dart`
- Usar `driftDatabase(name: 'banco_de_tiempo')` para inicializar (multiplataforma)
- No usar SQL plano; siempre mediante el DAO generado por drift
- Ejecutar `dart run build_runner build` tras cada cambio en tablas

## Constraints de widgets (solo estos 15 permitidos)
MaterialApp, Scaffold, AppBar, Container, Column, Row, Expanded, Padding, SizedBox, Text, Icon, TextField, ElevatedButton, ListView, Card.

## Paleta de colores
| Token | Color |
|---|---|
| `primaryColor` | `#7C3AED` |
| `secundaryColor` | `#A78BFA` |
| `fontColor` | `#E2E8F0` |
| `backgraundColor` | `#0F0D1A` |
| `surfaceColor` | `#1E1B2E` |

## Convenciones
- **Files**: `snake_case.dart` (ej. `app_color.dart`).
- **Clases**: `PascalCase` → `AppColor`, `MainAppbar`.
- **Constantes**: `camelCase` → `primaryColor`, `fontColor`.
- **Sin comentarios** en código salvo que se pida explícitamente.
- **Sin emojis** en archivos a menos que el usuario los solicite.

## Calidad
- Usar `package:flutter_lints/flutter.yaml` como análisis estático.
- Verificar con `flutter analyze` antes de commits.
- Código limpio, escalable y sin duplicación.

## Estilo de código
- Preferir `const` siempre que sea posible.
- Usar `super.key` en constructores.
- Mantener widgets pequeños y reutilizables.
- No añadir comentarios explicativos en el código (salvo que el usuario lo pida).
