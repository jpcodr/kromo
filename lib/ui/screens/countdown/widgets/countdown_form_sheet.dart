import 'package:flutter/material.dart';

import 'package:kromo/data/models/countdown.dart';
import 'package:kromo/ui/screens/countdown/widgets/countdown_form.dart';

class CountdownFormSheet extends StatelessWidget {
  const CountdownFormSheet({
    super.key,
    this.countdown,
  });

  final Countdown? countdown;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${countdown == null ? 'Añadir' : 'Actualizar'} cuenta',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: CloseButton(),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            CountdownForm(countdown: countdown),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
