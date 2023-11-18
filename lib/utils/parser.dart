import 'package:weather_pal/models/temperature.dart';
import 'package:weather_pal/models/weather.dart';

extension Parsing on Map<String, dynamic>? {
  double? toDouble(String k) {
    if (this != null) {
      if (this!.containsKey(k)) {
        final val = this![k];
        if (val is String) {
          return double.parse(val);
        } else if (val is num) {
          return val.toDouble();
        }
      }
    }
    return null;
  }

  int? toInt(String k) {
    if (this != null) {
      if (this!.containsKey(k)) {
        final val = this![k];
        if (val is String) {
          return int.parse(val);
        } else if (val is int) {
          return val;
        }
        return -1;
      }
    }
    return null;
  }

  String? unpackString(String k) {
    if (this != null) {
      if (this!.containsKey(k)) {
        return this![k];
      }
    }
    return null;
  }

  DateTime? toDate(String k) {
    if (this != null) {
      if (this!.containsKey(k)) {
        int millis = this![k] * 1000;
        return DateTime.fromMillisecondsSinceEpoch(millis);
      }
    }
    return null;
  }

  Temperature toTemperature(String k) {
    double? kelvin = toDouble(k);
    return Temperature(kelvin);
  }

  List<Weather> parseForecast() {
    List<dynamic> forecastList = this!['list'];
    Map<String, dynamic> city = this!['city'];
    Map<String, dynamic>? coord = city['coord'];
    String? country = city['country'];
    String? name = unpackString('name');
    double? lat = coord?.toDouble('lat');
    double? lon = coord?.toDouble('lon');

    // Convert the json list to a Weather list
    return forecastList.map((w) {
      // Put the general fields inside inside every weather object
      w['name'] = name;
      w['sys'] = {'country': country};
      w['coord'] = {'lat': lat, 'lon': lon};
      return Weather(w);
    }).toList();
  }
}
