import 'dart:convert';

import 'package:alcohol_check/models/account_data.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/pages/result/drunk.dart';
import 'package:alcohol_check/pages/result/sober.dart';
import 'package:alcohol_check/pages/start/start.dart';
import 'package:alcohol_check/utils/functions/calculate_result.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:alcohol_check/utils/functions/to_liqour.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  final List<ConsumptionPopUpData> consumtionData;
  final UserData userData;
  final double timeSinceDrinking;

  const Result({
    Key? key,
    required this.consumtionData,
    required this.userData,
    required this.timeSinceDrinking,
  }) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  AccountData? accountData;
  User? user = FirebaseAuth.instance.currentUser;
  SoberResult? result;

  @override
  void initState() {
    super.initState();

    if (user != null) {
      loadPref();
    }

    double totalLiquorVolume = 0.0;
    for (var data in widget.consumtionData) {
      double? volumeInLiquor = toLiquor(data.unitSign, data.volume, data.units);
      if (volumeInLiquor != null && data.units != null) {
        totalLiquorVolume += volumeInLiquor * data.units!.toDouble();
      }
    }

    result = isSober(
      height: widget.userData.height,
      weight: widget.userData.weight,
      gender: widget.userData.gender,
      alcoholConsumed: totalLiquorVolume,
      timeDifferenceInHours: widget.timeSinceDrinking,
    );
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefResult = prefs.getString('userResult');

    if (prefResult != null) {
      Map<String, dynamic> userResultMap = jsonDecode(prefResult);

      setState(() {
        accountData = AccountData.fromJson(userResultMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (result != null && result!.isSober)
                Sober(bac: result!.bac)
              else
                Drunk(bac: result!.bac),
              const SizedBox(
                height: 40.0,
              ),
              const CustomNavigationButton(
                text: 'Tillbaka till hemskärmen',
                widgetNavigation: StartScreen(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
