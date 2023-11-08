import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showArrow;

  CustomAppBar({this.showArrow = false});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Nyckerhets Kontroll"),
      backgroundColor: AppColor.blackColor,
      elevation: 0.0,
      leading: showArrow
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
            )
          : null,
    );
  }
}
