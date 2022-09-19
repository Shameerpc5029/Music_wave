import 'package:flutter/material.dart';

class PlayerController extends StatelessWidget {
  final dynamic icons;

  final double size;
  final void Function() buttonAction;

  const PlayerController({
    super.key,
    required this.icons,
    required this.buttonAction,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50,
            ),
            side: const BorderSide(
              color: Colors.red,
            ),
          ),
        ),
      ),
      onPressed: () {
        buttonAction;
      },
      child: Icon(
        icons,
        size: size,
        color: Colors.red,
      ),
    );
  }
}
