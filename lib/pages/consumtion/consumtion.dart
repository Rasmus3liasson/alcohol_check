import 'package:alcohol_check/models/alcohol_data.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/models/user_data.dart';
import 'package:alcohol_check/pages/consumtion/choosen_consumtion.dart';
import 'package:alcohol_check/pages/consumtion/consumtion_pop_up.dart';
import 'package:alcohol_check/pages/consumtion_time/consumtion_time.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:alcohol_check/utils/functions/components/appbar.dart';
import 'package:alcohol_check/utils/functions/components/bottom_navigationbar.dart';
import 'package:alcohol_check/utils/functions/components/button.dart';
import 'package:flutter/material.dart';

class Consumtion extends StatefulWidget {
  final UserData userData;

  const Consumtion({Key? key, required this.userData}) : super(key: key);

  @override
  _ConsumtionState createState() => _ConsumtionState();
}

class _ConsumtionState extends State<Consumtion> {
  List<ConsumptionPopUpData> consumtionList = [];
  bool isVisible = false;
  double imageOpacity = 0.0;
  AlcoholData? selectedLiqour;
  int index = 0;

  Future<void> openConsumptionPopUp(
      BuildContext context, AlcoholData liqour) async {
    ConsumptionPopUpData? consumtionData =
        await ConsumptionPopUp.showPopUp(context, liqour);

    // Check to replace if there are changes to the item
    if (consumtionData != null) {
      int index =
          consumtionList.indexWhere((item) => item.image == liqour.image);
      setState(() {
        if (index != -1) {
          consumtionList[index] = consumtionData;
        } else {
          consumtionList.add(consumtionData);
        }
        selectedLiqour = liqour;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (consumtionList.isEmpty && !isVisible)
                  const Text('Lägg till din konsumtion',
                      style: TextStyle(fontSize: 30.0)),
                if (isVisible)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: alcoholDataList.map((liqour) {
                        return GestureDetector(
                          onTap: () {
                            openConsumptionPopUp(context, liqour);
                            setState(() {
                              isVisible = false;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Card(
                              color: AppColor.blackColorLighter,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Image.asset(
                                  liqour.image,
                                  width: 120.0,
                                  height: 120.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                if (consumtionList.isNotEmpty && !isVisible)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Din Konsumntion",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 40.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        // Display the ChoosenConsumtion widgets
                        ...consumtionList.map((consumtionData) {
                          return ChoosenConsumtion(
                            consumtionData: consumtionData,
                            removeFromConsumtion: () {
                              setState(() {
                                consumtionList.remove(consumtionData);
                              });
                            },
                            openConsumptionPopUp: (context) {
                              openConsumptionPopUp(context, selectedLiqour!);
                            },
                          );
                        }),
                        const SizedBox(
                          height: 30.0,
                        ),
                        CustomNavigationButton(
                            text: 'Vidare',
                            widgetNavigation: ConsumtionTime(
                              consumtionData: consumtionList,
                              userData: widget.userData,
                            ))
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Stack(
          alignment: Alignment.center,
          children: [
            const CustomBottomNavigationBar(),
            Positioned(
              top: 0,
              child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: AppColor.purpleColor,
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: !isVisible
                    ? const Icon(
                        Icons.add_sharp,
                        color: AppColor.whiteColor,
                      )
                    : const Icon(
                        Icons.close,
                        color: AppColor.whiteColor,
                      ),
              ),
            ),
          ],
        ));
  }
}
