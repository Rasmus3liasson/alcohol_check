import 'dart:async';

import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLoading = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _showLoading = true;
      });
      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/start');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColor.blackColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Alcohol Check',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    SvgPicture.asset(
                      'assets/images/beer.svg',
                      height: 50.0,
                      width: 50.0,
                    ),
                  ],
                ),
                const SizedBox(height: 60.0),
                if (_showLoading)
                  const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColor.whiteColor),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
