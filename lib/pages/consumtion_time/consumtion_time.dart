import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/pages/result/result.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class ConsumtionTime extends StatefulWidget {
  final List<ConsumptionPopUpData> consumtionData;
  final UserData userData;

  const ConsumtionTime({
    required this.consumtionData,
    required this.userData,
    Key? key,
  }) : super(key: key);

  @override
  _ConsumtionTimeState createState() => _ConsumtionTimeState();
}

class _ConsumtionTimeState extends State<ConsumtionTime> {
  TimeOfDay? startDrinkTime;
  TimeOfDay? endDrinkTime;
  bool state = false;
  bool invalidTiem = false;

  bool isLoading = false; // Track loading state

  Future<void> timeInput(BuildContext context) async {
    final TimeOfDay? choice = await showTimePicker(
      context: context,
      initialTime: !state
          ? startDrinkTime ?? TimeOfDay.now()
          : endDrinkTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.greyColor,
              onPrimary: AppColor.whiteColor,
              surface: AppColor.blackColor,
              onSurface: AppColor.purpleColor,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
      helpText: 'Välj tid',
      cancelText: 'Stäng',
      confirmText: 'OK',
      initialEntryMode: TimePickerEntryMode.input,
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

    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      isLoading = false;
    });

    double timeSinceDrinking = calculateTimeSinceDrinking(
        endDrinkTime); // Calculate time since drinking

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Result(
          consumtionData: widget.consumtionData,
          userData: widget.userData,
          timeSinceDrinking: timeSinceDrinking,
        ),
      ),
    );
  }

  double calculateTimeSinceDrinking(TimeOfDay? endDrinkTime) {
    if (endDrinkTime == null) {
      return 0.0;
    }

    final now = DateTime.now();
    final endTime = DateTime(
      now.year,
      now.month,
      now.day,
      endDrinkTime.hour,
      endDrinkTime.minute,
    );

    final timeDifference = now.difference(endTime);

    final hoursDifference = timeDifference.inHours;
    final minutesDifference =
        (timeDifference.inMinutes - hoursDifference * 60) / 60.0;

    return hoursDifference + minutesDifference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      startDrinkTime == null
                          ? 'Välj tid'
                          : 'Starttid: ${startDrinkTime.toString().substring(10, 15)}',
                      style: const TextStyle(fontSize: 30.0),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      endDrinkTime == null
                          ? ''
                          : 'Sluttid: ${endDrinkTime.toString().substring(10, 15)}',
                      style: const TextStyle(fontSize: 30.0),
                    ),
                    const SizedBox(height: 50.0),
                    (endDrinkTime == null)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.purpleColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 40.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () async {
                              await timeInput(context);
                              setState(() {
                                state = true;
                              });
                            },
                            child: Text(
                              !state ? "Start tid" : "Slut tid",
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.purpleColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 40.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              showResult();
                            },
                            child: const Text("Se Resultat",
                                style: TextStyle(fontSize: 24.0)),
                          ),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                  color: AppColor.blackColor.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
