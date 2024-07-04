import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/ui/screens/countdown/countdown_list.dart';
import 'package:kromo/ui/screens/settings/settings.dart';
import 'package:kromo/ui/widgets/kromo_countdown.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
      ),
      body: const KromoCountdown(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => const CountdownList(),
            ),
          );
        },
        child: const Icon(Icons.timer_outlined),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            const Spacer(),
            Consumer(builder: (_, ref, __) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => SettingsScreen(),
                  ));
                },
                icon: const Icon(Icons.settings),
              );
            })
          ],
        ),
      ),
    );
  }
}
