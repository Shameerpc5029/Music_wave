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
        'Do You Remove?',
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'No',
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
