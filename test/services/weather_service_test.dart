import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_pal/app/app.locator.dart';
import 'package:weather_pal/custom_exceptions/weather_api_exception.dart';
import 'package:weather_pal/models/weather.dart';
import 'package:weather_pal/utils/date_parser.dart';

import '../helpers/test_helpers.dart';

void main() {
  Map<String, dynamic> mockWeatherData = {
    "coord": {"lon": 31.4167, "lat": 73.0833},
    "weather": [
      {"id": 501, "main": "Rain", "description": "moderate rain", "icon": "10d"}
    ],
    "base": "stations",
    "main": {
      "temp": 298.48,
      "feels_like": 298.74,
      "temp_min": 297.56,
      "temp_max": 300.05,
      "pressure": 1015,
      "humidity": 64,
      "sea_level": 1015,
      "grnd_level": 933
    },
    "visibility": 10000,
    "wind": {"speed": 0.62, "deg": 349, "gust": 1.18},
    "rain": {"1h": 3.16},
    "clouds": {"all": 100},
    "dt": 1661870592,
    "sys": {
      "type": 2,
      "id": 2075663,
      "country": "IT",
      "sunrise": 1661834187,
      "sunset": 1661882248
    },
    "timezone": 7200,
    "id": 3163858,
    "name": "Gujranwala",
    "cod": 200
  };
  group('WeatherServiceTest -', () {
    setUp(() {
      registerServices();
    });
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

    group('get Current Day WeatherData ', () {
      group('When Called with City Name Function', () {
        test(
            'When currentWeatherByCityName is called, should return a instance of weather data and weatherData should contain the data',
            () async {
          final weatherService = getAndRegisterWeatherService(returnData: true);
          when(weatherService.currentWeatherByCityName('Gujranwala'))
              .thenAnswer((_) async => Weather({}));

          final result =
              await weatherService.currentWeatherByCityName('Gujranwala');
          verify(weatherService.currentWeatherByCityName('Gujranwala'));
          expect(result, isA<Weather>());
          expect(weatherService.weatherData.containsKey(DateParser.parse()),
              isTrue);
        });

        test(
            'When currentWeatherByCityName is called should throw an exception',
            () {
          final weatherService = getAndRegisterWeatherService();
          // Stubing the function to throw an exception
          when(weatherService.currentWeatherByCityName('Gujranwala'))
              .thenThrow(OpenWeatherAPIException('Error'));
          expect(() => weatherService.currentWeatherByCityName('Gujranwala'),
              throwsException);
        });
      });

      group('When called Latitude and Longitude Function', () {
        test(
            'When currentWeatherByLatLong is called, should return a instance of weather data with area name Gujranwala',
            () async {
          final weatherService = getAndRegisterWeatherService(returnData: true);
          when(weatherService.currentWeatherByLocation(31.4167, 73.0833))
              .thenAnswer((_) async => Weather(mockWeatherData));

          final result =
              await weatherService.currentWeatherByLocation(31.4167, 73.0833);
          expect(result, isA<Weather>());
          expect(result.areaName, 'Gujranwala');
          expect(
              weatherService.weatherData.containsKey(DateParser.parse()), true);
        });

        test('When currentWeatherByLatLong is called should throw an exception',
            () {
          final weatherService = getAndRegisterWeatherService();
          when(weatherService.currentWeatherByLocation(31.4167, 73.0833))
              .thenThrow(OpenWeatherAPIException('Error'));
          expect(
              () => weatherService.currentWeatherByLocation(31.4167, 73.0833),
              throwsException);
        });
      });
    });
  });

  group('get Forecast of next 5 days', () {
    test(
        'When fiveDayForecastByCityName is called, should return a List of weather data length 5',
        () async {
      final weatherService = getAndRegisterWeatherService();

      when(weatherService.fiveDayForecastByCityName('Gujranwala'))
          .thenAnswer((_) async => List.filled(5, Weather({})));

      final result =
          await weatherService.fiveDayForecastByCityName('Gujranwala');
      expect(result, isA<List>());
      expect(result.length, 5);
    });

    test('When currentWeatherByCityName is called should throw an exception',
        () {
      final weatherService = getAndRegisterWeatherService();
      when(weatherService.currentWeatherByCityName('Gujranwala'))
          .thenThrow(OpenWeatherAPIException('Error'));
      expect(() => weatherService.currentWeatherByCityName('Gujranwala'),
          throwsException);
    });

    group('When called Latitude and Longitude Function for forecast', () {
      test(
          'When fiveDayForecastByLocation is called, should return a List of weather data length 5',
          () async {
        final weatherService = getAndRegisterWeatherService();

        when(weatherService.fiveDayForecastByLocation(31.4167, 73.0833))
            .thenAnswer((_) async => List.filled(5, Weather({})));

        final result =
            await weatherService.fiveDayForecastByLocation(31.4167, 73.0833);
        expect(result, isA<List>());
        expect(result.length, 5);
      });

      test('When fiveDayForecastByLocation is called should throw an exception',
          () {
        final weatherService = getAndRegisterWeatherService();
        when(weatherService.fiveDayForecastByLocation(31.4167, 73.0833))
            .thenThrow(OpenWeatherAPIException('Error'));
        expect(() => weatherService.fiveDayForecastByLocation(31.4167, 73.0833),
            throwsException);
      });
    });
  });
}
