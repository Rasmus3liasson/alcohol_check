class AlcoholData{
  final int iD;
  final String image;
  final int volume;
  final int units;

  AlcoholData({
    required this.iD,
    required this.image,
    required this.volume,
    required this.units,
  });
}

List<AlcoholData> alcoholDataList = [
  AlcoholData(
    iD: 1,
    image: "assets/images/ol.png",
    volume: 330,
    units: 1,   
  ),
  AlcoholData(
    iD: 2,
image: "assets/images/vin.png",
    volume: 750,
    units: 1,   
  ),
  AlcoholData(
    iD: 3,
    image: "assets/images/sprit.png",
    volume: 750,
    units: 1,   
  ),
];

