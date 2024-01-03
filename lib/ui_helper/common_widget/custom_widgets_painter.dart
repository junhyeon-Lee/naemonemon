import 'package:flutter/material.dart';

class RankingSmallTag extends CustomPainter {

  const RankingSmallTag(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(getPath(size.width, size.height), paint);
  }

  Path getPath(double x, double y) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(x, y)
      ..lineTo(x / 2, y / 60 * 35)
      ..lineTo(0, y)
      ..close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RankingBigTag extends CustomPainter {
  const RankingBigTag(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(getPath(size.width, size.height), paint);
  }

  Path getPath(double x, double y) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(x, y)
      ..lineTo(x / 2, y / 80 * 45)
      ..lineTo(0, y)
      ..close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


class RankingSmallSupport extends CustomPainter {
  const RankingSmallSupport(this.color, this.left);

  final Color color;
  final bool? left;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(getPath(size.width, size.height), paint);
  }


  Path getPath(double x, double y) {
    Path path = Path();
    if(left==null){
      path..moveTo(x, y)
        ..lineTo(0 , y)
        ..lineTo(x/120*22, 0)
        ..lineTo(x/120*98, 0)
        ..close();
    } else if(left!){
        path..moveTo(x, 0)
        ..lineTo(x, y)
        ..lineTo(0, y)
        ..lineTo(x / 100*22, 0)
        ..close();
    }else{
        path..moveTo(x, y)
        ..lineTo(0, y)
        ..lineTo(0, 0)
        ..lineTo (x/100*78 , 0)
        ..close();
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
