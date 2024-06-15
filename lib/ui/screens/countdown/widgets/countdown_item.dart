import 'package:flutter/material.dart';
import 'package:kromo/data/models/countdown.dart';
import 'package:kromo/data/models/remaining_time.dart';

class CountdownItem extends StatelessWidget {
  const CountdownItem({
    super.key,
    required this.countdown,
    this.onPressed,
  });

  final Countdown countdown;
  final void Function(Countdown)? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleStyle = textTheme.titleLarge!;
    final remaining = RemainingTime(duration: countdown.duration);

    return ListTile(
      isThreeLine: countdown.type == CountdownType.extended,
      tileColor: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onTap: () => onPressed?.call(countdown),
      title: Padding(
        padding: countdown.type == CountdownType.extended
            ? const EdgeInsets.only(bottom: 8.0)
            : EdgeInsets.zero,
        child: Text(
          countdown.name ?? 'ID: ${countdown.id}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: countdown.name != null
              ? titleStyle
              : titleStyle.copyWith(
                  fontStyle: countdown.type == CountdownType.extended
                      ? null
                      : FontStyle.italic,
                  color: titleStyle.color?.withOpacity(0.5),
                ),
        ),
      ),
      subtitle: countdown.type == CountdownType.simple
          ? null
          : Text(
              'Frame objetivo: ${countdown.targetFrame ?? '-'}\nFrame alcanzado: ${countdown.currentFrame ?? '-'}'),
      trailing: Text(
        '${remaining.seconds}.${remaining.hundreds}',
        style: textTheme.titleLarge,
      ),
    );
  }
}
