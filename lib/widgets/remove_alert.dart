import 'package:flutter/material.dart';

class RemoveAlert extends StatelessWidget {
  final void Function() yesPress;
  const RemoveAlert({super.key, required this.yesPress});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Remove?',
      ),
      content: const Text(
        'Do You Want to Remove Playlist?',
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
