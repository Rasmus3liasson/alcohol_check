class AlcoholData {
  final int iD;
  final String image;
  final List<int>? volume;
  final List<int> units;

  AlcoholData({
    required this.iD,
    required this.image,
    this.volume,
    required this.units,
  });
}

List<AlcoholData> alcoholDataList = [
  AlcoholData(
    iD: 1,
    image: "assets/images/ol.png",
    volume: [33, 50],
    units: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
  ),
  AlcoholData(
    iD: 2,
    image: "assets/images/vin.png",
    units: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
  ),
  AlcoholData(
    iD: 3,
    image: "assets/images/sprit.png",
    volume: List.generate(60, (index) => index + 1),
    units: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
  ),
];
