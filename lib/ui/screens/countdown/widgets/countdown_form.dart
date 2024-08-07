import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/countdown.dart';
import 'package:kromo/data/models/remaining_time.dart';
import 'package:kromo/data/utils.dart';
import 'package:kromo/domain/providers/countdowns.dart';
import 'package:kromo/domain/providers/settings.dart';
import 'package:kromo/ui/screens/countdown/widgets/delete_countdown_dialog.dart';

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
            : _remaining.getTimeString());
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
    final double seconds = double.tryParse(_timeCtrl.text) ?? 0.0;
    final int milliseconds = truncateToDecimalPlaces(seconds * 1000, 0).toInt();

    _remaining = RemainingTime(duration: Duration(milliseconds: milliseconds));
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
    _timeCtrl.text = _remaining.getTimeString();

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

  void _delete() {
    showDialog(
      context: context,
      builder: (_) {
        return DeleteCountdownDialog(
          onPressed: () {
            try {
              ref.read(countdownsProvider.notifier).delete(countdown!.id);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Eliminado con éxito'),
                behavior: SnackBarBehavior.floating,
              ));
            } catch (e) {
              log('Falla', error: e);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: const Text('Error al eliminar'),
                behavior: SnackBarBehavior.floating,
              ));
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                hintText: 'Desfase',
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
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: _selectedType == CountdownType.extended
                  ? 'Tiempo'
                  : 'Segundos',
              suffixIcon: const Icon(Icons.timer_outlined),
            ),
            onChanged: (_) => _setTime(),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _save,
            child: const Text('Guardar'),
          ),
          if (editing) ...[
            const SizedBox(height: 16),
            TextButton(
              onPressed: _delete,
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Eliminar'),
            ),
          ]
        ],
      ),
    );
  }
}
