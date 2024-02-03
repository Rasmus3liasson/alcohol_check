import 'dart:convert';

import 'package:alcohol_check/main.dart';
import 'package:alcohol_check/models/account_data.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/pages/result/drunk.dart';
import 'package:alcohol_check/pages/result/sober.dart';
import 'package:alcohol_check/utils/functions/calculate_result.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:alcohol_check/utils/functions/to_liqour.dart';
// Assuming you have these imports
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final CollectionReference resultCollection =
      FirebaseFirestore.instance.collection('user');

  @override
  void initState() {
    super.initState();
    loadPref();
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

Future<void> postResultToFirestore(
    String userId, double bac, bool isSober) async {
  try {
    await resultCollection.doc(userId).set({
      'bac_result': bac,
      'date': FieldValue.serverTimestamp(),
      'is_sober': isSober,
    });
    print('Result posted to Firestore successfully!');
  } catch (e) {
    print('Error posting result to Firestore: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    double totalLiquorVolume = 0.0;
    for (var data in widget.consumtionData) {
      double? volumeInLiquor =
          toLiquor(data.unitSign, data.volume, data.units);
      totalLiquorVolume += volumeInLiquor! * data.units!.toDouble();
    }

    SoberResult result = isSober(
      height: widget.userData.height,
      weight: widget.userData.weight,
      gender: widget.userData.gender,
      alcoholConsumed: totalLiquorVolume,
      timeDifferenceInHours: widget.timeSinceDrinking,
    );

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            result.isSober ? Sober(bac: result.bac) : Drunk(bac: result.bac),
            const SizedBox(
              height: 40.0,
            ),
            const CustomNavigationButton(
              text: 'Tillbaka till hemskärmen',
              widgetNavigation: MyApp(),
            ),
            ElevatedButton(
              onPressed: () {
                if (accountData != null) {
                  postResultToFirestore(
                    accountData!.uid,
                    result.bac,
                    result.isSober,
                  );
                } else {
                  print('User data not available');
                }
              },
              child: const Text('Post Result to Firestore'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
