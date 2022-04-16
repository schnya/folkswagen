import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:volkswagen/colors.dart';
import 'package:volkswagen/widget/window_frame.dart';

class Window extends StatelessWidget {
  const Window({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width,
          height: size.height / 5,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: .98,
              // autoPlay: true,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    color: color1[900],
                    width: size.width,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.amber),
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'text $i',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              );
            }).toList()
              ..add(Builder(builder: (context) => const WindowFrame())),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: color1[900], boxShadow: shadow),
          height: size.height * 13 / 1000,
        ),
      ],
    );
  }
}
