import 'package:alcohol_check/models/alcohol_data.dart';
import 'package:flutter/material.dart';

class ConsumptionPopUp extends StatefulWidget {
  final AlcoholData alcoholData;

  ConsumptionPopUp({required this.alcoholData});

  static void showPopUp(BuildContext context, AlcoholData alcoholData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConsumptionPopUp(alcoholData: alcoholData);
      },
    );
  }

  @override
  _ConsumptionPopUpState createState() => _ConsumptionPopUpState();
}

class _ConsumptionPopUpState extends State<ConsumptionPopUp> {
  AlcoholData? selectedAlcoholData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            widget.alcoholData.image,
            width: 120.0,
            height: 120.0,
          ),
          SizedBox(height: 16.0),
          DropdownButton<AlcoholData>(
            value: selectedAlcoholData,
            onChanged: (AlcoholData? newValue) {
              setState(() {
                selectedAlcoholData = newValue;
              });
            },
            items: <DropdownMenuItem<AlcoholData>>[
              DropdownMenuItem<AlcoholData>(
                value: widget.alcoholData,
                child: Text(
                  widget.alcoholData.volume.toString()),
              ),
              
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Stäng'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        
      ],
    );
  }
}
