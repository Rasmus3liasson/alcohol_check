// ignore_for_file: prefer_const_constructors

import 'package:alcohol_check/pages/consumtion/consumtion.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user_data.dart';
import 'package:alcohol_check/utils/enums/gender_enum.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Gender gender = Gender.man;
  int height = 0;
  int weight = 0;

  @override
  Widget build(BuildContext context) {
    UserData userData = UserData(
      height: height,
      weight: weight,
      gender: gender,
    );
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: userDetaills(userData),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Padding userDetaills(UserData userData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Vänligen fyll i dina uppgifter:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.w600),
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
                    cursorColor: AppColor.whiteColor,
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
                            borderSide: BorderSide(color: AppColor.whiteColor)),
                        labelText: 'Längd (cm)',
                        labelStyle: TextStyle(color: AppColor.whiteColor)),
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
                    cursorColor: AppColor.whiteColor,
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
                        labelStyle: TextStyle(color: AppColor.whiteColor),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.whiteColor))),
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
            CustomNavigationButton(
                text: 'Vidare',
                widgetNavigation: Consumtion(userData: userData))
        ],
      ),
    );
  }
}
