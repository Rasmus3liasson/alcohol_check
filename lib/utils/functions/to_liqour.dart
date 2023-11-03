double? toLiquor(String? unit, int? volume, int? units) {
  if (unit == "cl") {
    return volume! * 0.09; // Beer is in centiliter liqour (cl)
  } else if (unit == "%"){
    return volume?.toDouble();
  }else{
    return (18 * 0.3) * units!; // Wine in liqour (cl)
  }
}