import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/ui/views/startup/startup_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  StartupViewModel getModel() => StartupViewModel();
  group('StartupViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('Initial Call done and loadingSplash, should be false', () {
      test('When called, should return false', () async {
        final model = getModel();
        expect(model.done, false);
        expect(model.loadingSplash, false);
      });

      test('When called, should return true', () async {
        final model = getModel();
        model.done = true;
        model.loadingSplash = true;
        expect(model.done, true);
        expect(model.loadingSplash, true);
      });
    });

    group('runStartUp Login', () {
      test('When called, done should return true', () async {
        final model = getModel();

        await model.initState();

        expect(model.done, true);
        expect(model.loadingSplash, false);
        // verify(snackBar.showSnackbar(message: 'error_fetching_data'.tr()));
      });

      test('When called, loadingSplash should return true', () async {
        final model = getModel();

        when(model.initState()).thenAnswer((_) async {
          model.done = true;
        });

        await model.runStartupLogic();

        expect(model.loadingSplash, true);
        expect(model.done, true);
      });
    });
  });
}
