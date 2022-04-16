import 'package:flutter/material.dart';
import 'package:volkswagen/colors.dart';

class Bumper extends StatelessWidget {
  const Bumper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.25),
            offset: const Offset(.0, -6.0),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18.0)),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'hoge'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'hoge'),
          ],
          backgroundColor: color1[900],
        ),
      ),
    );
  }
}
