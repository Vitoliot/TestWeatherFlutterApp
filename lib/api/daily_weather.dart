import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:test_weather_flutter_app/api/models.dart';
import 'package:test_weather_flutter_app/constants.dart';


class WeatherApi {

  Future<WeatherDailyForecast> fetchWeatherDailyForecast(String city) async {

  var params = {
    'appid':Constants.WEATHER_APP_ID,
    'units':'metric',
    'q':city
  };


  var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN, Constants.WEATHER_FORECAST_PATH, params);
  log('request: ${uri.toString()}');

  var response = await http.get(uri);

  // ignore: avoid_print
  print('response: ${response.body}');

  if (response.statusCode == 200) {
    return WeatherDailyForecast.fromJson(json.decode(response.body));
  }
  else {
    return Future.error('Error response');
  }
}
  Future<WeatherDailyForecast> fetchWeatherForecast(String city) async {

    var params = {
      'cnt' : '1',
      'appid':Constants.WEATHER_APP_ID,
      'units':'metric',
      'q':city
    };


    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN, Constants.WEATHER_FORECAST_PATH, params);
    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    // ignore: avoid_print
    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherDailyForecast.fromJson(json.decode(response.body));
    }
    else {
      return Future.error('Error response');
    }
  }
}
