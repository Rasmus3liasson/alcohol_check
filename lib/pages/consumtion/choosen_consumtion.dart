import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class ChoosenConsumtion extends StatelessWidget {
  final ConsumptionPopUpData consumtionData;
  final Function removeFromConsumtion;
  final Function(BuildContext) openConsumptionPopUp;

  const ChoosenConsumtion({super.key, 
    required this.consumtionData,
    required this.removeFromConsumtion,
    required this.openConsumptionPopUp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350.0,
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              openConsumptionPopUp(context);
            },
            child: Card(
              
              child: Container(
                    
              decoration:BoxDecoration(
                     boxShadow: [
                            BoxShadow(
                              color: AppColor.greyColor.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset: const Offset(0, 5),
                            ),
                          ],
              ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        consumtionData.image,
                        width: 100.0,
                        height: 100.0,
                      ),
                      Column(
                        children: [
                          if (consumtionData.volume != null)
                            Text(
                              "${consumtionData.volume} ${consumtionData.unitSign}",
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w300),
                            ),
                          Text(
                            "Mängd: ${consumtionData.units} enheter/glas",
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                removeFromConsumtion();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
