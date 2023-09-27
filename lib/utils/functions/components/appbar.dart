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
      leading: showArrow
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
            )
          : null,
      actions: [
        IconButton(
          icon: Icon(Icons.person_3_rounded),
          onPressed: () {},
        ),
      ],
    );
  }
}
