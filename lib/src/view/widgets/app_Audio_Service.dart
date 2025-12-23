import 'package:audioplayers/audioplayers.dart';

class AppAudioService {
  static final AppAudioService _instance = AppAudioService._internal();
  factory AppAudioService() => _instance;

  late final AudioPlayer _player;

  AppAudioService._internal() {
    _player = AudioPlayer();
    _player.setReleaseMode(.loop);
  }

  Future<void> startBackgroundSound() async {
    await _player.play(AssetSource('sounds/Sunny Little Dance (1).mp3'));
  }

  Future<void> stopBackgroundSound() async {
    await _player.stop();
  }
}
