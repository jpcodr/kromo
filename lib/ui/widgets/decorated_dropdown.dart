import 'package:flutter/material.dart';

class DecoratedDropdown extends StatelessWidget {
  const DecoratedDropdown({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: child,
      ),
    );
  }
}
