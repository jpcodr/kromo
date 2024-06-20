import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/countdown.dart';
import 'package:kromo/data/models/remaining_time.dart';
import 'package:kromo/domain/providers/countdowns.dart';
import 'package:kromo/domain/providers/settings.dart';
import 'package:kromo/ui/widgets/keyboard_dismiss.dart';

class CountdownForm extends ConsumerStatefulWidget {
  const CountdownForm({
    super.key,
    this.countdown,
  });

  final Countdown? countdown;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountdownFormState();
}

class _CountdownFormState extends ConsumerState<CountdownForm> {
  Countdown? get countdown => widget.countdown;
  bool get editing => countdown != null;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _timeCtrl;
  late final TextEditingController _tFrameCtrl;
  late final TextEditingController _cFrameCtrl;
  late final TextEditingController _gapCtrl;
  late CountdownType _selectedType;
  late RemainingTime _remaining;
  int _gap = 0, _currentGap = 0;

  @override
  void initState() {
    super.initState();
    final targetFrame = countdown?.targetFrame ?? 0;
    _gap = _currentGap = countdown?.gap ?? 0;
    _remaining = RemainingTime(duration: countdown?.duration ?? Duration.zero);
    _nameCtrl = TextEditingController(text: countdown?.name);
    _timeCtrl = TextEditingController(
        text: _remaining.duration.inMicroseconds == 0
            ? null
            : '${_remaining.seconds}.${_remaining.hundreds}');
    _tFrameCtrl = TextEditingController(
        text: targetFrame > 0 ? targetFrame.toString() : null);
    _cFrameCtrl = TextEditingController();
    _gapCtrl = TextEditingController(text: _gap != 0 ? '$_gap' : null);
    _selectedType = countdown?.type ?? CountdownType.simple;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _tFrameCtrl.dispose();
    _cFrameCtrl.dispose();
    _timeCtrl.dispose();
    _gapCtrl.dispose();
    super.dispose();
  }

  void _setTime() {
    final int seconds = int.tryParse(_timeCtrl.text) ?? 0;
    _remaining = RemainingTime(duration: Duration(seconds: seconds));

    setState(() {});
  }

  void _calculateTime() {
    final double fps = ref.read(settingsProvider).frameRate;
    final int tFrame = int.tryParse(_tFrameCtrl.text) ?? 0;
    final int cFrame = int.tryParse(_cFrameCtrl.text) ?? 0;
    int time = ((tFrame / fps) * 1000).truncate();
    _currentGap = _gap + (cFrame != 0 ? tFrame - cFrame : 0);

    if (_currentGap != 0) {
      _gapCtrl.text = _currentGap.toString();
      time = (((tFrame + _currentGap) / fps) * 1000).truncate();
    }

    _remaining = RemainingTime(duration: Duration(milliseconds: time));
    _timeCtrl.text = '${_remaining.seconds}.${_remaining.hundreds}';

    setState(() {});
  }

  void _clearGap() {
    _gap = 0;
    _gapCtrl.clear();
    _calculateTime();
  }

  void _save() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    ref.read(countdownsProvider.notifier).save(
          Countdown(
            duration: _remaining.duration,
            gap: _currentGap,
            id: editing ? countdown!.id : null,
            name: _nameCtrl.text.isEmpty ? null : _nameCtrl.text,
            targetFrame: int.tryParse(_tFrameCtrl.text) ?? 0,
            type: _selectedType,
          ),
          countdown?.id,
        );

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Cuenta guardada'),
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismiss(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SegmentedButton<CountdownType>(
                segments: [
                  ButtonSegment<CountdownType>(
                    value: CountdownType.simple,
                    label: const Text('Simple'),
                    enabled: !editing,
                  ),
                  ButtonSegment<CountdownType>(
                    value: CountdownType.extended,
                    label: const Text('Avanzado'),
                    enabled: !editing,
                  ),
                ],
                selected: <CountdownType>{_selectedType},
                onSelectionChanged: (Set<CountdownType> newSelection) =>
                    setState(() {
                  _selectedType = newSelection.first;
                }),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                ),
              ),
              const SizedBox(height: 16),
              if (_selectedType == CountdownType.extended) ...[
                TextFormField(
                  controller: _tFrameCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Frame objetivo',
                  ),
                  onChanged: (value) => _calculateTime(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: !editing,
                  enabled: editing,
                  controller: _cFrameCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Frame alcanzado',
                  ),
                  onChanged: (value) => _calculateTime(),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _gapCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Defase',
                    suffixIcon: IconButton(
                      onPressed: _clearGap,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                readOnly: _selectedType == CountdownType.extended,
                enabled: _selectedType != CountdownType.extended,
                controller: _timeCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: 'Segundos',
                  suffixText: 'seg',
                ),
                onChanged: (_) => _setTime(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _save,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
