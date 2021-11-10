import 'package:flutter/material.dart';
import 'package:test_weather_flutter_app/api/models.dart';
import 'package:test_weather_flutter_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_weather_flutter_app/pages/about.dart';
import 'package:test_weather_flutter_app/pages/favourites.dart';
import 'package:test_weather_flutter_app/pages/settings.dart';
import 'package:test_weather_flutter_app/pages/week_weather.dart';
import 'package:test_weather_flutter_app/pages/search.dart';
import 'package:test_weather_flutter_app/widgets/weather_info.dart';
import 'package:test_weather_flutter_app/widgets/weather_preview.dart';

class MainPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final locationDailyWeather;
  // ignore: prefer_typing_uninitialized_variables
  final locationWeather;
  const MainPage({Key key, this.locationWeather, this.locationDailyWeather}) : super(key: key);


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  bool sheetIsActive = false;

  String currentCity = 'Санкт-Петербург';

  Future<WeatherDailyForecast> dailydata;

  Future<WeatherDailyForecast> data;

  bool isC = true;
  bool isMpS = true;
  bool isMm = true;

  DateFormat dateFormat;

  AnimationController _controller;

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool C = prefs.getBool('tempSettings');
      bool MpS = prefs.getBool('windSettings');
      bool Mm = prefs.getBool('paSettings');
      if (C != null) {isC = C;}
      if (MpS != null) {isMpS = MpS;}
      if (Mm != null)  {isMm = Mm;}
      currentCity = prefs.getString('activeCity') ?? 'Санкт-Петербург';
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('ru');
    if (widget.locationDailyWeather != null) {
      dailydata = Future.value(widget.locationDailyWeather);
    }
    if (widget.locationWeather != null) {
      data = Future.value(widget.locationWeather);
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    initPrefs();


  }

  String getWeatherIconPath(weather) {
    switch (weather) {
      case 'Clouds': {
        return 'assets/images/weather_state/states/cloudy.png';
      }
      case 'Clear': {
        return  'assets/images/weather_state/sun.png';
      }
      case 'Rain': {
        return 'assets/images/weather_state/states/rainy.png';
      }
      default: {
        return 'assets/images/weather_state/states/partly_cloudy.png';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();


    Widget bottomArea = NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification DSNotification) {
        if (DSNotification.extent >= 0.5) {
          setState(() {
            sheetIsActive = true;
            _controller.forward();
          });
        } else if (DSNotification.extent < 0.5) {
          setState(() {
            sheetIsActive = false;
            _controller.reverse();
          });
        } else {
          setState(() {
            sheetIsActive = sheetIsActive;
          });
        }
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
            child: Container(
              color: ThemeColors.weatherBackground,
              child: FutureBuilder<WeatherDailyForecast> (
                future : data,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 50.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                                width: 60.0,
                                height: 6.0,
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0.0,
                                  8.0 + (sheetIsActive ? 16.0 : 0.0), 0.0, 16.0),
                              child: Center(
                                child: AnimatedContainer(
                                  color: ThemeColors.weatherBackground,
                                  width: sheetIsActive ? 500.0 : 0.0,
                                  height: sheetIsActive ? 20.0 : 0.0,
                                  duration: const Duration(milliseconds: 200),
                                  child: Center(
                                    child: Text(
                                    dateFormat.format(dateTime),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 17.0, color: ThemeColors.black),
                                  ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                              <Widget>[
                                WeatherPreview(time: '06:00',
                                    image: getWeatherIconPath(snapshot.data.list[0].weather[0].main),
                                    data: '${(isC ? (snapshot.data.list[0].temp.morn) : (snapshot.data.list[0].temp.morn)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                                WeatherPreview(time: '12:00',
                                    image: getWeatherIconPath(snapshot.data.list[0].weather[0].main),
                                    data: '${(isC ? (snapshot.data.list[0].temp.day) : (snapshot.data.list[0].temp.day)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                                WeatherPreview(time: '18:00',
                                    image: getWeatherIconPath(snapshot.data.list[0].weather[0].main),
                                    data: '${(isC ? (snapshot.data.list[0].temp.eve) : (snapshot.data.list[0].temp.eve)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                                WeatherPreview(time: '00:00',
                                    image: getWeatherIconPath(snapshot.data.list[0].weather[0].main),
                                    data: '${(isC ? (snapshot.data.list[0].temp.night) : (snapshot.data.list[0].temp.night)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                              ],
                            ),
                            const Divider(
                              height: 16.0,
                              thickness: 0.0,
                              color: Colors.transparent,
                            ),
                            if (!sheetIsActive)
                              Center(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return WeatherAppWeek(locationDailyWeather: dailydata);
                                    }));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                              (states) {
                                            if (states.contains(MaterialState.pressed)) {
                                              return ThemeColors.weatherBackground;
                                            }
                                            return ThemeColors.weatherBackground;
                                          }),
                                      overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                              (states) {
                                            if (states.contains(MaterialState.pressed)) {
                                              return Colors.white;
                                            }
                                            return Colors.transparent;
                                          }),
                                      side: MaterialStateProperty.resolveWith((states) {
                                        Color _borderColor;
                                        if (states.contains(MaterialState.pressed)) {
                                          _borderColor = Colors.white;
                                        }
                                        _borderColor = Colors.blue;

                                        return BorderSide(color: _borderColor, width: 1);
                                      }),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder>((_) {
                                        return RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10));
                                      }),
                                    ),
                                    child: const Text("Прогноз на неделю"),
                                  )),
                            const Divider(
                              height: 16.0,
                              thickness: 0.0,
                              color: Colors.transparent,
                            ),
                            if (sheetIsActive)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      WeatherInfo(
                                          image: 'assets/images/main_weather_info/thermometer.png',
                                          data: '${(isC ? (snapshot.data.list[0].temp.min) : (snapshot.data.list[0].temp.min)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}'),
                                      const Divider(
                                        height: 8.0,
                                        thickness: 0.0,
                                        color: Colors.transparent,
                                      ),
                                      WeatherInfo(
                                          image: 'assets/images/main_weather_info/breeze.png',
                                          data: '${(isMpS ? (snapshot.data.list[0].speed) : (snapshot.data.list[0].speed) * 3.6).toStringAsFixed(1)}${isMpS ? 'м/с' : 'км/ч'}'),
                                    ],
                                  ),
                                  // VerticalDivider(
                                  //   width: 20.0,
                                  //   thickness: 0,
                                  //   color: Colors.transparent,
                                  // ),
                                  Column(
                                    children: <Widget>[
                                      WeatherInfo(
                                          image: 'assets/images/main_weather_info/humidity.png',
                                          data: '${snapshot.data.list[0].humidity}%'),
                                      const Divider(
                                        height: 8.0,
                                        thickness: 0.0,
                                        color: Colors.transparent,
                                      ),
                                      WeatherInfo(
                                          image: 'assets/images/main_weather_info/barometer.png',
                                          data: '${(snapshot.data.list[0].pressure)} ${isMm ? 'мм.рт.ст' : 'кПа'}'),
                                    ],
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    );
                  }
                  else {
                    return const Center(
                      child: Text(
                        'City not found\nPlease, enter correct city',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              )
            ),
          );
        },
      ),
    );

    return Scaffold(
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              color: ThemeColors.weatherBackground
          ),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 32.0, 0.0, 0.0),
                child: Column(
                  children: [
                    Text("Weather app",
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.w800, color: ThemeColors.black)),
                    InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/burger_icons/settings.png', color: ThemeColors.black),
                                const VerticalDivider(
                                  width: 14.0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'Настройки',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const Settings();
                        }));
                      },
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/burger_icons/favorite_border.png', color: ThemeColors.black),
                                const VerticalDivider(
                                  width: 14.0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'Избранные',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const Favourites();}));
                      },
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 42.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/images/burger_icons/account_circle.png', color: ThemeColors.black),
                                const VerticalDivider(
                                  width: 14.0,
                                  thickness: 0,
                                  color: Colors.transparent,
                                ),
                                Text(
                                  'О приложении',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: ThemeColors.black
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return const About();}));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) => Container(
          padding: const EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ThemeImages.background,
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: FutureBuilder<WeatherDailyForecast>(
                  future: data,
                  builder: (context, snapshot) {
                  return Column(
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0.0, 0.0 + (50.0 * _controller.value)),
                          child: Text("${(isC ? (snapshot.data.list[0].temp.min) : (snapshot.data.list[0].temp.min)*9/5 + 32).toStringAsFixed(1)}${isC ? '˚C' : '˚F'}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 80.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: -10.0,
                                  height: 1.15)),
                        );
                      },
                    ),
                    AnimatedOpacity(
                      opacity: !sheetIsActive ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(dateFormat.format(dateTime),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ),
                          ],
                  );}
                ),
            ),
            ),
            bottomArea,
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RawMaterialButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        elevation: 4.0,
                        fillColor: ThemeColors.menuButtons,
                        child: const Icon(
                          Icons.menu,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(7.5),
                        shape: const CircleBorder(),
                      ),
                      AnimatedOpacity(
                        opacity: sheetIsActive ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          currentCity,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const Search();}));
                        },
                        elevation: 4.0,
                        fillColor: ThemeColors.menuButtons,
                        child: const Icon(
                          Icons.add,
                          size: 20.0,
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(7.5),
                        shape: const CircleBorder(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}