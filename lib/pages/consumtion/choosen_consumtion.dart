import 'package:alcohol_check/models/consumption_pop_up.dart';
import 'package:alcohol_check/utils/constans/color.dart';
import 'package:flutter/material.dart';

class ChoosenConsumtion extends StatelessWidget {
  final ConsumptionPopUpData consumtionData;
  final Function removeFromConsumtion;
  final Function(BuildContext) openConsumptionPopUp;

  const ChoosenConsumtion({
    super.key,
    required this.consumtionData,
    required this.removeFromConsumtion,
    required this.openConsumptionPopUp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380.0,
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
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.blackColor.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 1),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 70.0),
                        child: Flexible(
                          child: IconButton(
                            icon: const Icon(Icons.cancel_outlined,color: AppColor.greyColor,),
                            onPressed: () {
                              removeFromConsumtion();
                            },
                          ),
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
