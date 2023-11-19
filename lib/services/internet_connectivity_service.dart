import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/app/app.locator.dart';

class InternetConnectivityService with ListenableServiceMixin {
  bool isConnected = false;
  final snackBar = locator<SnackbarService>();

  InternetConnectivityService() {
    getConnectivityResult().then((value) => setConnected = value);
  }

  set setConnected(bool value) {
    isConnected = value;
    notifyListeners();
  }

  Stream<ConnectivityResult> get connectivityChanges {
    return Connectivity().onConnectivityChanged;
  }

  Future<bool> getConnectivityResult() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    switch (connectivityResult) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        isConnected = true;
        return true;
      case ConnectivityResult.none:
        snackBar.showCustomSnackBar(
          variant: 'error',
          message: 'Internet'.tr(),
          duration: const Duration(seconds: 20),
        );
        return false;
      default:
        return false;
    }
  }
}
