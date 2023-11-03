import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/utils/functions/calculate_result.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/to_liqour.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List<ConsumptionPopUpData> consumtionData;
  final UserData userData;
  final double timeSinceDrinking;
  

  const Result(
      {Key? key,
      required this.consumtionData,
      required this.userData,
      required this.timeSinceDrinking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalLiqourVolume = 0.0;
    for (var data in consumtionData) {
      double? volumeInLiquor = toLiquor(data.unitSign, data.volume, data.units);
      totalLiqourVolume += volumeInLiquor! * data.units!.toDouble();
    }

    if (isSober(
      height: userData.height,
      weight: userData.weight,
      gender: userData.gender,
      alcoholConsumed: totalLiqourVolume,
      timeDifferenceInHours: timeSinceDrinking,
    )) {
      print('sober');
    }
    else{
      print('drunk');
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'hej',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
                'Total Volume: ${totalLiqourVolume.toStringAsFixed(2)} cl liquor'), // Visa den totala volymen
            for (var data in consumtionData)
              Column(
                children: [
                  Text('Image: ${userData.gender}'),
                  Text('Image: ${data.image}'),
                  Text(
                      'Volume: ${toLiquor(data.unitSign, data.volume, data.units)} cl liquor'),
                  Text('Units: ${data.units.toString()}'),
                  SizedBox(height: 20.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
