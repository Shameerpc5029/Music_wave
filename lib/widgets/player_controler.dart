import 'package:flutter/material.dart';

class PlayerController extends StatelessWidget {
  final dynamic icon;
  final int size;
  final void Function() buttonAction;

  const PlayerController({
    super.key,
    this.icon,
    required this.size,
    required this.buttonAction,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonAction,
      icon: icon,
    );
  }
}
