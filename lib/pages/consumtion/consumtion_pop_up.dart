import 'package:alcohol_check/models/alcohol_data.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class ConsumptionPopUp extends StatefulWidget {
  final AlcoholData alcoholData;

  const ConsumptionPopUp({super.key, required this.alcoholData});

  static Future<ConsumptionPopUpData?> showPopUp(
      BuildContext context, AlcoholData alcoholData) async {
    return await showDialog<ConsumptionPopUpData>(
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
  late String unitSign;

  late String labelVolume;
  late String labelUnits;

  @override
  void initState() {
    super.initState();

    int iD = widget.alcoholData.iD;

    // Set labelVolume and units based on id
    if (stringBasedOnId.containsKey(iD)) {
      labelVolume = stringBasedOnId[iD]!['label']!;
      unitSign = stringBasedOnId[iD]!['unit']!;
    } else {
      unitSign = '';
    }

    labelUnits =
        (iD == 2) ? 'Hur många glas?' : 'Hur många enheter av denna vara';

    // Null check since id 2 dont have volume
    if (widget.alcoholData.volume != null) {
      volume = widget.alcoholData.volume![0];
    }
    units = widget.alcoholData.units[0];
  }

  Map<int, Map<String, String>> stringBasedOnId = {
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: AppColor.blackColorLighter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.cancel_outlined),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Image.asset(
              widget.alcoholData.image,
              width: 350.0,
              height: 350.0,
            ),
            const SizedBox(height: 16.0),
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
                    items: (widget.alcoholData.volume)?.map((value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('${value.toString()} $unitSign'),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            Column(
              children: [
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
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.purpleColor,
                padding: const EdgeInsets.all(18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                ConsumptionPopUpData resultData = ConsumptionPopUpData(
                  image: widget.alcoholData.image,
                  volume: volume,
                  units: units ?? 0,
                  unitSign: unitSign,
                );

                Navigator.of(context).pop(resultData);
              },
              child: const Text("Lägg till"),
            ),
            const SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }
}
