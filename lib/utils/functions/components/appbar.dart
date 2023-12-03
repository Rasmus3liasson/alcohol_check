import 'package:alcohol_check/utils/functions/google.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showArrow;

  const CustomAppBar({Key? key, this.showArrow = false}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Map<String, dynamic> result = {};

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
            child: IconButton(
              onPressed: () async {
                Map<String, dynamic> data = await signInGoogle();
                setState(() {
                  result = data;
                });

                if (result['result'] == null) {
                  print('Sign-in error: ${result['error']}');
                } else {
                  print('Sign-in successful! User data: ${result['result']}');
                }
              },
              icon: result['result'] != null
                  ? CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(result['result'].photoURL),
                    )
                  : const Icon(Icons.account_circle_sharp, size: 35),
            ),
          ),
        ),
      ],
    );
  }
}
