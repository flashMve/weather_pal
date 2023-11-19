import 'package:weather_pal/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:weather_pal/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:weather_pal/ui/views/home/home_view.dart';
import 'package:weather_pal/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/services/weather_service.dart';
import 'package:weather_pal/services/internet_connectivity_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: WeatherService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: InternetConnectivityService),
// @stacked-service
  ],
  logger: StackedLogger(),
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
