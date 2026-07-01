import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../models/dificultad.dart';
import '../models/task.dart';

Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Cerrar dialogo',
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




Future<(Dificultad, DateTime?, bool, bool)?> showCreateTaskDialog(BuildContext context) {
  return showAnimatedDialog<(Dificultad, DateTime?, bool, bool)>(
    context: context,
    builder: (ctx) {
      Dificultad selected = Dificultad.facil;
      DateTime? deadline;
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
                  const SizedBox(height: 8),
                  const Divider(color: AppColor.secundaryColor),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: temporizada,
                        onChanged: (v) => setDialogState(() => temporizada = v ?? false),
                        activeColor: AppColor.timeColor,
                        checkColor: AppColor.backgraundColor,
                        side: BorderSide(
                          color: AppColor.timeColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Tarea temporizada',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: esHabito,
                        onChanged: (v) => setDialogState(() => esHabito = v ?? false),
                        activeColor: AppColor.gemColor,
                        checkColor: AppColor.backgraundColor,
                        side: BorderSide(
                          color: AppColor.gemColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'Habito atomico\n(se repite diariamente)',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(
                          ctx,
                          (selected, deadline, temporizada, esHabito),
                        ),
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
                            color: AppColor.secundaryColor.withValues(alpha: 0.5),
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

Future<String?> showNamePromptDialog(BuildContext context) {
  return showAnimatedDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      final controller = TextEditingController();
      String? name;

      return StatefulBuilder(
        builder: (ctx, setDialogState) => Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
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
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bienvenido!',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Como te llamas?',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Tu nombre...',
                      hintStyle: const TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(
                          color: AppColor.secundaryColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: BorderSide(
                          color: AppColor.secundaryColor.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: AppColor.secundaryColor,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                    onChanged: (v) => setDialogState(() => name = v.trim()),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (name != null && name!.isNotEmpty) {
                        Navigator.pop(ctx, name);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: name != null && name!.isNotEmpty
                          ? AppColor.primaryColor
                          : AppColor.primaryColor.withValues(alpha: 0.5),
                      foregroundColor: AppColor.fontColor,
                      side: BorderSide(
                        color: name != null && name!.isNotEmpty
                            ? AppColor.secundaryColor
                            : AppColor.secundaryColor.withValues(alpha: 0.3),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: const Text('Comenzar', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<(String, Dificultad, DateTime?, bool, bool)?> showEditTaskDialog(
  BuildContext context,
  Task task,
) {
  return showAnimatedDialog<(String, Dificultad, DateTime?, bool, bool)>(
    context: context,
    builder: (ctx) {
      Dificultad selected = task.dificultad;
      DateTime? deadline = task.fechaLimite;
      bool temporizada = task.temporizada;
      bool esHabito = task.esHabito;
      final titleController = TextEditingController(text: task.titulo);

      return StatefulBuilder(
        builder: (ctx, setDialogState) => Center(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Editar tarea',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Titulo...',
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                            color: AppColor.secundaryColor.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(
                            color: AppColor.secundaryColor.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                          borderSide: const BorderSide(
                            color: AppColor.secundaryColor,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    ...Dificultad.values.map(
                      (d) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
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
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: '${d.name} - ',
                                style: const TextStyle(fontSize: 13),
                                children: [
                                  TextSpan(
                                    text: '${d.gemas} gemas',
                                    style: TextStyle(
                                      fontSize: 13,
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: ctx,
                            initialDate: deadline ?? DateTime.now(),
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
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: temporizada,
                          onChanged: esHabito ? null : (v) => setDialogState(() => temporizada = v ?? false),
                          activeColor: AppColor.timeColor,
                          checkColor: AppColor.backgraundColor,
                          side: BorderSide(
                            color: AppColor.timeColor.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            esHabito ? 'Tarea temporizada (no aplica)' : 'Tarea temporizada',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: esHabito,
                          onChanged: (v) => setDialogState(() => esHabito = v ?? false),
                          activeColor: AppColor.gemColor,
                          checkColor: AppColor.backgraundColor,
                          side: BorderSide(
                            color: AppColor.gemColor.withValues(alpha: 0.5),
                            width: 2,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Habito atomico\n(se repite diariamente)',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final title = titleController.text.trim();
                            if (title.isEmpty) return;
                            Navigator.pop(
                              ctx,
                              (title, selected, deadline, temporizada, esHabito),
                            );
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
                          ),
                          child: const Text(
                            'Guardar',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
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
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
    builder: (ctx) => Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
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
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Listo para empezar\nla tarea?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                taskTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secundaryColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
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
                    child: const Text('Si', style: TextStyle(fontSize: 13)),
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
                    child: const Text('No', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> showHabitAlreadyDoneDialog(BuildContext context, int racha) {
  return showAnimatedDialog(
    context: context,
    builder: (ctx) => Card(
      margin: const EdgeInsets.all(16),
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
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Ya completaste\neste habito hoy!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              'Racha: $racha ${racha == 1 ? 'dia' : 'dias'}',
              style: TextStyle(
                color: AppColor.gemColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
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
              child: const Text('OK', style: TextStyle(fontSize: 13)),
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
      margin: const EdgeInsets.all(16),
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
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Completar habito?',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              titulo,
              style: TextStyle(
                color: AppColor.secundaryColor,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Te daran $gemas gemas',
              style: TextStyle(
                color: AppColor.gemColor,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 12),
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
                  child: const Text('Si', style: TextStyle(fontSize: 13)),
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
                  child: const Text('No', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<int?> showBuyRestTimeDialog(BuildContext context, int gemasDisponibles) {
  return showAnimatedDialog<int>(
    context: context,
    builder: (ctx) {
      int gemasGastar = 1;

      return StatefulBuilder(
        builder: (ctx, setDialogState) => Card(
          margin: const EdgeInsets.all(24),
          elevation: 12,
          shadowColor: Colors.black87,
          color: AppColor.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: BorderSide(
              color: AppColor.gemColor.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Comprar tiempo libre',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tienes $gemasDisponibles gemas disponibles',
                  style: const TextStyle(fontSize: 11),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cada gema = 3 minutos de descanso',
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: gemasGastar > 1
                          ? () => setDialogState(() => gemasGastar--)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColor.fontColor,
                        side: BorderSide(
                          color: AppColor.secundaryColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                      child: const Icon(Icons.remove, size: 18),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$gemasGastar',
                      style: const TextStyle(fontSize: 40, color: AppColor.gemColor),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: gemasGastar < gemasDisponibles
                          ? () => setDialogState(() => gemasGastar++)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColor.fontColor,
                        side: BorderSide(
                          color: AppColor.secundaryColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        padding: const EdgeInsets.all(8),
                      ),
                      child: const Icon(Icons.add, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: 'Descanso: ',
                    style: const TextStyle(fontSize: 13),
                    children: [
                      TextSpan(
                        text: '${gemasGastar * 3} min',
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColor.timeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, gemasGastar),
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
                      child: const Text('Canjear', style: TextStyle(fontSize: 15)),
                    ),
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
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<bool?> showTaskCompleteDialog(BuildContext context, String titulo) {
  return showAnimatedDialog<bool>(
    context: context,
    builder: (ctx) => Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
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
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Marcar como completada?',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.secundaryColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
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
                    child: const Text('Si', style: TextStyle(fontSize: 13)),
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
                    child: const Text('No', style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
