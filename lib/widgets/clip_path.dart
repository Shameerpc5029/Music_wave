import 'package:flutter/material.dart';



class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height - 30);

    var start = Offset(size.width / 6, size.height);
    var end = Offset(size.width / 2, size.height - 90);
    path.quadraticBezierTo(start.dx, start.dy, end.dx, end.dy);

    var secondstart = Offset(size.width, size.height - 220);
    var secondend = Offset(size.width, size.height - 90);
    path.quadraticBezierTo(
        secondstart.dx, secondstart.dy, secondend.dx, secondend.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
