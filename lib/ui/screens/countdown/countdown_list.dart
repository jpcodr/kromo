import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kromo/data/models/countdown.dart';

import 'package:kromo/domain/providers/countdowns.dart';
import 'package:kromo/ui/screens/countdown/widgets/countdown_form_sheet.dart';
import 'package:kromo/ui/screens/countdown/widgets/countdown_item.dart';

class CountdownList extends ConsumerWidget {
  const CountdownList({super.key});

  void _showSheet(BuildContext context, [Countdown? countdown]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
        ),
        child: CountdownFormSheet(countdown: countdown),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdowns = ref.watch(countdownsProvider);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSheet(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: countdowns.length,
        separatorBuilder: (_, idx) => const SizedBox(height: 16.0),
        itemBuilder: (_, idx) {
          final countdown = countdowns[idx];

          return CountdownItem(
            countdown: countdown,
            onPressed: (c) => _showSheet(context, c),
          );
        },
      ),
    );
  }
}
