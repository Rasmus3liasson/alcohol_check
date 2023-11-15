import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 340.0,
      backgroundColor: AppColor.whiteColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColor.blackColor,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Historik',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: AppColor.whiteColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: AppColor.blackColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.greyColor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(
                            child: Text(
                              'Item 1',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
