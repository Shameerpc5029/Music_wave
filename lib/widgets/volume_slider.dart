import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.volume_up,
          color: Colors.red,
        ),
        SizedBox(
          width: 300,
          child: Slider.adaptive(
            activeColor: Colors.red,
            value: 30,
            onChanged: ((value) {}),
            max: 100,
          ),
        ),
      ],
    );
  }
}
