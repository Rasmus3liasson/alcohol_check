class ConsumptionPopUpData {
  final String image;
  final int? volume;
  final int? units;
  final String? unitSign; 

  ConsumptionPopUpData({
    required this.image,
    required this.volume,
    required this.units,
    this.unitSign,
  });
}
