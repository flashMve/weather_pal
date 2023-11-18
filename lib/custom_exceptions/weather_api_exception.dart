class OpenWeatherAPIException implements Exception {
  final String _cause;

  OpenWeatherAPIException(this._cause);

  @override
  String toString() => '$runtimeType - $_cause';
}
