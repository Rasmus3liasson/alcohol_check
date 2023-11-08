// ignore_for_file: prefer_const_constructors

import 'package:alcohol_check/pages/consumtion/consumtion.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'models/user_data.dart';
import 'package:alcohol_check/utils/enums/gender_enum.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:alcohol_check/utils/constans/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Information',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Gender gender = Gender.man;
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
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.blackColor,
                      onChanged: (value) {
                        setState(() {
                          int? parsedHeight = int.tryParse(value);
                          if (parsedHeight != null) {
                            height = parsedHeight;
                          }
                        });
                      },
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.blackColor)),
                          labelText: 'Längd (cm)',
                          labelStyle: TextStyle(color: AppColor.blackColor)),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  if (height.toString().length == 3)
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                ],
              ),
            ),
            SizedBox(height: 14.0),
            // Weight input field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColor.blackColor,
                      onChanged: (value) {
                        setState(() {
                          int? parsedWeight = int.tryParse(value);
                          if (parsedWeight != null) {
                            weight = parsedWeight;
                          }
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Vikt (kg)',
                          labelStyle: TextStyle(color: AppColor.blackColor),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColor.blackColor))),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  if (weight.toString().length == 2 ||
                      weight.toString().length == 3)
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                ],
              ),
            ),
            SizedBox(height: 14.0),
            // Gender dropdown
            DropdownButton<Gender>(
              value: gender,
              onChanged: (newValue) {
                setState(() {
                  gender = newValue!;
                });
              },
              items: Gender.values
                  .map<DropdownMenuItem<Gender>>(
                    (Gender value) => DropdownMenuItem<Gender>(
                      value: value,
                      child: Text(
                        '${value.toString().split('.').last[0].toUpperCase()}${value.toString().split('.').last.substring(1)}',
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20.0),

            if (height > 0 && weight > 0)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blackColor,
                  padding: EdgeInsets.all(18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  UserData userData = UserData(
                    height: height,
                    weight: weight,
                    gender: gender,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Consumtion(userData: userData),
                    ),
                  );
                },
                child: Text(
                  'Gå vidare',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
