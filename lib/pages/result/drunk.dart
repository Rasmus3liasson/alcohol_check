import 'package:flutter/material.dart';

class Drunk extends StatelessWidget {
  final double bac;

  const Drunk({super.key, required this.bac});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 3.0,
            child: Image.asset('assets/images/bed.png'),
          ),
          SizedBox(
            height: 80.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:50.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'Tyvärr har du alkohol kvar i kroppen. Vila och ät en pizza',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'Din estimerade prommile är: $bac',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
