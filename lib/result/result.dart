import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Result Widget Example"),
      ),
      body: Result(),
    ),
  ));
}

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          "hej",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
