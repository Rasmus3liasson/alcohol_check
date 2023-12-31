import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showArrow;

  const CustomAppBar({super.key, this.showArrow = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Nyckerhets Kontroll"),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: showArrow
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
            child: IconButton(
              onPressed: () {
              // Will direct to googler sign in later on
              },
              icon: const Icon(Icons.account_circle_sharp,size:35,),
            ),
          ),
        ),
      ],
          
    );
  }
}
