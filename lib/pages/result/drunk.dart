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
          const SizedBox(
            height: 80.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal:50.0),
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text(
                    'Tyvärr har du alkohol kvar i kroppen. Vila och ät en pizza',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0,),
                Text(
                  'Din estimerade prommile är: $bac',
                  style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
