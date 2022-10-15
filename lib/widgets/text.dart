import 'package:flutter/material.dart';


class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String titleText;

  const SubTitle({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
      ),
    );
  }
}

