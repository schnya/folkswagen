import 'package:flutter/material.dart';
import 'package:volkswagen/colors.dart';

class NumberPlate extends StatelessWidget {
  const NumberPlate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color1[100]!, width: 2.0),
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        boxShadow: [
          BoxShadow(
            color: color1[100]!.withOpacity(.25),
            offset: const Offset(.0, 3.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      width: 100,
      height: 35,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(primary: color1[900]),
        child: Text('upG', style: TextStyle(color: color1[100])),
      ),
    );
  }
}
