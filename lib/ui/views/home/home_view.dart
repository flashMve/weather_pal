import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:we_slide/we_slide.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/widgets/home/home_close_panel.dart';

import 'package:weather_pal/ui/widgets/home/home_panel/home_panel.dart';
import 'package:weather_pal/ui/widgets/home/app_bar.dart';
import 'package:weather_pal/ui/widgets/home/home_body.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final double panelMaxSize = MediaQuery.of(context).size.height * .9;

    return Scaffold(
      body: WeSlide(
        hideAppBar: true,
        backgroundColor: kcBackgroundColor,
        // AppBar of the page
        appBar: HomeAppBar(
          locationName: viewModel.weather.areaName ?? "",
          isLocationEnabled: viewModel.locationEnabled,
          onTap: () => viewModel.openSettings(),
        ),
        appBarHeight: 100,
        // Body of the page
        body: HomeBody(
          weather: viewModel.weather,
          unit: viewModel.weatherService.temperatureIn,
        ),
        panel: HomePanel(panelMaxSize: panelMaxSize),
        panelHeader: PanelHeader(
          viewModel: viewModel,
        ),
        hidePanelHeader: false,
        panelMaxSize: panelMaxSize,
        panelMinSize: 120,
        transformScale: true,
        parallax: true,
        blur: true,
      ),
    );
  }

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.initState();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
