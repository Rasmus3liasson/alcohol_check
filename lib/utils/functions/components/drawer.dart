import 'dart:convert';

import 'package:alcohol_check/main.dart';
import 'package:alcohol_check/models/account_data.dart';
import 'package:alcohol_check/models/history_data.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:alcohol_check/utils/functions/user_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AccountData? userResult;
  List<HistoryData?> historyData = [];

  @override
  void initState() {
    super.initState();
    getUserResult();
  }

  Future<void> setHistoryData() async {
    List<HistoryData>? retrievedData = await getUserData();

    setState(() {
      historyData = retrievedData;
    });
  }

  Future<void> getUserResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefResult = prefs.getString('userResult');
    if (prefResult != null) {
      Map<String, dynamic> userResultMap = jsonDecode(prefResult);

      setState(() {
        userResult = AccountData.fromJson(userResultMap);
      });
    }
    setHistoryData();
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userResult');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MyApp()));
  }

  Widget SignOutButtonWidget(BuildContext context) {
  if (userResult != null && userResult!.uid.isNotEmpty) {
    return GestureDetector(
      onTap: () async {
        await signOut(context);
      },
      child: const Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
        child: ListTile(
          trailing: Icon(
            Icons.logout,
            color: AppColor.blackColor,
            size: 50.0,
          ),
        ),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 340.0,
      backgroundColor: AppColor.whiteColor,
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: userResult != null && userResult!.uid.isNotEmpty
                    ? UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(
                          color: AppColor.blackColor,
                        ),
                        accountName: Text(userResult!.name),
                        accountEmail: Text(userResult!.email),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(userResult!.photoURL),
                        ),
                        onDetailsPressed: () async {
                          await signOut(context);
                        },
                      )
                    : const DrawerHeader(
                        decoration: BoxDecoration(color: AppColor.blackColor),
                        child: Center(
                          child: Text(
                            'Historik',
                            style: TextStyle(fontSize: 35.0),
                          ),
                        )),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: userResult != null
                      ? ListView(
                          scrollDirection: Axis.vertical,
                          children: historyData.isEmpty
                              ? [
                                  const Center(
                                    child: Text(
                                      'Kunde inte hitta någon historik',
                                      style: TextStyle(
                                        color: AppColor.blackColor,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ]
                              : (historyData).map((entry) {
                                  return ListTile(
                                    title: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 30.0),
                                      decoration: BoxDecoration(
                                        color: AppColor.blackColor,
                                        shape: BoxShape.rectangle,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.greyColor
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              DateFormat('dd/MM-yy')
                                                  .format(entry!.date),
                                              style: const TextStyle(
                                                color: AppColor.whiteColor,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 20.0),
                                            Text(
                                              'Promile: ${entry.bacResult}',
                                              style: const TextStyle(
                                                color: AppColor.whiteColor,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ), 
                                    ),
                                  );
                                }).toList(),
                        )
                      : const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Du måste logga in för att se historik',
                            style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              SignOutButtonWidget(context)
            ]),
      ),
    );
  }
}
