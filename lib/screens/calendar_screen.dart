import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import 'home_screen.dart';

class CalendarScreen extends StatefulWidget {
  final List<Task> tasks;

  const CalendarScreen({super.key, required this.tasks});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    _selectedDate = DateTime.now();
  }

  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  int _daysInMonth(DateTime month) {
    return DateTime(month.year, month.month + 1, 0).day;
  }

  List<int?> _buildDayGrid() {
    final daysInMonth = _daysInMonth(_currentMonth);
    final firstWeekday = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday;
    final grid = <int?>[];

    for (var i = 1; i < firstWeekday; i++) {
      grid.add(null);
    }
    for (var day = 1; day <= daysInMonth; day++) {
      grid.add(day);
    }
    while (grid.length % 7 != 0) {
      grid.add(null);
    }
    return grid;
  }

  bool _hasTasksOnDate(DateTime date) {
    return widget.tasks.any((t) {
      if (t.completada || t.fechaLimite == null) return false;
      final dl = t.fechaLimite!;
      return dl.year == date.year &&
          dl.month == date.month &&
          dl.day == date.day;
    });
  }

  List<Task> _tasksForDate(DateTime date) {
    return widget.tasks.where((t) {
      if (t.completada || t.fechaLimite == null) return false;
      final dl = t.fechaLimite!;
      return dl.year == date.year &&
          dl.month == date.month &&
          dl.day == date.day;
    }).toList();
  }

  static const _dayHeaders = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final grid = _buildDayGrid();
    final monthNames = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
    ];
    final monthName = monthNames[_currentMonth.month - 1];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario', style: TextStyle(fontSize: 18)),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.fontColor,
      ),
      body: Container(
        color: AppColor.backgraundColor,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _prevMonth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColor.secundaryColor,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                            side: BorderSide(
                              color: AppColor.secundaryColor.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        child: const Icon(Icons.chevron_left),
                      ),
                      Text(
                        '$monthName ${_currentMonth.year}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      ElevatedButton(
                        onPressed: _nextMonth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColor.secundaryColor,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                            side: BorderSide(
                              color: AppColor.secundaryColor.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                        child: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: _dayHeaders.map((h) => Expanded(
                      child: Text(
                        h,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColor.secundaryColor.withValues(alpha: 0.7),
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(grid.length ~/ 7, (weekIndex) {
                    final weekStart = weekIndex * 7;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: List.generate(7, (dayIndex) {
                          final day = grid[weekStart + dayIndex];
                          if (day == null) {
                            return const Expanded(child: SizedBox());
                          }
                          final cellDate = DateTime(
                            _currentMonth.year,
                            _currentMonth.month,
                            day,
                          );
                          final isSelected = cellDate == _selectedDate;
                          final hasTasks = _hasTasksOnDate(cellDate);

                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                                border: hasTasks && !isSelected
                                    ? Border.all(
                                        color: AppColor.timeColor.withValues(alpha: 0.6),
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: ElevatedButton(
                                onPressed: () => setState(() => _selectedDate = cellDate),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: isSelected
                                      ? AppColor.fontColor
                                      : hasTasks
                                          ? AppColor.timeColor
                                          : AppColor.fontColor.withValues(alpha: 0.6),
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                child: Text(
                                  '$day',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                        hasTasks ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const Divider(color: AppColor.secundaryColor),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tareas para ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}:',
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  ...(() {
                    final dayTasks = _tasksForDate(_selectedDate);
                    if (dayTasks.isEmpty) {
                      return [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Sin tareas pendientes',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.secundaryColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ];
                    }
                    return dayTasks.map((t) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Card(
                        color: AppColor.surfaceColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                          side: BorderSide(
                            color: AppColor.secundaryColor.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.titulo,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(height: 4),
                                    Text.rich(
                                      TextSpan(
                                        text: '${t.dificultad.name} - ',
                                        style: TextStyle(
                                          color: AppColor.secundaryColor,
                                          fontSize: 11,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '${t.dificultad.gemas} gemas',
                                            style: TextStyle(
                                              color: AppColor.gemColor,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.radio_button_unchecked,
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  }()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
