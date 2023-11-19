import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/widgets/common/drop_shadow/drop_shadow.dart';
import 'package:weather_pal/utils/custom_extension.dart';
import 'package:weather_pal/utils/helper.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.weather,
    required this.unit,
  });

  final Weather weather;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: kcBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: DropShadow(
                spread: 2,
                blurRadius: 10,
                child: Image(
                  image: AssetImage(getIcon(weather.weatherIcon ?? "01n")),
                ),
              ).animate().slideX(
                    begin: -1,
                    end: 0,
                    duration: const Duration(milliseconds: 500),
                  ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    weather.temperature?.temperatureByUnit(unit: unit) ?? "",
                    style: context.titleLarge!.copyWith(
                      color: kcPrimaryTextColor,
                      fontSize: 60.spMin,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    (weather.weatherMain?.tr())?.toUpperCase() ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: kcPrimaryTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
