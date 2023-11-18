import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/services/weather_service.dart';
import 'package:weather_pal/utils/custom_extension.dart';

class HomePanelModel extends ReactiveViewModel {
  final weatherService = locator<WeatherService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [weatherService];

  List<Weather> get forecast =>
      weatherService.weatherData['forecast'] as List<Weather>;

  onTemperatureUnitChanged(String? value, BuildContext context) {
    context.saveStringToSharedPrefrences('unit', value!);
    weatherService.temperatureIn = value;
  }

  onLanguageChanged(String? value, BuildContext context) async {
    await context.setLocale(Locale(value!));
    weatherService.changeLocale();
  }
}
