import 'package:weather_pal/models/temperature.dart';
import 'package:weather_pal/utils/parser.dart';

class Weather {
  String? _country, _areaName, _weatherMain, _weatherDescription, _weatherIcon;
  Temperature? _temperature, _tempMin, _tempMax, _tempFeelsLike;
  Map<String, dynamic>? _weatherData;

  DateTime? _date, _sunrise, _sunset;
  double? _latitude,
      _longitude,
      _pressure,
      _windSpeed,
      _windDegree,
      _windGust,
      _humidity,
      _cloudiness,
      _rainLastHour,
      _rainLast3Hours,
      _snowLastHour,
      _snowLast3Hours;

  int? _weatherConditionCode;

  Weather(Map<String, dynamic> jsonData) {
    if (jsonData.isEmpty) return;

    Map<String, dynamic>? main = jsonData['main'];
    Map<String, dynamic>? coord = jsonData['coord'];
    Map<String, dynamic>? sys = jsonData['sys'];
    Map<String, dynamic>? wind = jsonData['wind'];
    Map<String, dynamic>? clouds = jsonData['clouds'];
    Map<String, dynamic>? rain = jsonData['rain'];
    Map<String, dynamic>? snow = jsonData['snow'];
    Map<String, dynamic>? weather = jsonData['weather'][0];

    _latitude = coord.toDouble('lat');
    _longitude = coord.toDouble('lon');

    _country = sys.unpackString('country');
    _sunrise = sys.toDate('sunrise');
    _sunset = sys.toDate('sunset');

    _weatherData = jsonData;
    _weatherMain = weather.unpackString('main');
    _weatherDescription = weather.unpackString('description');
    _weatherIcon = weather.unpackString('icon');
    _weatherConditionCode = weather.toInt('id');

    _temperature = main.toTemperature('temp');
    _tempMin = main.toTemperature('temp_min');
    _tempMax = main.toTemperature('temp_max');
    _tempFeelsLike = main.toTemperature('feels_like');

    _humidity = main.toDouble('humidity');
    _pressure = main.toDouble('pressure');

    _windSpeed = wind.toDouble('speed');
    _windDegree = wind.toDouble('deg');
    _windGust = wind.toDouble('gust');

    _cloudiness = clouds.toDouble('all');

    _rainLastHour = rain.toDouble('1h');
    _rainLast3Hours = rain.toDouble('3h');

    _snowLastHour = snow.toDouble('1h');
    _snowLast3Hours = snow.toDouble('3h');

    _areaName = jsonData.unpackString('name');
    _date = jsonData.toDate('dt');
  }

  /// The original JSON data from the API
  Map<String, dynamic>? toJson() => _weatherData;

  /// The weather data formatted as a string with newlines
  @override
  String toString() {
    return '''
    Place Name: $_areaName [$_country] ($latitude, $longitude)
    Date: $_date
    Weather: $_weatherMain, $_weatherDescription ($_weatherIcon)
    Temp: $_temperature, Temp (min): $_tempMin, Temp (max): $_tempMax,  Temp (feels like): $_tempFeelsLike
    Sunrise: $_sunrise, Sunset: $_sunset
    Wind: speed $_windSpeed, degree: $_windDegree, gust $_windGust
    Humidity: $_humidity, Pressure: $_pressure, Cloudiness: $_cloudiness
    Weather Condition code: $_weatherConditionCode
    ''';
  }

  /// A long description of the weather
  String? get weatherDescription => _weatherDescription;

  /// A brief description of the weather
  String? get weatherMain => _weatherMain;

  /// Icon depicting current weather
  String? get weatherIcon => _weatherIcon;

  /// Weather condition codes
  int? get weatherConditionCode => _weatherConditionCode;

  /// The level of cloudiness in Okta (0-9 scale)
  double? get cloudiness => _cloudiness;

  /// Wind direction in degrees
  double? get windDegree => _windDegree;

  /// Wind speed in m/s
  double? get windSpeed => _windSpeed;

  /// Wind gust in m/s
  double? get windGust => _windGust;

  /// Max [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempMax => _tempMax;

  /// Min [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempMin => _tempMin;

  /// Mean [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get temperature => _temperature;

  /// The 'feels like' [Temperature]. Available as Kelvin, Celsius and Fahrenheit.
  Temperature? get tempFeelsLike => _tempFeelsLike;

  /// Pressure in Pascal
  double? get pressure => _pressure;

  /// Humidity in percent
  double? get humidity => _humidity;

  /// Longitude of the weather observation
  double? get longitude => _longitude;

  /// Latitude of the weather observation
  double? get latitude => _latitude;

  /// Date of the weather observation
  DateTime? get date => _date;

  /// Timestamp of sunset
  DateTime? get sunset => _sunset;

  /// Timestamp of sunrise
  DateTime? get sunrise => _sunrise;

  /// Name of the area, ex Mountain View, or Copenhagen Municipality
  String? get areaName => _areaName;

  /// Country code, ex US or DK
  String? get country => _country;

  /// Rain fall last hour measured in mm
  double? get rainLastHour => _rainLastHour;

  /// Rain fall last 3 hours measured in mm
  double? get rainLast3Hours => _rainLast3Hours;

  /// Snow fall last 3 hours measured in mm
  double? get snowLastHour => _snowLastHour;

  /// Snow fall last 3 hours measured in mm
  double? get snowLast3Hours => _snowLast3Hours;
}
