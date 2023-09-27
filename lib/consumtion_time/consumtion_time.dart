import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:flutter/material.dart';

class ConsumtionTime extends StatelessWidget {
  final List<ConsumptionPopUpData> consumtionData;

  const ConsumtionTime({required this.consumtionData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alkohol Konsumtion"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Consumtion Data:',
              style: TextStyle(fontSize: 20.0),
            ),
            Column(
              children: consumtionData.map((data) {
                return Column(
                  children: [
                    Text('Image: ${data.image}'),
                    Text('Volume: ${data.volume}'),
                    Text('Units: ${data.units}'),
                    // Add more UI elements to display the data as needed
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
