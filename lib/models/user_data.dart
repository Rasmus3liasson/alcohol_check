class UserData {
  final int height;
  final int weight;
  final String gender;

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
    required String gender,
  }) : super(
          height: height,
          weight: weight,
          gender: gender,
        );
}
