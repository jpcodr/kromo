import 'package:flutter/material.dart';

class DeleteCountdownDialog extends StatelessWidget {
  const DeleteCountdownDialog({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        'Eliminar',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: const Text(
          '¿Estas seguro de eliminar el registro?'),
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
