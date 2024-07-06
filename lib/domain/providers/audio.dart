import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundpool/soundpool.dart';

import 'package:kromo/domain/providers/countdowns.dart';
import 'package:kromo/domain/providers/settings.dart';

final audioProvider =
    AsyncNotifierProvider<AudioNotifier, bool>(AudioNotifier.new);

class AudioNotifier extends AsyncNotifier<bool> {
  Soundpool? _player;
  final SoundpoolOptions _options =
      const SoundpoolOptions(streamType: StreamType.music);
  int? _soundId;
  int? _soundStreamId;

  @override
  FutureOr<bool> build() async {
    try {
      ref.watch(settingsProvider.select((settings) => settings.counterBeeps));
      ref.watch(countdownsProvider);
      ref.onDispose(() {
        _player?.dispose();
      });

      _player = Soundpool.fromOptions(options: _options);
      final ByteData soundData = await rootBundle.load('assets/audio/beep.mp3');
      _soundId = await _player!.load(soundData);
      // await _player!.setVolume(soundId: _soundId, volume: 0.0);
      // _soundStreamId = await _player!.play(_soundId!);
      // await _player!.setVolume(soundId: _soundId!, volume: 1.0);

      return true;
    } catch (e) {
      log('', error: e);
    }
    return true;
  }

  Future<void> play() async {
    if (_soundId != null) {
      _soundStreamId = await _player?.play(_soundId!);
      // log('SOUND STREAM ID: $_soundStreamId');
    }
  }

  Future<void> stop() async {
    if (_soundStreamId != null) {
      _player?.stop(_soundStreamId!);
    }
  }
}
