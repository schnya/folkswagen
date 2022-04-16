import 'package:flutter/material.dart';
import 'package:volkswagen/colors.dart';

class Roof extends StatelessWidget {
  const Roof({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Size size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color1[900],
          border: Border(
            bottom: BorderSide(
              color: color1[100]!,
              width: 8.0,
            ),
          ),
        ),
        margin: const EdgeInsets.only(top: 8.0),
        width: size.width,
        height: 64,
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = 3 * 13.0; //曲線の高さ

    Path path = Path()
      ..moveTo(0, curveHeight)
      ..lineTo(size.width / 5, curveHeight)
      ..quadraticBezierTo(
        size.width / 2,
        0,
        size.width * 4 / 5,
        curveHeight,
      )
      ..lineTo(size.width, curveHeight)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close(); //最初の位置まで戻る

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
