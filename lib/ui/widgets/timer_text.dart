import 'package:flutter/material.dart';

class TimerText extends StatelessWidget {
  const TimerText({
    super.key,
    required this.text,
    this.width = 20.0,
    this.style,
  });

  final String text;
  final double width;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: text
          .split('')
          .map(
            (el) => SizedBox(
              width: int.tryParse(el) != null ? width : 10.0,
              child: Text(
                el,
                style: style,
                textAlign: TextAlign.center,
              ),
            ),
          )
          .toList(),
    );
  }
}
