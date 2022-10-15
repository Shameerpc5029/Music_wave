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
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        contant,
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(
                255,
                174,
                48,
                39,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'No',
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(
                255,
                174,
                48,
                39,
              ),
            ),
          ),
          onPressed: yesPress,
          child: const Text(
            'Yes',
          ),
        ),
      ],
    );
  }
}
