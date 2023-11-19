// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/custom_exceptions/weather_api_exception.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/utils/date_parser.dart';
import 'package:weather_pal/utils/language.dart';
import 'package:weather_pal/utils/parser.dart';

/// Plugin for fetching weather data in JSON.
class WeatherService with ListenableServiceMixin {
  final snackBar = locator<SnackbarService>();

  final String? apiKey = '5aecf353afe7419bf7269d121bac2f30';
  Language language = Language.english;
  static const String FIVE_DAY_FORECAST = 'forecast';
  static const String CURRENT_WEATHER = 'weather';
  static const int STATUS_OK = 200;

  String? _temperatureInCelsius = 'C';

  WeatherService({http.Client? httpClient}) {
    _httpClient = httpClient ?? http.Client();
    setTemperature();
    listenToReactiveValues([weatherData, _temperatureInCelsius]);
  }

  set temperatureIn(String? value) {
    _temperatureInCelsius = value;
    notifyListeners();
  }

  changeLocale() {
    notifyListeners();
  }

  getAndSaveWeatherData({Position? pos}) async {
    try {
      if (pos != null) {
        await currentWeatherByLocation(pos.latitude, pos.longitude);
        await fiveDayForecastByLocation(pos.latitude, pos.longitude);
      } else {
        await currentWeatherByCityName('Gujranwala');
        await fiveDayForecastByCityName('Gujranwala');
      }

      await saveWeatherDataAsJson();
    } catch (e) {
      snackBar.showCustomSnackBar(
        variant: 'error',
        message: 'error_fetching_data'.tr(),
      );
    }
  }

  saveWeatherDataAsJson() async {
    final instance = await SharedPreferences.getInstance();
    instance.remove('weatherData');
    final String weatherData = json.encode(this.weatherData);
    instance.setString('weatherData', weatherData);
  }

  Future<Map<String, dynamic>?> getWeatherDataAsJson() async {
    final instance = await SharedPreferences.getInstance();
    final String? weatherData = instance.getString('weatherData');
    if (weatherData != null) {
      final tempData = json.decode(weatherData);
      tempData.forEach((key, value) {
        if (key == 'forecast') {
          tempData[key] = convertListToWeather(tempData[key]);
        } else {
          tempData[key] = convertMapToWeather(tempData[key]);
        }
      });

      this.weatherData = tempData;

      return tempData;
    } else {
      return null;
    }
  }

  convertMapToWeather(Map<String, dynamic> map) {
    return Weather(map);
  }

  convertListToWeather(List<dynamic> list) {
    List<Weather> weatherList = [];
    for (var item in list) {
      weatherList.add(Weather(item));
    }
    return weatherList;
  }

  String? get temperatureIn => _temperatureInCelsius ?? 'C';

  setTemperature() async {
    final instance = await SharedPreferences.getInstance();
    final String? temp = instance.getString('unit');

    temperatureIn = temp;
  }

  late http.Client _httpClient;

  Map<String, dynamic> weatherData = {};

  /// Fetch current weather based on geographical coordinates
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/current
  Future<Weather> currentWeatherByLocation(
      double latitude, double longitude) async {
    Map<String, dynamic>? jsonResponse =
        await sendRequest(CURRENT_WEATHER, lat: latitude, lon: longitude);
    final weather = Weather(jsonResponse!);
    if (weatherData.containsKey(DateParser.parse())) {
      weatherData.remove(DateParser.parse());
    }

    weatherData.putIfAbsent(DateParser.parse(), () => weather);
    notifyListeners();
    return weather;
  }

  /// Fetch current weather based on city name
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/current
  Future<Weather> currentWeatherByCityName(String cityName) async {
    Map<String, dynamic>? jsonResponse =
        await sendRequest(CURRENT_WEATHER, cityName: cityName);
    final weather = Weather(jsonResponse!);
    if (weatherData.containsKey(DateParser.parse())) {
      weatherData.remove(DateParser.parse());
    }

    weatherData.putIfAbsent(DateParser.parse(), () => weather);
    notifyListeners();
    return weather;
  }

  /// Fetch current weather based on geographical coordinates.
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/forecast5
  Future<List<Weather>> fiveDayForecastByLocation(
      double latitude, double longitude) async {
    Map<String, dynamic>? jsonResponse =
        await sendRequest(FIVE_DAY_FORECAST, lat: latitude, lon: longitude);
    List<Weather> forecast = (jsonResponse!.parseForecast());
    if (weatherData.containsKey('forecast')) {
      weatherData.remove('forecast');
    }

    weatherData.putIfAbsent('forecast', () => getFiveDayForecast(forecast));
    notifyListeners();

    return getFiveDayForecast(forecast);
  }

  /// Fetch current weather based on geographical coordinates.
  /// Result is JSON.
  /// For API documentation, see: https://openweathermap.org/forecast5
  Future<List<Weather>> fiveDayForecastByCityName(String cityName) async {
    Map<String, dynamic>? jsonForecast =
        await sendRequest(FIVE_DAY_FORECAST, cityName: cityName);
    List<Weather> forecasts = (jsonForecast!.parseForecast());
    if (weatherData.containsKey('forecast')) {
      weatherData.remove('forecast');
    }
    weatherData.putIfAbsent('forecast', () => getFiveDayForecast(forecasts));
    notifyListeners();

    return getFiveDayForecast(forecasts);
  }

  List<Weather> getFiveDayForecast(List<Weather> forecasts) {
    // Sort the list of forecasts by date and Get only 5 days

    List<Weather> forecastsByDates = [];

    for (var forecast in forecasts) {
      if (forecastsByDates.isEmpty) {
        forecastsByDates.add(forecast);
      } else {
        if (forecast.date!.day != forecastsByDates.last.date!.day) {
          forecastsByDates.add(forecast);
        }
      }
    }

    forecastsByDates.removeWhere((element) {
      return element.date!.day == DateTime.now().day;
    });

    return forecastsByDates;
  }

  Future<Map<String, dynamic>?> sendRequest(String tag,
      {double? lat, double? lon, String? cityName}) async {
    /// Build HTTP get url by passing the required parameters
    String url = _buildUrl(tag, cityName, lat, lon);

    /// Send HTTP get response with the url
    http.Response response = await _httpClient.get(Uri.parse(url));

    /// Perform error checking on response:
    /// Status code 200 means everything went well
    if (response.statusCode == STATUS_OK) {
      Map<String, dynamic>? jsonBody = json.decode(response.body);
      return jsonBody;
    }

    /// The API key is invalid, the API may be down
    /// or some other unspecified error could occur.
    /// The concrete error should be clear from the HTTP response body.
    else {
      throw OpenWeatherAPIException(
          "The API threw an exception: ${response.body}");
    }
  }

  String _buildUrl(String tag, String? cityName, double? lat, double? lon) {
    String url = 'https://api.openweathermap.org/data/2.5/' '$tag?';

    if (cityName != null) {
      url += 'q=$cityName&';
    } else {
      url += 'lat=$lat&lon=$lon&';
    }

    url += 'appid=$apiKey&';
    url += 'lang=${languageCode[language]}';
    return url;
  }
}
