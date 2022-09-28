import 'package:flutter/material.dart';

class RemoveAlert extends StatelessWidget {
  const RemoveAlert({super.key});

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
          onPressed: () {
            //data
          },
          child: const Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
