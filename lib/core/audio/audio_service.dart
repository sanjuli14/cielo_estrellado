import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  bool _isMuted = false;

  AudioService() {
    _player.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> playBackgroundMusic(String assetPath) async {
    try {
      await _player.play(AssetSource(assetPath));
    } catch (e) {
      print('Error playing background music: $e');
    }
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _player.setVolume(_isMuted ? 0 : 1.0);
  }

  bool get isMuted => _isMuted;

  void dispose() {
    _player.dispose();
  }
}
