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
import 'package:cloud_firestore/cloud_firestore.dart';
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
      if (user == null) {
        return;
      }
      // Create a new object for the result data
      Map<String, dynamic> resultData = {
        'bac_result': bac,
        'date': FieldValue.serverTimestamp(),
        'is_sober': isSober,
      };

      // Get a reference to the user's document
      DocumentReference userDocRef = resultCollection.doc(userId);

      // Add a new document to a subcollection named 'results'
      await userDocRef.collection('results').add(resultData);

      print('Result posted to Firestore successfully!');
    } catch (e) {
      print('Error posting result to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalLiquorVolume = 0.0;
    for (var data in widget.consumtionData) {
      double? volumeInLiquor = toLiquor(data.unitSign, data.volume, data.units);
      totalLiquorVolume += volumeInLiquor! * data.units!.toDouble();
    }

    SoberResult result = isSober(
      height: widget.userData.height,
      weight: widget.userData.weight,
      gender: widget.userData.gender,
      alcoholConsumed: totalLiquorVolume,
      timeDifferenceInHours: widget.timeSinceDrinking,
    );

    postResultToFirestore(accountData!.uid, result.bac, result.isSober);

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
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
