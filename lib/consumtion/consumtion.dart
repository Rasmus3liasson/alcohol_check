import 'package:alcohol_check/consumtion/choosen_consumtion.dart';
import 'package:alcohol_check/consumtion/consumtion_pop_up.dart';
import 'package:alcohol_check/consumtion_time/consumtion_time.dart';
import 'package:alcohol_check/models/alcohol_data.dart';
import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:flutter/material.dart';

class Consumtion extends StatefulWidget {
  @override
  _ConsumtionState createState() => _ConsumtionState();
}

class _ConsumtionState extends State<Consumtion> {
  List<ConsumptionPopUpData> consumtionList = [];
  bool isVisible = false;
  double imageOpacity = 0.0;

  Future<void> openConsumptionPopUp(
      BuildContext context, AlcoholData liqour) async {
    ConsumptionPopUpData? consumtionData =
        await ConsumptionPopUp.showPopUp(context, liqour);

    if (consumtionData != null) {
      setState(() {
        consumtionList.add(consumtionData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alkohol Konsumtion'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (isVisible)
                Expanded(
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                              child: Image.asset(
                                liqour.image,
                                width: 120.0,
                                height: 120.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
              if (consumtionList.isNotEmpty)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Din Konsumntion",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                        ),
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
                        );
                      }),
                      SizedBox(
                        height: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConsumtionTime(
                                consumtionData: consumtionList,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Vidare",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          child: !isVisible ? Icon(Icons.add_sharp) : Icon(Icons.close),
        ));
  }
}
