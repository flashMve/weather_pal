import 'dart:developer';

import 'package:flutter/widgets.dart';
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

  Future<bool> checkPermisson() async {
    log('Checking Permission');

    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      locationEnabled = true;
      notifyListeners();
      return true;
    } else {
      locationEnabled = false;
      notifyListeners();
      return false;
    }
  }

  openSettings({bool isResumeApp = false}) async {
    if (locationEnabled) return;
    await checkPermisson();
    if (locationEnabled) {
      final pos = await Geolocator.getCurrentPosition();
      try {
        await weatherService.getAndSaveWeatherData(pos: pos);

        return;
      } on Exception catch (e) {
        log(e.toString());
        return;
      } catch (e) {
        log(e.toString());
        return;
      }
    }
    if (!isResumeApp) await Geolocator.openAppSettings();
  }

  initState() async {
    await checkPermisson();

    AppLifecycleListener(
      onResume: () {
        if (locationEnabled) return;
        openSettings(isResumeApp: true);
      },
    );
  }
}
