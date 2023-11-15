import 'package:alcohol_check/main.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:alcohol_check/utils/functions/components/drawer.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int index = 0;
  bool isDrawerVisible = false;

  @override
  Widget build(BuildContext context) {
    print(isDrawerVisible);
    return GestureDetector(
      onTap: () {
        if (isDrawerVisible) {
          setState(() {
            isDrawerVisible = true;
          });
        }
      },
      child: Stack(
        children: <Widget>[
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColor.blackColor,
            unselectedItemColor: AppColor.greyColor,
            currentIndex: index,
            elevation: 0,
            onTap: (i) {
              setState(() {
                index = i;
              });
              if (i == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              } else {
                setState(() {
                  isDrawerVisible = !isDrawerVisible;
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 32.0),
                label: 'Hem',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined, size: 32.0),
                label: 'Historik',
              ),
            ],
          ),
          if (isDrawerVisible)
            Row(
              children: [
                const CustomDrawer(),
                FillEmptySpace(),
              ],
            ),
        ],
      ),
    );
  }

  Expanded FillEmptySpace() {
    return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    isDrawerVisible = !isDrawerVisible;
                  }),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              );
  }
}
