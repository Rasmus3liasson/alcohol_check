import 'package:alcohol_check/models/alcohol_data.dart';

double calculateLiquorAmount(AlcoholData alcoholData) {
  double volumeInLiters = (alcoholData.volume?.first ?? 0) / 1000;
  double liquorAmount = volumeInLiters * alcoholData.units.first;

  return liquorAmount;
}
