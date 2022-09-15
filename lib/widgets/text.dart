import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      style: GoogleFonts.sarala(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  final String titleText;

  const SubTitle({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: GoogleFonts.sarala(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black45,
      ),
    );
  }
}

class HeadingTextthin extends StatelessWidget {
  final String titleText;
  const HeadingTextthin({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: GoogleFonts.sarala(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
