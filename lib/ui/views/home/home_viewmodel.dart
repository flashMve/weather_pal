import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/services/weather_service.dart';
import 'package:weather_pal/utils/date_parser.dart';

class HomeViewModel extends ReactiveViewModel {
  final weatherService = locator<WeatherService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [weatherService];

  Weather get weather =>
      weatherService.weatherData[DateParser.parse()] as Weather;

  List<Weather> get forecast =>
      weatherService.weatherData['forecast'] as List<Weather>;

  bool locationEnabled = true;

  Future checkPermisson() async {
    log('Checking Permission');

    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      locationEnabled = true;
      notifyListeners();
    } else {
      locationEnabled = false;
      notifyListeners();
    }
  }

  openSettings() async {
    await checkPermisson();
    if (locationEnabled) {
      final pos = await Geolocator.getCurrentPosition();

      try {
        await weatherService.currentWeatherByLocation(
            pos.latitude, pos.longitude);
        await weatherService.fiveDayForecastByLocation(
            pos.latitude, pos.longitude);
        return;
      } on Exception catch (e) {
        log(e.toString());
        return;
      } catch (e) {
        log(e.toString());
        return;
      }
    }

    await Geolocator.openLocationSettings();
    await checkPermisson();
  }

  initState() async {
    await checkPermisson();
  }
}
