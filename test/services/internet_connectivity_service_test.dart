import 'package:flutter_test/flutter_test.dart';
import 'package:weather_pal/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('InternetConnectivityServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
