import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/result/result.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:flutter/material.dart';

class ConsumtionTime extends StatefulWidget {
  final List<ConsumptionPopUpData> consumtionData;
  final UserData userData;

  const ConsumtionTime({required this.consumtionData, required this.userData, Key? key})
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Result(consumtionData: widget.consumtionData,userData:widget.userData),
      ),
    );
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
