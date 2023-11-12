import 'package:alcohol_check/utils/enums/gender_enum.dart';

class SoberResult {
  final double bac;
  final bool isSober;

  SoberResult(this.bac, this.isSober);
}

SoberResult isSober({
  required int height,
  required int weight,
  required Gender gender,
  required double alcoholConsumed,
  required double timeDifferenceInHours,
}) {
  final genderNumber = gender == Gender.man ? 0.68 : 0.55;
  final alcoholInGrams = alcoholConsumed * 0.789; // Convert cl to grams
  final bodyWeightInGrams = weight * 1000;

  double bacAllDecimals =
      (alcoholInGrams / (bodyWeightInGrams * genderNumber)) -
          (0.015 * timeDifferenceInHours);

  double bac = double.parse(bacAllDecimals.toStringAsFixed(2));

  const alcoholLimit = 0.02;

  final isSober = bac < alcoholLimit;
  return SoberResult(bac, isSober);
}
