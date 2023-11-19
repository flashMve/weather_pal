import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/services/weather_service.dart';
import 'package:weather_pal/utils/date_parser.dart';
import 'package:weather_pal/services/internet_connectivity_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WeatherService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<SnackbarService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<InternetConnectivityService>(
      onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterWeatherService();
  getAndRegisterSnackbarService();
  getAndRegisterInternetConnectivityService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockSnackbarService getAndRegisterSnackbarService() {
  _removeRegistrationIfExists<SnackbarService>();
  final service = MockSnackbarService();
  locator.registerSingleton<SnackbarService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockWeatherService getAndRegisterWeatherService(
    {bool returnData = false, bool returnWeatherAsJson = false}) {
  _removeRegistrationIfExists<WeatherService>();
  final service = MockWeatherService();

  // Stub Value when weatherService.weatherData is called
  when(service.weatherData).thenAnswer((realInvocation) {
    if (returnData) {
      return {
        DateParser.parse(): Weather({}),
        'forecast': List.filled(5, Weather({}))
      };
    }

    return {};
  });
  if (returnWeatherAsJson) {
    when(service.getWeatherDataAsJson()).thenAnswer((realInvocation) async {
      if (returnWeatherAsJson) {
        return {
          DateParser.parse(): Weather({}),
          'forecast': List.filled(5, Weather({}))
        };
      }

      return {};
    });
  }

  locator.registerSingleton<WeatherService>(service);
  return service;
}

MockInternetConnectivityService getAndRegisterInternetConnectivityService() {
  _removeRegistrationIfExists<InternetConnectivityService>();
  final service = MockInternetConnectivityService();
  locator.registerSingleton<InternetConnectivityService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
