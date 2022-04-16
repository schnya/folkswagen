import 'package:flutter/material.dart';
import 'package:volkswagen/colors.dart';

class WindowFrame extends StatelessWidget {
  const WindowFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Size size = MediaQuery.of(context).size;
    final double clipWidth1 = 13 + 89 * size.width / 390;
    final double clipWidth2 = 13 + 100 * size.width / 390;
    final double clipWidth4 = 42 * size.width / 390;
    return Row(
      children: [
        ClipPath(
          clipper: WindowClipper1(),
          child: Container(
            width: clipWidth1,
            height: size.height,
            decoration: BoxDecoration(color: color1[900]),
          ),
        ),
        ClipPath(
          clipper: WindowClipper2(),
          child: Container(
            width: clipWidth2,
            height: size.height,
            decoration: BoxDecoration(color: color1[900]),
          ),
        ),
        ClipPath(
          clipper: WindowClipper3(),
          child: Container(
            width: clipWidth2,
            height: size.height,
            decoration: BoxDecoration(color: color1[900]),
          ),
        ),
        ClipPath(
          clipper: WindowClipper4(),
          child: Container(
            width: clipWidth4,
            height: size.height,
            decoration: BoxDecoration(color: color1[900]),
          ),
        ),
        Expanded(child: Container(color: color1[900], height: size.height)),
      ],
    );
  }
}

class WindowClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(26, 13, 89 - 13, size.height * 170 / 199),
          topLeft: const Radius.circular(18.0),
          topRight: const Radius.circular(18.0),
          bottomRight: const Radius.circular(18.0),
        ),
      )
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..moveTo(26, 26)
      ..lineTo(13, size.height * 170 / 199)
      ..arcToPoint(
        Offset(26, 13 + size.height * 170 / 199),
        radius: const Radius.circular(18.0),
        clockwise: false,
      )
      ..close()
      ..fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class WindowClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(13, 13, 100, size.height * 170 / 199),
          const Radius.circular(18.0),
        ),
      )
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class WindowClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(13, 13, 100 - 13, size.height * 170 / 199),
          topLeft: const Radius.circular(18.0),
          topRight: const Radius.circular(18.0),
          bottomLeft: const Radius.circular(18.0),
        ),
      )
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..moveTo(size.width - 13, 26)
      ..lineTo(size.width, size.height * 170 / 199)
      ..arcToPoint(
        Offset(size.width - 13, 13 + size.height * 170 / 199),
        radius: const Radius.circular(18.0),
      )
      ..close()
      ..fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class WindowClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(13, 13, 27, size.height * 151 / 199),
          topRight: const Radius.circular(18.0),
          bottomRight: const Radius.circular(18.0),
          bottomLeft: const Radius.circular(18.0),
        ),
      )
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..moveTo(0, 26)
      ..arcToPoint(const Offset(13, 13), radius: const Radius.circular(18.0))
      ..lineTo(13, size.height * 151 / 199)
      ..close()
      ..fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
