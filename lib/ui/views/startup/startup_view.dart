import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_pal/ui/common/app_colors.dart';
import 'package:weather_pal/ui/common/ui_helpers.dart';
import 'package:weather_pal/ui/widgets/common/drop_shadow/drop_shadow.dart';
import 'package:weather_pal/ui/widgets/common/glass_effect/glass_effect.dart';
import 'package:weather_pal/utils/custom_extension.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: kcBackgroundColor,
        body: MeshGradientBackground(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                  ),
                  child: const Center(
                    child: DropShadow(
                      spread: 0.1,
                      blurRadius: 6,
                      child: Image(
                        image: AssetImage('assets/weather/01d.png'),
                      ),
                    ),
                  )
                      .animate()
                      .fade()
                      .then(delay: 500.ms)
                      .shake(duration: 500.ms)
                      .then(delay: 500.ms)
                      .fadeOut()
                      .swap(builder: (_, __) {
                    return const Center(
                      child: DropShadow(
                        spread: 0.1,
                        blurRadius: 30,
                        child: Image(
                          image: AssetImage('assets/weather/01n.png'),
                          alignment: Alignment.center,
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .then(delay: 300.ms)
                        .shimmer();
                  }),
                ),
              ),

              // Description
              Stack(
                children: [
                  GlassEffect(
                    size: Size(screenWidth(context), 300),
                    borderRadius: 40,
                    color: Colors.black.withOpacity(0.8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'on_boarding_title'.tr(),
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(context, max: 30),
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            color: kcPrimaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        )
                            .paddingOnly(left: 30, right: 30)
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .shimmer(
                              color: kcPrimaryColor.withOpacity(0.3),
                              duration: 2000.ms,
                            ),
                        verticalSpaceMedium,
                        Text(
                          'on_boarding_text'.tr(),
                          style: TextStyle(
                            fontSize: getResponsiveFontSize(context, max: 16),
                            fontWeight: FontWeight.w500,
                            color: kcPrimaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(horizontal: 20),
                        if (!viewModel.done || !viewModel.loadingSplash)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: kcSecondaryBackgroundColor,
                                    strokeWidth: 0.8,
                                  ),
                                ),
                              ),
                              horizontalSpaceMedium,
                              Text(
                                viewModel.internet.isConnected
                                    ? 'loading'.tr()
                                    : 'no_internet'.tr(),
                                style: TextStyle(
                                  fontSize:
                                      getResponsiveFontSize(context, max: 14),
                                  fontWeight: FontWeight.w500,
                                  color: kcPrimaryTextColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ).paddingOnly(top: 8),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: -55,
                    right: -30,
                    child: Image(
                      image: AssetImage('assets/weather/storm.png'),
                      alignment: Alignment.center,
                      height: 180,
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: const Image(
                      image: AssetImage('assets/weather/zaps.png'),
                      alignment: Alignment.center,
                      height: 80,
                    )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .shake()
                        .then(delay: 1000.ms),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
