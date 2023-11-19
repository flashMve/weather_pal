import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/common/ui_helpers.dart';
import 'package:weather_pal/ui/widgets/home/custom_card.dart';
import 'package:weather_pal/utils/custom_extension.dart';
import 'package:weather_pal/utils/date_parser.dart';
import 'package:weather_pal/utils/helper.dart';

class ForecastInfoCard extends StatelessWidget {
  const ForecastInfoCard({
    super.key,
    required this.weather,
    required this.unit,
  });

  final Weather weather;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Transform.rotate(
        angle: -0.04,
        child: SizedBox(
          height: 200,
          width: screenWidth(context),
          child: CustomPaint(
            painter: CustomWeatherCard2(
              // colors: const [Colors.pink, Colors.purple],
              color: kcBackgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          weather.temperature?.temperatureByUnit(
                                unit: unit,
                              ) ??
                              "No",
                          style: context.titleLarge!.copyWith(
                            color: kcPrimaryTextColor,
                            fontSize: unit == 'C'
                                ? 50.sp
                                : unit == 'F'
                                    ? 40.sp
                                    : 35.sp,
                          ),
                        ).paddingOnly(left: 20),
                      ),
                      Text(
                        DateParser.parseGivenDate(
                          weather.date ?? DateTime.now(),
                          locale: context.locale.languageCode,
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: kcPrimaryTextColor,
                        ),
                      ).paddingOnly(left: 20),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image(
                        image:
                            AssetImage(getIcon(weather.weatherIcon ?? "01d")),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        (weather.weatherMain?.tr())?.toUpperCase() ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kcPrimaryTextColor,
                        ),
                      ).paddingOnly(
                        right: 20,
                        bottom: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ).paddingOnly(bottom: 10),
      ).paddingSymmetric(horizontal: 12, vertical: 6),
    );
  }
}
