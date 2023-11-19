class Temperature {
  final double? _kelvin;

  Temperature(this._kelvin);

  /// Convert temperature to Kelvin
  double? get kelvin => _kelvin;

  /// Convert temperature to Celsius
  double? get celsius => _kelvin != null ? _kelvin! - 273.15 : null;

  /// Convert temperature to Fahrenheit
  double? get fahrenheit =>
      _kelvin != null ? _kelvin! * (9 / 5) - 459.67 : null;

  String temperatureByUnit({String? unit}) {
    switch (unit) {
      case 'C':
        return celsiusString;
      case 'F':
        return fahrenheitString;
      case 'K':
        return kelvinString;
      default:
        return celsiusString;
    }
  }

  String get celsiusString =>
      celsius != null ? '${celsius!.toStringAsFixed(1)}°C' : "No";

  String get fahrenheitString =>
      fahrenheit != null ? '${fahrenheit!.toStringAsFixed(1)}°F' : "No";

  String get kelvinString =>
      kelvin != null ? '${kelvin!.toStringAsFixed(1)}°K' : "No";

  @override
  String toString() =>
      celsius != null ? '${celsius!.toStringAsFixed(1)} Celsius' : "No";
}
