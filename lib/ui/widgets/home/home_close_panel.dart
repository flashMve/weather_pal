import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/views/home/home_viewmodel.dart';
import 'package:weather_pal/ui/widgets/home/weather_info_card.dart';

class PanelHeader extends StatelessWidget {
  const PanelHeader({
    super.key,
    required this.viewModel,
  });
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        color: kcSecondaryBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WeatherInfoCard(
            title: viewModel.weather.humidity != null
                ? '${viewModel.weather.humidity!.toStringAsFixed(1)}%'
                : "Nil",
            subtitle: 'humidity'.tr(),
          ),
          WeatherInfoCard(
            icon: 'assets/weather/rain_chance.png',
            title: viewModel.weather.pressure != null
                ? '${viewModel.weather.pressure!.toStringAsFixed(0)} hPa'
                : "Nil",
            subtitle: 'pressure'.tr(),
          ),
          WeatherInfoCard(
            icon: 'assets/weather/wind.png',
            title: viewModel.weather.windSpeed != null
                ? '${viewModel.weather.windSpeed} km/h'
                : "Nil",
            subtitle: 'wind_speed'.tr(),
          ),
        ],
      ),
    );
  }
}
