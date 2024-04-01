import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TCustomCurvedEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    final firstCurve = Offset(0, size.height - 20);
    final larstCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, larstCurve.dx, larstCurve.dy);
    final secondFirstCurve = Offset(0, size.height - 20);
    final secondLarstCurve = Offset(30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLarstCurve.dx, secondLarstCurve.dy);
    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdSecondLarstCurve = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdSecondLarstCurve.dx, thirdSecondLarstCurve.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
