import 'package:flutter/material.dart';

class Drunk extends StatelessWidget {
  const Drunk({super.key});

  @override
  Widget build(BuildContext context) {
 return Center(
        child: Column(
      children: <Widget>[
        Transform.scale(
            scale: 3.0,
            child: Image.asset(
              'assets/images/bed.png',
            )),
        SizedBox(
          height: 80.0,
        ),
        const Text('Tyvärr har du alkohol kvar i kroppen vila och tryck en pizza')
      ],
    ));
  }
}
