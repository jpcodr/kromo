import 'package:flutter/material.dart';

class ControlledTextField extends StatefulWidget {
  const ControlledTextField({
    super.key,
    this.enabled = true,
    this.keyboardType,
    this.onChanged,
    this.value,
  });

  final bool enabled;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? value;

  @override
  State<ControlledTextField> createState() => _ControlledTextFieldState();
}

class _ControlledTextFieldState extends State<ControlledTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ControlledTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _controller.text = widget.value ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
    );
  }
}
