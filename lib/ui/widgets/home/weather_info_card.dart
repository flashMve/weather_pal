import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_pal/ui/common/app_colors.dart';

class WeatherInfoCard extends StatelessWidget {
  const WeatherInfoCard({
    super.key,
    this.icon = 'assets/weather/humidity.png',
    this.title = '5 km/h',
    this.subtitle = 'Sunny',
  });

  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: Image.asset(
            icon,
            color: kcBackgroundColor.withOpacity(0.9),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: kcPrimaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle.tr(),
          style: const TextStyle(
            color: kcPrimaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
      ],
    );
  }
}
