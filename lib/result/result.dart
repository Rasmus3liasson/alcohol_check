import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List<ConsumptionPopUpData> consumtionData;
  final UserData userData;

  const Result({Key? key, required this.consumtionData,required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "hej",
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0), 
            for (var data in consumtionData)
              Column(
              
                children: [
                  Text('Image: ${userData.gender}'),
                  Text('Image: ${data.image}'),
                  Text('Volume: ${data.volume.toString()}'), // Assuming volume is a number
                  Text('Units: ${data.units.toString()}'),   // Assuming units is a number
                  SizedBox(height: 20.0), // Add spacing between data entries
                ],
              ),
          ],
        ),
      ),
    );
  }
}
