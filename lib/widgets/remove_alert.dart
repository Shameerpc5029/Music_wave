import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RemoveAlert extends StatelessWidget {
  const RemoveAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Remove?'),
      content: Text('Do You Remove?'),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Yes'),
        ),
      ],
    );
  }
}
