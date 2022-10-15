import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicSlide extends StatefulWidget {
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
  State<MusicSlide> createState() => _MusicSlideState();
}

class _MusicSlideState extends State<MusicSlide> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      inactiveColor: Colors.white,
      activeColor: Colors.red,
      onChanged: ((value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      }),
      value: widget.position.inSeconds.toDouble(),
      min: const Duration(microseconds: 0).inSeconds.toDouble(),
      max: widget.duration.inSeconds.toDouble(),
    );
  }

  void changeToSecond(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
