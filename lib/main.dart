// ignore_for_file: prefer_const_constructors

import 'package:alcohol_check/consumtion/consumtion.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:flutter/material.dart';
import 'models/user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Information',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String gender = 'Man';
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vänligen fyll i dina uppgifter:',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.0),
            // Height input field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    int? parsedHeight = int.tryParse(value);
                    if (parsedHeight != null) {
                      height = parsedHeight;
                    }
                  });
                },
                decoration: InputDecoration(labelText: 'Längd (cm)'),
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            // Weight input field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    int? parsedWeight = int.tryParse(value);
                    if (parsedWeight != null) {
                      weight = parsedWeight;
                    }
                  });
                },
                decoration: InputDecoration(labelText: 'Vikt (kg)'),
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 14.0),
            // Gender dropdown
            DropdownButton<String>(
              value: gender,
              onChanged: (newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: <String>['Man', 'Kvinna', 'Annat']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                UserData(
                  height: height,
                  weight: weight,
                  gender: gender,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Consumtion(),
                  ),
                );
              },
              child: Text(
                'Gå vidare',
                style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
