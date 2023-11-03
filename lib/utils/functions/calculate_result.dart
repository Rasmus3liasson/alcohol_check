 import '../enums/gender_enum.dart';

bool isSober({
  required int height,
  required int weight,
  required Gender gender,
  required double alcoholConsumed,
  required double timeDifferenceInHours,
}) {
  final genderNumber = gender == Gender.man ? 0.68 : 0.55;
  final alcoholInGrams = (alcoholConsumed * 40) * 0.789; // Convert cl to grams
  final bodyWeightInGrams = weight * 1000;

  double bac = (alcoholInGrams / (bodyWeightInGrams * genderNumber)) -
      (0.015 * timeDifferenceInHours);

  const alcoholLimit = 0.02;



  return bac < alcoholLimit;
}
