import 'package:alcohol_check/main.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/pages/result/drunk.dart';
import 'package:alcohol_check/pages/result/sober.dart';
import 'package:alcohol_check/utils/functions/calculate_result.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:alcohol_check/utils/functions/to_liqour.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List<ConsumptionPopUpData> consumtionData;
  final UserData userData;
  final double timeSinceDrinking;

  const Result({
    Key? key,
    required this.consumtionData,
    required this.userData,
    required this.timeSinceDrinking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    double totalLiquorVolume = 0.0;
    for (var data in consumtionData) {
      double? volumeInLiquor = toLiquor(data.unitSign, data.volume, data.units);
      totalLiquorVolume += volumeInLiquor! * data.units!.toDouble();

      print(totalLiquorVolume);
      print(timeSinceDrinking);
    }

    SoberResult result = isSober(
      height: userData.height,
      weight: userData.weight,
      gender: userData.gender,
      alcoholConsumed: totalLiquorVolume,
      timeDifferenceInHours: timeSinceDrinking,
    );
    return Scaffold(
      
    
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             result.isSober ? Sober(bac:result.bac) : Drunk(bac:result.bac),
            

            SizedBox(height: 40.0,),

            CustomNavigationButton(text: 'Tillbaka till hemskärmen', widgetNavigation: MyHomePage())
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
