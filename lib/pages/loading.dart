import 'package:test_weather_flutter_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_weather_flutter_app/api/daily_weather.dart';
import 'package:test_weather_flutter_app/pages/search.dart';
import 'mainpage.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String currentCity = 'Санкт-Петербург';
  bool darkTheme = false;

  Future<void> getLocationData() async {
    try {
      var weatherDailyInfo = await WeatherApi().fetchWeatherDailyForecast(currentCity);
      var weatherInfo = await WeatherApi().fetchWeatherForecast(currentCity);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MainPage(locationDailyWeather: weatherDailyInfo, locationWeather: weatherInfo);
      }));
    } catch (e) {
      print('this is $e');
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Search();
      }));
    }
  }

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentCity = prefs.getString('activeCity') ?? 'Санкт-Петербург';
    darkTheme = prefs.getBool('themeSettings');

    if (darkTheme) {
      ThemeColors.black = Colors.white;
      ThemeColors.white = Colors.black;
      ThemeColors.weatherBackground = const Color(0xFF0C172B);
      ThemeColors.weatherPreview = const Color(0xFF0D182C);
      ThemeColors.weekGradientStart = const Color(0xFF223B70);
      ThemeColors.weekGradientEnd = const Color(0xFF0F1F40);
      ThemeColors.menuButtons = const Color(0xFF0A1743);
      ThemeImages.background = const AssetImage("assets/images/dark.png");
    }
  }

  void init() async {
    await initPrefs();
    getLocationData();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: ThemeColors.weatherBackground
        ),
        child: Column(
          children: [
            const SizedBox(height: 120.0,),
            Center(
              child: Text(
                "Weather",
                style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                    color: ThemeColors.black
                ),
              ),
            ),
            const SizedBox(height: 120.0,),
            Image.asset('assets/images/loader.png')
          ],
        ),
      ),
    );
  }
}