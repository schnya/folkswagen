import 'package:flutter/material.dart';

const ColorSwatch color1 = ColorSwatch(
  500,
  <int, Color>{
    100: Color(0xFF3D3B40),
    500: Color(0xFF9BD9CF),
    900: Color(0xFFF3F5F2),
  },
);

final List<BoxShadow> shadow = [
  const BoxShadow(
    color: Colors.white,
    offset: Offset(.0, -3.0),
    blurRadius: 3.0,
  ),
  BoxShadow(
    color: color1[100]!.withOpacity(.25),
    offset: const Offset(.0, 6.0),
    blurRadius: 6.0,
  ),
];
