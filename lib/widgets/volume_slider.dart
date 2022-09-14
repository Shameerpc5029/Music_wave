import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
      value: 10,
      onChanged: ((value) {}),
      min: 0,
      max: 100,
    );
  }
}
