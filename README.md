# Banco de Tiempo ⏳

![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart)
![Drift](https://img.shields.io/badge/Drift-2.34-3DDC84)

> Una aplicación Flutter de gestión de tareas con estética pixel-art retro, sistema de gemas por dificultad, temporizador Pomodoro y calendario de fechas límite.

---

## Captura

| Pantalla principal | Temporizador | Calendario |
|---|---|---|
| Tareas pendientes + footer para crear | Cuenta regresiva Pomodoro | Grid mensual con tareas |

---

## Stack

| Herramienta | Versión | Propósito |
|---|---|---|
| Flutter | 3.44.4 | Framework UI |
| Dart | 3.12.2 | Lenguaje |
| Drift | 2.34.0 | ORM sobre SQLite |
| google_fonts | 6.3.3 | Tipografía Press Start 2P |
| flutter_launcher_icons | 0.14.4 | Icono de launcher |
| DevTools | 2.57.0 | Depuración |

---

## Características

### Gestión de tareas
- Crear tareas con título, dificultad y fecha límite opcional.
- Cada dificultad otorga una cantidad fija de gemas al completarse:

| Dificultad | Gemas |
|---|---|
| Fácil | 1 |
| Intermedio | 3 |
| Difícil | 6 |
| Muy difícil | 12 |

### Temporizador (Pomodoro)
- Las tareas pueden marcarse como **temporizadas**.
- Al tocar una tarea temporizada se abre un diálogo para iniciar la cuenta regresiva.
- Al completar el tiempo, se suman las gemas automáticamente.
- Las tareas no temporizadas se completan al instante desde un diálogo de confirmación.

### Sistema de gemas
- Cada tarea completada suma las gemas correspondientes al contador global.
- Las gemas se muestran en el AppBar con icono PNG personalizado.
- Los valores de gemas se resaltan en color **turquesa** (`#06B6D4`).

### Calendario
- Vista mensual con navegación entre meses.
- Los días que tienen tareas pendientes se marcan con borde amarillo.
- Al seleccionar un día se listan las tareas con fecha límite para esa fecha.

### Sidebar (Drawer)
- Acceso a **Calendario** y **Tareas Completadas**.

### Diseño pixel-art retro
- Tipografía **Press Start 2P** de Google Fonts.
- Paleta oscura con acentos púrpura y bordes marcados.

---

## Paleta de colores

| Token | Color | Muestra |
|---|---|---|
| `primaryColor` | `#7C3AED` | Púrpura |
| `secundaryColor` | `#A78BFA` | Púrpura claro |
| `fontColor` | `#E2E8F0` | Blanco humo |
| `backgraundColor` | `#0F0D1A` | Negro azulado |
| `surfaceColor` | `#1E1B2E` | Gris oscuro |
| `gemColor` | `#06B6D4` | Turquesa (gemas) |
| `timeColor` | `#EAB308` | Amarillo (tiempo) |

---

## Arquitectura del proyecto

```
lib/
├── main.dart                  # Entry point
├── constants/
│   └── app_color.dart         # Paleta de colores
├── components/
│   └── main_appbar.dart       # AppBar reutilizable
├── screens/
│   ├── home_screen.dart       # Pantalla principal + lógica de tareas
│   ├── timer_screen.dart      # Temporizador Pomodoro
│   ├── completed_tasks_screen.dart  # Tareas completadas
│   └── calendar_screen.dart   # Calendario mensual
├── models/
│   └── dificultad.dart        # Enum de dificultades
└── database/
    ├── database.dart          # AppDatabase (Drift)
    └── tables/
        ├── usuario_table.dart
        ├── tarea_table.dart
        ├── recompensa_table.dart
        └── transaccion_table.dart
```

---

## Cómo empezar

### Requisitos
- Flutter SDK 3.44+ ([instalación](https://docs.flutter.dev/get-started/install))
- Dart 3.12+

### Instalación

```bash
# Clonar el repositorio
git clone https://github.com/tuusuario/banco_de_tiempo.git
cd banco_de_tiempo

# Instalar dependencias
flutter pub get

# Generar código de Drift (si se modifican tablas)
dart run build_runner build

# Ejecutar en modo desarrollo
flutter run
```

### Assets

Colocar los siguientes archivos en `assets/`:

| Archivo | Descripción |
|---|---|
| `gema.png` | Icono de gema en el AppBar |
| `logo app.jpeg` | Icono del launcher |

### Icono del launcher

```bash
dart run flutter_launcher_icons
```

---

## Linting

El proyecto sigue las reglas de `package:flutter_lints`:

```bash
flutter analyze
```

No debe mostrar ningún _issue_.

---

## Licencia

Distribuido bajo licencia MIT. Ver `LICENSE` para más información.
