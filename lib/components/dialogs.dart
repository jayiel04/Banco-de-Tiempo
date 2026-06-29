import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/dificultad.dart';

Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  return showGeneralDialog<T>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(
          opacity: animation,
          child: builder(context),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 350),
  );
}

Widget _buildToggleButton({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: selected ? AppColor.secundaryColor : Colors.transparent,
      foregroundColor: selected ? AppColor.backgraundColor : AppColor.secundaryColor,
      side: BorderSide(
        color: selected ? AppColor.fontColor : AppColor.secundaryColor.withValues(alpha: 0.5),
        width: 2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    ),
    child: Text(label, style: const TextStyle(fontSize: 13)),
  );
}

Future<(Dificultad, DateTime?)?> showDifficultyDialog(BuildContext context) {
  return showAnimatedDialog<(Dificultad, DateTime?)>(
    context: context,
    builder: (ctx) {
      Dificultad selected = Dificultad.facil;
      DateTime? deadline;

      return StatefulBuilder(
        builder: (ctx, setDialogState) => Card(
          margin: const EdgeInsets.all(24),
          elevation: 12,
          shadowColor: Colors.black87,
          color: AppColor.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: AppColor.secundaryColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selecciona la dificultad',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                ...Dificultad.values.map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => setDialogState(() => selected = d),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selected == d
                              ? AppColor.secundaryColor
                              : AppColor.primaryColor,
                          foregroundColor: selected == d
                              ? AppColor.backgraundColor
                              : AppColor.fontColor,
                          side: BorderSide(
                            color: selected == d
                                ? AppColor.fontColor
                                : AppColor.secundaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text.rich(
                          TextSpan(
                            text: '${d.name} - ',
                            style: const TextStyle(fontSize: 15),
                            children: [
                              TextSpan(
                                text: '${d.gemas} gemas',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColor.gemColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(color: AppColor.secundaryColor),
                const SizedBox(height: 8),
                const Text(
                  'Fecha limite',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: ctx,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                      );
                      if (date != null) {
                        setDialogState(() => deadline = date);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: AppColor.fontColor,
                      side: const BorderSide(
                        color: AppColor.secundaryColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      deadline != null
                          ? '${deadline!.day}/${deadline!.month}/${deadline!.year}'
                          : 'Seleccionar fecha',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                if (deadline != null) ...[
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => setDialogState(() => deadline = null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.red.shade300,
                        side: BorderSide(
                          color: Colors.red.shade300.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      child: const Text(
                        'Quitar fecha',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, (selected, deadline)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        foregroundColor: AppColor.fontColor,
                        side: const BorderSide(
                          color: AppColor.secundaryColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColor.secundaryColor,
         side: BorderSide(
           color: AppColor.timeColor.withValues(alpha: 0.5),
           width: 2,
         ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<(bool, bool)?> showTaskConfigDialog(BuildContext context) {
  return showAnimatedDialog<(bool, bool)>(
    context: context,
    builder: (ctx) {
      bool temporizada = false;
      bool esHabito = false;

      return StatefulBuilder(
        builder: (ctx, setDialogState) => Card(
          margin: const EdgeInsets.all(24),
          elevation: 12,
          shadowColor: Colors.black87,
          color: AppColor.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: AppColor.secundaryColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Configuracion de la tarea',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Es una tarea temporizada?',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToggleButton(
                      label: 'Si',
                      selected: temporizada,
                      onTap: () => setDialogState(() => temporizada = true),
                    ),
                    _buildToggleButton(
                      label: 'No',
                      selected: !temporizada,
                      onTap: () => setDialogState(() => temporizada = false),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Es un habito atomico?\n(se repite diariamente)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToggleButton(
                      label: 'Si',
                      selected: esHabito,
                      onTap: () => setDialogState(() => esHabito = true),
                    ),
                    _buildToggleButton(
                      label: 'No',
                      selected: !esHabito,
                      onTap: () => setDialogState(() => esHabito = false),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, (temporizada, esHabito)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.fontColor,
                    side: const BorderSide(
                      color: AppColor.secundaryColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('Confirmar', style: TextStyle(fontSize: 15)),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.secundaryColor,
                    side: BorderSide(
                      color: AppColor.secundaryColor.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('Cancelar', style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<bool?> showTimerStartDialog(BuildContext context, String taskTitle) {
  return showAnimatedDialog<bool>(
    context: context,
    builder: (ctx) => Card(
      margin: const EdgeInsets.all(24),
      elevation: 12,
      shadowColor: Colors.black87,
      color: AppColor.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(
          color: AppColor.secundaryColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Listo para empezar\nla tarea?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              taskTitle,
              style: TextStyle(
                color: AppColor.secundaryColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.fontColor,
                    side: const BorderSide(
                      color: AppColor.secundaryColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('Si', style: TextStyle(fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.secundaryColor,
                    side: BorderSide(
                      color: AppColor.secundaryColor.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('No', style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> showHabitAlreadyDoneDialog(BuildContext context, int racha) {
  return showAnimatedDialog(
    context: context,
    builder: (ctx) => Card(
      margin: const EdgeInsets.all(24),
      elevation: 12,
      shadowColor: Colors.black87,
      color: AppColor.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(
          color: AppColor.timeColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ya completaste\neste habito hoy!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Racha: $racha ${racha == 1 ? 'dia' : 'dias'}',
              style: TextStyle(
                color: AppColor.gemColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: AppColor.fontColor,
                side: const BorderSide(
                  color: AppColor.secundaryColor,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child: const Text('OK', style: TextStyle(fontSize: 15)),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<bool?> showHabitConfirmDialog(BuildContext context, String titulo, int gemas) {
  return showAnimatedDialog<bool>(
    context: context,
    builder: (ctx) => Card(
      margin: const EdgeInsets.all(24),
      elevation: 12,
      shadowColor: Colors.black87,
      color: AppColor.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(
          color: AppColor.secundaryColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Completar habito?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              titulo,
              style: TextStyle(
                color: AppColor.secundaryColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Te daran $gemas gemas',
              style: TextStyle(
                color: AppColor.gemColor,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.fontColor,
                    side: const BorderSide(
                      color: AppColor.secundaryColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('Si', style: TextStyle(fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.secundaryColor,
                    side: BorderSide(
                      color: AppColor.secundaryColor.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('No', style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<bool?> showTaskCompleteDialog(BuildContext context, String titulo) {
  return showAnimatedDialog<bool>(
    context: context,
    builder: (ctx) => Card(
      margin: const EdgeInsets.all(24),
      elevation: 12,
      shadowColor: Colors.black87,
      color: AppColor.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: BorderSide(
          color: AppColor.secundaryColor.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Marcar como completada?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              titulo,
              style: TextStyle(
                color: AppColor.secundaryColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.fontColor,
                    side: const BorderSide(
                      color: AppColor.secundaryColor,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('Si', style: TextStyle(fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.secundaryColor,
                    side: BorderSide(
                      color: AppColor.secundaryColor.withValues(alpha: 0.5),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Text('No', style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
