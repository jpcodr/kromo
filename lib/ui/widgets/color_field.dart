import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorField extends ConsumerStatefulWidget {
  const ColorField({
    super.key,
    required this.color,
    this.enabled = true,
    required this.onColorChanged,
  });

  final Color? color;
  final bool enabled;
  final void Function(Color?) onColorChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColorFieldState();
}

class _ColorFieldState extends ConsumerState<ColorField> {
  late Color selectedColor;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.color ?? Colors.white;
    _controller = TextEditingController(
        text:
            '${ColorTools.nameThatColor(selectedColor)} (#${selectedColor.hex})');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enabled,
      canRequestFocus: false,
      decoration: InputDecoration(
        hintText: 'Selecciona un color',
        suffix: SizedBox(
          height: 20.0,
          width: 20.0,
          child: Stack(
            children: [
              ColorIndicator(
                color: selectedColor,
                borderRadius: 0,
              ),
              if (!widget.enabled)
                Container(
                  color: Colors.black.withOpacity(0.7),
                )
            ],
          ),
        ),
      ),
      controller: _controller,
      onTap: () async {
        final previousColor = selectedColor;
        bool selected = await ColorPicker(
          color: selectedColor,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.both: false,
            ColorPickerType.primary: false,
            ColorPickerType.accent: false,
            ColorPickerType.bw: false,
            ColorPickerType.custom: false,
            ColorPickerType.wheel: true,
          },
          enableShadesSelection: false,
          onColorChanged: (value) {
            setState(() {
              selectedColor = value;
              _controller.text =
                  '${ColorTools.nameThatColor(value)} (${value.hex})';
            });
          },
        ).showPickerDialog(context,
            title: const Text(
              'Selecciona un color',
              textAlign: TextAlign.center,
            ),
            titlePadding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            constraints: const BoxConstraints(minWidth: 300));
        widget.onColorChanged.call(selected ? selectedColor : null);
        if (!selected) {
          setState(() {
            selectedColor = previousColor;
          });
        }
      },
    );
  }
}
