import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioProvider =
    AsyncNotifierProvider<AudioNotifier, bool>(AudioNotifier.new);

class AudioNotifier extends AsyncNotifier<bool> {
  late final AudioPlayer _player;

  @override
  FutureOr<bool> build() async {
    _player = AudioPlayer();
    await _player.setSource(AssetSource('audio/beep.mp3'));
    return true;
  }

  void play() {
    _player.resume();
  }

  void stop() {
    _player.stop();
  }
}
