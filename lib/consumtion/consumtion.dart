import 'package:alcohol_check/consumtion/choosen_consumtion.dart';
import 'package:alcohol_check/consumtion/consumtion_pop_up.dart';
import 'package:alcohol_check/models/alcohol_data.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:flutter/material.dart';

class Consumtion extends StatefulWidget {
  @override
  _ConsumtionState createState() => _ConsumtionState();
}

class _ConsumtionState extends State<Consumtion> {
  List<ConsumptionPopUpData> consumtionList = [];

  Future<void> openConsumptionPopUp(
      BuildContext context, AlcoholData liqour) async {
    ConsumptionPopUpData? consumtionData =
        await ConsumptionPopUp.showPopUp(context, liqour);

    if (consumtionData != null) {
      setState(() {
        consumtionList.add(consumtionData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alkohol Konsumtion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: alcoholDataList.map((liqour) {
                return GestureDetector(
                  onTap: () {
                    openConsumptionPopUp(context, liqour); // Call the method
                  },
                  child: Card(
                    child: Image.asset(
                      liqour.image,
                      width: 120.0,
                      height: 120.0,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Text(
                  "Din Konsumntion",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0,
                  ),
                ),
                if (consumtionList.isNotEmpty)
                // Convert to a list with the spread operator
                  ...consumtionList.map((consumtionData) {
                    return ChoosenConsumtion(consumtionData: consumtionData);
                  }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
