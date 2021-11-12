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
  Future<List<Weather>> fetchWeatherForecast(String city) async {
    print('hello');
    var params = {
      'cnt' : '8',
      'appid':Constants.WEATHER_APP_ID,
      'units':'metric',
      'q':city
    };


    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN, Constants.WEATHER, params);
    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    // ignore: avoid_print
    print('response: ${response.body}');

    if (response.statusCode == 200) {
      List<Weather> weatherforhour = [];
      List list =  json.decode(response.body)['list'][0]['weather'];
      for (int i = 0; i < list.length; i++){
        weatherforhour.add(Weather.fromJson(list[i]));
      }
      return json.decode(response.body)['list'][0]['weather'];
    }
    else {
      return Future.error('Error response');
    }
  }
}
