import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/utils/custom_extension.dart';
import 'package:weather_pal/utils/date_parser.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.locationName = 'Gujranwala',
    this.onTap,
    required this.isLocationEnabled,
  });

  final String locationName;
  final Function? onTap;
  final bool isLocationEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
      ),
      color: kcBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateParser.parse(locale: context.locale.languageCode),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: kcPrimaryTextColor.withOpacity(0.7),
                ),
              ),
              Expanded(
                child: Text(
                  locationName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: kcPrimaryTextColor,
                  ),
                ),
              ),
            ],
          ),
          Tooltip(
            message: isLocationEnabled
                ? 'location_enabled'.tr()
                : 'location_disabled'.tr(),
            child: InkWell(
              onTap: isLocationEnabled ? null : () => onTap?.call(),
              child: Icon(
                Icons.share_location_outlined,
                color: isLocationEnabled ? kcPrimaryTextColor : Colors.red,
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30),
    );
  }
}
