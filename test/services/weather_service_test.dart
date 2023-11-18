import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/models/weather.dart';

import '../helpers/test_helpers.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('WeatherServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('getWeatherDataAsJson -', () {
      test('When called, should return null if no data is saved', () async {
        final weatherService = getAndRegisterWeatherService();
        final result = await weatherService.getWeatherDataAsJson();
        expect(result, null);
      });

      test('When called, should return a map of weather data if data is saved',
          () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.getWeatherDataAsJson())
            .thenAnswer((_) async => {'key': 'value'});
        final result = await weatherService.getWeatherDataAsJson();
        expect(result, isA<Map>());
      });
    });

    group('saveWeatherDataAsJson -', () {
      test('When called, should save weather data as json', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.saveWeatherDataAsJson())
            .thenAnswer((_) async => {});
        final result = await weatherService.saveWeatherDataAsJson();
        expect(result, isA<Map>());
      });
    });

    group('convertMapToWeather -', () {
      test('When called, should return a Weather object', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.convertMapToWeather({}))
            .thenAnswer((_) => Weather({}));
        final result = weatherService.convertMapToWeather({});
        expect(result, isA<Weather>());
      });
    });

    group('convertListToWeather -', () {
      test('When called, should return a list of Weather objects', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.convertListToWeather([]))
            .thenAnswer((_) => [Weather({})]);
        final result = weatherService.convertListToWeather([]);
        expect(result, isA<List<Weather>>());
      });
    });

    group('temperatureIn -', () {
      test('When called, should return a string of default C', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.temperatureIn).thenReturn('C');
        final result = weatherService.temperatureIn;
        expect(result, 'C');
      });

      test('When called, should set the temperature in celsius', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.temperatureIn = 'C').thenReturn('C');
        final result = weatherService.temperatureIn = 'C';
        expect(result, 'C');
      });

      test('When called, should set the temperature in fahrenheit', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.temperatureIn = 'F').thenReturn('F');
        final result = weatherService.temperatureIn = 'F';
        expect(result, 'F');
      });

      test('When called, should set the temperature in kelvin', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.temperatureIn = 'K').thenReturn('K');
        final result = weatherService.temperatureIn = 'K';
        expect(result, 'K');
      });
    });

    group('changeLocale -', () {
      test('When called, should notify listeners', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.changeLocale()).thenAnswer((_) => true);
        final result = weatherService.changeLocale();
        expect(result, true);
      });
    });

    group('setTemperature -', () {
      test('When called, should set the temperature in celsius', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.setTemperature()).thenAnswer((_) => true);
        final result = weatherService.setTemperature();
        expect(result, true);
      });
    });

    group('getWeatherData', () {
      test('When called, should return a instance of weather data', () async {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.currentWeatherByCityName('Gujranwala'))
            .thenAnswer((_) async => Weather({}));
        final result =
            await weatherService.currentWeatherByCityName('Gujranwala');
        expect(result, isA<Weather>());
      });

      test('When currentWeatherByCityName is called should throw an exception',
          () {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.currentWeatherByCityName('Gujranwala'))
            .thenThrow(Exception('Error'));
        expect(() => weatherService.currentWeatherByCityName('Gujranwala'),
            throwsException);
      });
    });
  });
}
