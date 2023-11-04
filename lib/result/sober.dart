import 'package:flutter/material.dart';

class Sober extends StatelessWidget {
  const Sober({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Transform.scale(
            scale: 2.0,
            child: Image.asset(
              'assets/images/car.gif',
            )),
        SizedBox(
          height: 80.0,
        ),
        const Text('Det är bara ut o köra')
      ],
    ));
  }
}
