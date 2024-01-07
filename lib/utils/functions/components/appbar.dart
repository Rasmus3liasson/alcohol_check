import 'dart:convert';

import 'package:alcohol_check/models/account_data.dart';
import 'package:alcohol_check/utils/functions/google.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showArrow;

  const CustomAppBar({Key? key, this.showArrow = false}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  AccountData? accountData;

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefResult = prefs.getString('userResult');
    if (prefResult == null) {
      setState(() {
        accountData = null;
      });
    } else {
      Map<String, dynamic> userResultMap = jsonDecode(prefResult);
      setState(() {
        accountData = AccountData.fromJson(userResultMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Nyckerhets Kontroll",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: widget.showArrow
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
            )
          : null,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: accountData == null
                ? IconButton(
                    onPressed: () async {
                      Map<String, dynamic> data = await signInGoogle();
                      if (data['result'] != null) {
                        setState(() {
                          accountData = data['result'];
                        });

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                            'userResult', jsonEncode(accountData!.toJson()));
                      }
                    },
                    
                    icon: const Icon(Icons.account_circle_sharp, size: 35.0),
                  )
                :Container()
          ),
        ),
      ],
    );
  }
}
