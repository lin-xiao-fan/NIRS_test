import 'package:flutter/material.dart';

class LShapeClipper extends CustomClipper<Path> {
  final double w;
  final double h;
  final int index;
  final double expW;
  final double expH;

  LShapeClipper({required this.w, required this.h, required this.index, required this.expW, required this.expH});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double r = 20.0;

    double dx = size.width * index / 8.clamp(0, size.width);
    double dy = 0.0.clamp(0, size.height);

    path.moveTo(dx + r, dy);
    path.lineTo(dx + w - r, dy);

    path.quadraticBezierTo(dx + w, dy, dx + w, dy + r);
    if (index == 7) {
      path.lineTo(expW, dy + h + expH - r);
    } else {
      path.lineTo(dx + w, dy + h - r);
      path.quadraticBezierTo(dx + w, dy + h, dx + w + r, dy + h);
      path.lineTo(expW - r, dy + h);
      path.quadraticBezierTo(expW, dy + h, expW, dy + h + r);
    }
    path.lineTo(expW, dy + h + expH);
    path.lineTo(0, dy + h + expH);

    if (index == 0) {
      path.lineTo(0, dy + r);
      path.quadraticBezierTo(0, 0, r, 0);
    } else {
      path.lineTo(0, dy + h + r);
      path.quadraticBezierTo(0, dy + h, r, dy + h);
      path.lineTo(dx - r, dy + h);
      path.quadraticBezierTo(dx, dy + h, dx, dy + h - r);
      path.lineTo(dx, dy + r);
      path.quadraticBezierTo(dx, dy, dx + r, dy);
    }
    path.close();

    return path;
  }

  @override
  bool shouldReclip(LShapeClipper oldClipper) {
    return true;
  }
}

//
// path.moveTo(dx, 0);
// path.lineTo(dx, dy);
// path.lineTo(dx + itemWidth, dy + itemHeight);
// path.lineTo(dx, dy + itemHeight);
