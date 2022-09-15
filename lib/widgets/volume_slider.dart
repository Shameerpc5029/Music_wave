import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Slider.adaptive(
        activeColor: Colors.red,
        inactiveColor: Colors.black38,
        value: 30,
        onChanged: ((value) {}),
        max: 100,
      ),
    );
  }
}
