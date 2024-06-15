import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/domain/providers/countdowns.dart';
import 'package:kromo/ui/screens/countdown/widgets/countdown_item.dart';

class CountdownList extends ConsumerWidget {
  const CountdownList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdowns = ref.watch(countdownsProvider);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: countdowns.length,
        separatorBuilder: (_, idx) => const SizedBox(height: 16.0),
        itemBuilder: (_, idx) {
          final countdown = countdowns[idx];

          return CountdownItem(countdown: countdown);
        },
      ),
    );
  }
}
