import 'package:alcohol_check/main.dart';
import 'package:flutter/material.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:alcohol_check/utils/functions/components/drawer.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int index = 0;
  bool isDrawerVisible = false;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isDrawerVisible) {
          setState(() {
            isDrawerVisible = !isDrawerVisible;
          });
        }
      },
      child: Stack(
        children: <Widget>[
          if(!isDrawerVisible)
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
                  isDrawerVisible = true;
                  animationController.forward();
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
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1.3, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(
                    parent: animationController,
                    curve: Curves.easeInOut,
                  )),
                  child: Row(
                    children: [
                      const CustomDrawer(),
                      FillEmptySpace(),
                    ],
                  ),
                );
              },
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
          animationController.reverse();
        }),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
