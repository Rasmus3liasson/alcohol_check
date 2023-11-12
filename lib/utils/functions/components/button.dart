import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class CustomNavigationButton extends StatefulWidget {
  final String text;
  final Widget widgetNavigation;
  final Map<String, dynamic> data;
  const CustomNavigationButton({Key? key, required this.text, required this.widgetNavigation, this.data = const {}}) : super(key: key);

  @override
  State<CustomNavigationButton> createState() => CustomNavigationButtonState(data: data);
}

class CustomNavigationButtonState extends State<CustomNavigationButton> {
  final Map<String, dynamic> data;

  CustomNavigationButtonState({required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.blackColor,
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.widgetNavigation,
            settings: RouteSettings(arguments: data),
          ),
        );
      },
      child: Text(widget.text,style: TextStyle(fontSize: 20.0),),
    );
  }
}