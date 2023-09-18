// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'user_data.dart';

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
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Vänligen fyll i dina uppgifter:',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            // Height input field
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  int? parsedHeight = int.tryParse(value);
                  if (parsedHeight != null) {
                    height = parsedHeight;
                  }
                });
              },
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            SizedBox(height: 14),
            // Weight input field
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  int? parsedWeight = int.tryParse(value);
                  if (parsedWeight != null) {
                    weight = parsedWeight;
                  }
                });
              },
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            SizedBox(height: 14),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final userData = UserData(
                  height: height,
                  weight: weight,
                  gender: gender,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NextScreen(userData: userData),
                  ),
                );
              },
              child: Text('Gå vidare'),
            ),
          ],
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  final UserData userData;

  NextScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alcohol Konsumtion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            
             Text(userData.height.toString(), style: TextStyle(fontSize: 16)),
             Text(userData.weight.toString(), style: TextStyle(fontSize: 16)),
             Text(userData.gender.toString(), style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
