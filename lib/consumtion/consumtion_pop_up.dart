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
  int? volume;
  int? units;
  late String unitSign = "";

  late String labelVolume;
  String labelUnits = "Hur många enheter av denna vara";

  @override
  void initState() {
    super.initState();

    int id = widget.alcoholData.iD;

    // Set labelVolume and units based on id
    if (dataBasedOnId.containsKey(id)) {
      labelVolume = dataBasedOnId[id]!['label']!;
      unitSign = dataBasedOnId[id]!['unit']!;

      if (widget.alcoholData.volume != null) {
        volume = widget.alcoholData.volume![0];
        labelUnits = 'Hur många enheter?';
      }
    }
  }

  Map<int, Map<String, String>> dataBasedOnId = {
    1: {
      'label': 'Vilken volym på enheten?',
      'unit': 'cl',
    },
    3: {
      'label': 'Vilken procent på spriten var det?',
      'unit': '%',
    },
  };

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
          if (widget.alcoholData.volume != null)
            Column(
              children: [
                Text(labelVolume),
                DropdownButton<int>(
                  value: volume,
                  onChanged: (int? newValue) {
                    setState(() {
                      volume = newValue;
                    });
                  },
                  items: (widget.alcoholData.volume ?? []).map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('${value.toString()} ${unitSign}'),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text(labelUnits),
                DropdownButton<int>(
                  value: units,
                  onChanged: (int? newValue) {
                    setState(() {
                      units = newValue;
                    });
                  },
                  items: (widget.alcoholData.units).map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
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
