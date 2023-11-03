import 'package:alcohol_check/utils/enums/gender_enum.dart';

class UserData {
  final int height;
  final int weight;
  final Gender gender;

  UserData({
    required this.height,
    required this.weight,
    required this.gender,
  });
}
class UserDataTime extends UserData {
  final DateTime startTime;
  final DateTime endTime;

  UserDataTime({
    required this.startTime,
    required this.endTime,
    required int height,
    required int weight,
    required Gender gender,
  }) : super(
          height: height,
          weight: weight,
          gender: gender,
        );
}
