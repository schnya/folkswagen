import 'package:flutter/material.dart';
import 'package:volkswagen/colors.dart';

class Window extends StatelessWidget {
  const Window({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          color: color1[900],
          height: size.height * 186 / 1000,
        ),
        Container(
          decoration: BoxDecoration(color: color1[900], boxShadow: shadow),
          height: size.height * 13 / 1000,
        ),
      ],
    );
  }
}
