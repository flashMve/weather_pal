import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/services/weather_service.dart';
import 'package:weather_pal/ui/views/home/home_view.dart';
import 'package:weather_pal/utils/date_parser.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final weatherService = locator<WeatherService>();
  final snackBar = locator<SnackbarService>();

  bool done = false;

  bool loadingSplash = false;

  getAndSaveWeatherData({Position? pos}) async {
    if (pos != null) {
      await weatherService.currentWeatherByLocation(
          pos.latitude, pos.longitude);
      await weatherService.fiveDayForecastByLocation(
          pos.latitude, pos.longitude);
    } else {
      await weatherService.currentWeatherByCityName('Gujranwala');
      await weatherService.fiveDayForecastByCityName('Gujranwala');
    }

    await weatherService.saveWeatherDataAsJson();
  }

  Future initState({Position? pos}) async {
    try {
      final data = await weatherService.getWeatherDataAsJson();

      log("Data is Loading Let see $data");

      if (data != null) {
        if (data.containsKey(DateParser.parse())) {
          done = true;
          return;
        } else {
          await getAndSaveWeatherData(pos: pos);
          done = true;

          if (done && loadingSplash) {
            _navigationService.replaceWithTransition(
              const HomeView(),
              duration: const Duration(milliseconds: 1000),
              transitionStyle: Transition.fade,
            );
          }
          return;
        }
      }

      await getAndSaveWeatherData(pos: pos);

      done = true;

      if (done && loadingSplash) {
        _navigationService.replaceWithTransition(
          const HomeView(),
          duration: const Duration(milliseconds: 1000),
          transitionStyle: Transition.fade,
        );
      }
    } catch (e) {
      snackBar.showSnackbar(message: 'error_fetching_data'.tr());
    }
  }

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    try {
      final position = await determinePosition();

      initState(pos: position);
      await Future.delayed(const Duration(seconds: 4)).then((value) {
        loadingSplash = true;
        log('Loading Splash Done $done $loadingSplash',
            name: 'StartupViewModel');
        if (done && loadingSplash) {
          _navigationService.replaceWithTransition(
            const HomeView(),
            duration: const Duration(milliseconds: 1000),
            transitionStyle: Transition.fade,
          );
        }
      });
    } catch (e) {
      snackBar.showSnackbar(message: e.toString());
      loadingSplash = true;
      initState();
    }

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('location_title'.tr());
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('location_denied'.tr());
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('location_permission_denied'.tr());
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
