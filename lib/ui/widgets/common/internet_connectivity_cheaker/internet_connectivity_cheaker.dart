import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'internet_connectivity_cheaker_model.dart';

class InternetConnectivityCheaker
    extends StackedView<InternetConnectivityCheakerModel> {
  const InternetConnectivityCheaker({super.key});

  @override
  Widget builder(
    BuildContext context,
    InternetConnectivityCheakerModel viewModel,
    Widget? child,
  ) {
    return const SizedBox.shrink();
  }

  @override
  InternetConnectivityCheakerModel viewModelBuilder(
    BuildContext context,
  ) =>
      InternetConnectivityCheakerModel();
}
