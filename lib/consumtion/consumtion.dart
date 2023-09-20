import 'package:alcohol_check/consumtion/consumtion_pop_up.dart';
import 'package:alcohol_check/models/alcohol_data.dart';
import 'package:flutter/material.dart';

class Consumtion extends StatelessWidget {
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
                    ConsumptionPopUp.showPopUp(context, liqour);
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
            )
          ],
        ),
      ),
    );
  }
}
