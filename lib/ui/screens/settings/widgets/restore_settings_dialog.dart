import 'package:flutter/material.dart';

class RestoreSettingsDialog extends StatelessWidget {
  const RestoreSettingsDialog({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        'Reestablecer',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: const Text(
          '¿Estas seguro de reestablecer las configuraciones a sus valores por defecto?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          style: FilledButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          onPressed: () {
            onPressed?.call();
            Navigator.of(context).pop();
          },
          child: const Text('Aceptar'),
        )
      ],
    );
  }
}
