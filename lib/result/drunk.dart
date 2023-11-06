import 'package:flutter/material.dart';

class Drunk extends StatelessWidget {
  final double bac;

  const Drunk({Key? key, required this.bac}) : super(key: key);

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
         Text('Tyvärr har du alkohol kvar i kroppen vila och tryck en pizza'),
          Text('BAC: $bac'),
        
      ],
    ));
  }
}
