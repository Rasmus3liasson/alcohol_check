import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:flutter/material.dart';

class ChoosenConsumtion extends StatelessWidget {
  final ConsumptionPopUpData consumtionData;

  ChoosenConsumtion({required this.consumtionData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      child: Column(
        children: [
   
          SizedBox(
            height: 20.0,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    consumtionData.image,
                    width: 100.0,
                    height: 100.0,
                  ),
                  Column(
                    children: [
                      if (consumtionData.volume != null)
                        Text(
                          "${consumtionData.volume} ${consumtionData.unitSign}",
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                        ),
                      Text(
                        "Mängd: ${consumtionData.units} enheter/glas",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
