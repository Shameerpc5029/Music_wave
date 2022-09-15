import 'package:flutter/material.dart';


class ScaffoldEdited extends StatelessWidget {
  final Widget body;
  const ScaffoldEdited({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          174,
          48,
          39,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: body,
    );
  }
}
