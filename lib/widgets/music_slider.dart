import 'package:flutter/material.dart';

class MusicSlide extends StatelessWidget {
  const MusicSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
      activeColor: Color.fromARGB(255, 174, 48, 39),
      value: 20,
      onChanged: ((value) {}),
      min: 0,
      max: 100,
    );
  }
}
