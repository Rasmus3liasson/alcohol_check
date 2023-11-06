import 'package:alcohol_check/main.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey, 
      currentIndex: index,
      elevation: 0,
      onTap: (i) {
        setState(() {
          index = i;
        });
        if (i == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Hem',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_3_rounded),
          label: 'Konto',
        ),
      ],
    );
  }
}
