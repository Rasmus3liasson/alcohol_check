import 'package:flutter/material.dart';

class Sober extends StatelessWidget {

final double bac; 

  const Sober({Key? key, required this.bac}):super(key: key);

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
        const SizedBox(
          height: 80.0,
        ),
        const Text('Det är bara ut o köra 😃',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),)
      ],
    ));
  }
}
