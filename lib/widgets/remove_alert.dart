import 'package:flutter/material.dart';

class RemoveAlert extends StatelessWidget {
  final String title;
  final String contant;
  final void Function() yesPress;
  const RemoveAlert(
      {super.key,
      required this.yesPress,
      required this.title,
      required this.contant});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style:const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        contant,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'No',
          ),
        ),
        TextButton(
          onPressed: yesPress,
          child: const Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
