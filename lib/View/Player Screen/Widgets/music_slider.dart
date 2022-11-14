import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicSlide extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final Duration position;
  final Duration duration;

  const MusicSlide({
    super.key,
    required this.position,
    required this.duration,
    required this.audioPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      inactiveColor: Colors.white,
      activeColor: Colors.red,
      onChanged: ((value) {
        changeToSecond(value.toInt());
        value = value;
      }),
      value: position.inSeconds.toDouble(),
      min: const Duration(microseconds: 0).inSeconds.toDouble(),
      max: duration.inSeconds.toDouble(),
    );
  }

  void changeToSecond(int seconds) {
    Duration duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
}
