import 'package:just_audio/just_audio.dart';

class SoundPlayer {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String assetPath = '';

  SoundPlayer(this.assetPath);

  Future<void> play() async {
    if (isPlaying) {
      return;
    }
    isPlaying = true;
    await audioPlayer.setAsset(assetPath);
    await audioPlayer.play();
    isPlaying = false;
  }
}
