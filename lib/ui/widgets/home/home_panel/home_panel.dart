import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/common/ui_helpers.dart';
import 'package:weather_pal/ui/widgets/common/custom_radio_button/custom_radio_button.dart';
import 'package:weather_pal/ui/widgets/home/forecast_info_card/forecast_info_card.dart';

import 'home_panel_model.dart';

class HomePanel extends StackedView<HomePanelModel> {
  const HomePanel({super.key, required this.panelMaxSize});

  final double panelMaxSize;

  @override
  Widget builder(
    BuildContext context,
    HomePanelModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: kcSecondaryBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: screenWidth(context),
      height: panelMaxSize - 120,
      padding: const EdgeInsets.only(top: 120),
      child: Column(
        children: [
          const Divider(
            color: Colors.blueGrey,
            height: 5.0,
            thickness: 0.3,
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: screenWidth(context),
                    child: TabBar(
                      labelColor: kcPrimaryTextColor,
                      unselectedLabelColor: kcSecondaryTextColor,
                      indicator: BoxDecoration(
                          color: kcPrimaryColor,
                          borderRadius: BorderRadius.circular(4)),
                      indicatorSize: TabBarIndicatorSize.tab,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.wb_sunny_outlined,
                                size: 14,
                              ),
                              horizontalSpaceSmall,
                              const Text(
                                'forecast',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.settings,
                                size: 14,
                              ),
                              horizontalSpaceSmall,
                              const Text(
                                'settings',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ).tr(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      ListView.builder(
                        itemBuilder: (ctx, index) {
                          log('${viewModel.forecast[index].date}');
                          return ForecastInfoCard(
                            weather: viewModel.forecast[index],
                            unit: viewModel.weatherService.temperatureIn,
                          );
                        },
                        itemCount: viewModel.forecast.length,
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            width: screenWidth(context),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                const Text(
                                  'temperature_unit',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ).tr(),
                                verticalSpaceSmall,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'unit'.tr(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomRadioButton(
                                        elevation: 0,
                                        // width: 150,
                                        radius: 0,
                                        enableShape: true,
                                        absoluteZeroSpacing: true,
                                        shapeRadius: 0,
                                        padding: 0,
                                        height: 25,
                                        unSelectedColor:
                                            kcSecondaryBackgroundColor,
                                        buttonLables: const ['°C', '°F', '°K'],
                                        buttonValues: const ["C", "F", 'K'],
                                        defaultSelected: viewModel
                                            .weatherService.temperatureIn,
                                        radioButtonValue: (value) =>
                                            viewModel.onTemperatureUnitChanged(
                                                value, context),
                                        selectedColor: kcPrimaryColor,
                                        selectedBorderColor:
                                            kcSecondaryBackgroundColor,
                                        unSelectedBorderColor:
                                            kcSecondaryBackgroundColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(14),
                            width: screenWidth(context),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                const Text(
                                  'language_settings',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ).tr(),
                                verticalSpaceSmall,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'select_language',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ).tr(),
                                    CustomRadioButton(
                                      elevation: 0,
                                      // width: 150,
                                      radius: 0,
                                      enableShape: true,
                                      absoluteZeroSpacing: true,
                                      shapeRadius: 0,
                                      padding: 0,
                                      height: 25,
                                      unSelectedColor:
                                          kcSecondaryBackgroundColor,
                                      buttonLables: [
                                        'english'.tr(),
                                        'arabic'.tr()
                                      ],
                                      buttonValues: const ["en", "ar"],
                                      defaultSelected:
                                          context.locale.languageCode,
                                      radioButtonValue: (value) => viewModel
                                          .onLanguageChanged(value, context),
                                      selectedColor: kcPrimaryColor,
                                      selectedBorderColor:
                                          kcSecondaryBackgroundColor,
                                      unSelectedBorderColor:
                                          kcSecondaryBackgroundColor,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomePanelModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomePanelModel();
}
