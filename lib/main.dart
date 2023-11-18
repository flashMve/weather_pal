import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_pal/app/app.bottomsheets.dart';
import 'package:weather_pal/app/app.dialogs.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/common/ui_helpers.dart';

import 'ui/widgets/error/custom_exception_error.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: true,
    ),
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    runApp(CustomErrorWidget(errorMessage: details.exceptionAsString()));
  };

  Animate.restartOnHotReload = true;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Gilroy',
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: getResponsiveFontSize(context),
            fontWeight: FontWeight.w900,
            color: kcPrimaryTextColor,
          ),
        ),
      ),
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
