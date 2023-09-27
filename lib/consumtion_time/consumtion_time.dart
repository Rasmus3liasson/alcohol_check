import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/result/result.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:flutter/material.dart';

class ConsumtionTime extends StatefulWidget {
  final List<ConsumptionPopUpData> consumtionData;

  const ConsumtionTime({required this.consumtionData, Key? key})
      : super(key: key);

  @override
  _ConsumtionTimeState createState() => _ConsumtionTimeState();
}

class _ConsumtionTimeState extends State<ConsumtionTime> {
  TimeOfDay? startDrinkTime;
  TimeOfDay? endDrinkTime;
  bool state = false;

  bool isLoading = false; // Track loading state

  Future<void> timeInput(BuildContext context) async {
    final TimeOfDay? choice = await showTimePicker(
      context: context,
      initialTime: !state
          ? startDrinkTime ?? TimeOfDay.now()
          : endDrinkTime ?? TimeOfDay.now(),
    );

    if (choice != null) {
      setState(() {
        if (!state) {
          startDrinkTime = choice;
        } else {
          endDrinkTime = choice;
        }
      });
     
    }
  }

  Future<void> showResult() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });

    Navigator.push(context, MaterialPageRoute(builder: (context) => Result()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Consumtion Data:',
                  style: TextStyle(fontSize: 20.0),
                ),
                Column(
                  children: widget.consumtionData.map((data) {
                    return Column(
                      children: [
                        Text('Image: ${data.image}'),
                        Text('Volume: ${data.volume}'),
                        Text('Units: ${data.units}'),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.0),
                (endDrinkTime == null)
                    ? ElevatedButton(
                        onPressed: () async {
                          await timeInput(context);
                          setState(() {
                            state = true;
                          });
                        },
                        child: Text(!state ? "Start tid" : "Slut tid"),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          showResult(); 
                        },
                        child: Text("Se Resultat"),
                      ),
              ],
            ),
          ),
          // Container for loading
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
