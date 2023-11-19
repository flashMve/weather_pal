import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/services/internet_connectivity_service.dart';
import 'package:weather_pal/services/weather_service.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/views/home/home_view.dart';
import 'package:weather_pal/utils/date_parser.dart';

class StartupViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();

  final weatherService = locator<WeatherService>();

  final snackBar = locator<SnackbarService>();
  final internet = locator<InternetConnectivityService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [internet];

  bool done = false;

  bool loadingSplash = false;

  Future initState({Position? pos}) async {
    try {
      if (weatherService.weatherData.isNotEmpty) {
        done = true;
        notifyListeners();
        return;
      }

      final data = await weatherService.getWeatherDataAsJson();

      if (data != null) {
        if (data.containsKey(DateParser.parse())) {
          done = true;
          notifyListeners();
          return;
        } else {
          if (internet.isConnected) {
            await weatherService.getAndSaveWeatherData(pos: pos);
            done = true;
          }
          notifyListeners();

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
      if (internet.isConnected) {
        done = true;
        await weatherService.getAndSaveWeatherData(pos: pos);
        notifyListeners();
      }

      if (done && loadingSplash) {
        _navigationService.replaceWithTransition(
          const HomeView(),
          duration: const Duration(milliseconds: 1000),
          transitionStyle: Transition.fade,
        );
      }
    } catch (e) {
      snackBar.showCustomSnackBar(
        variant: 'error',
        message: 'error_fetching_data'.tr(),
      );
    }
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4)).then((value) {
      loadingSplash = true;
      log('Loading Splash Done $done $loadingSplash', name: 'StartupViewModel');
      if (done && loadingSplash) {
        _navigationService.replaceWithTransition(
          const HomeView(),
          duration: const Duration(milliseconds: 1000),
          transitionStyle: Transition.fade,
        );
      }
    });
  }

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    internet.connectivityChanges.listen((event) {
      internet.getConnectivityResult();

      if (internet.isConnected) {
        log('Internet Connected', name: 'StartupViewModel');
        initState();
      }
    });
    registerSnackbars();
    try {
      final position = await determinePosition();
      navigateToHome();
      initState(pos: position);
    } catch (e) {
      snackBar.showCustomSnackBar(
        variant: 'error',
        message: e.toString(),
      );
      navigateToHome();
      initState();
    }
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

  registerSnackbars() {
    snackBar.registerCustomSnackbarConfig(
      variant: 'success',
      config: SnackbarConfig(
        backgroundColor: Colors.green.shade700,
        textColor: kcPrimaryTextColor,
        icon: const Icon(
          Icons.check,
          color: kcPrimaryTextColor,
        ),
        maxWidth: 500,
        borderRadius: 4,
        margin: const EdgeInsets.all(16),
        snackPosition: SnackPosition.TOP,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 10),
      ),
    );

    snackBar.registerCustomSnackbarConfig(
      variant: "error",
      config: SnackbarConfig(
        backgroundColor: Colors.red.shade800,
        textColor: kcPrimaryTextColor,
        icon: const Icon(
          Icons.error,
          color: kcPrimaryTextColor,
        ),
        maxWidth: 500,
        borderRadius: 4,
        margin: const EdgeInsets.all(16),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 10),
      ),
    );
  }
}
