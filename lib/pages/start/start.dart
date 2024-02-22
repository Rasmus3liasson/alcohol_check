import 'package:alcohol_check/pages/person_details/person_details.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Välkommen till Alcohol Check!',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 10.0),
          Text('För att komma igång, klicka på start',
              style: TextStyle(
                fontSize: 20.0,
              )),
          SizedBox(height: 40.0),
          CustomNavigationButton(
            text: 'Start',
            widgetNavigation: PersonDeatils(),
          ),
        ],
      )),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
