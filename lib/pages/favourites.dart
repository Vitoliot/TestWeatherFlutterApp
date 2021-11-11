import 'package:flutter/material.dart';
import 'package:test_weather_flutter_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loading.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<String> cities = [];

  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cities = prefs.getStringList('savedcities');
    });
    if (prefs.getStringList('cities') == null) {
      prefs.setStringList('savedcities', []);
    }
  }

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.weatherBackground,
        iconTheme: IconThemeData(
          color: ThemeColors.black,
        ),
        elevation: 0.0,
        title: Text(
          'Избранные',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: ThemeColors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: ThemeColors.weatherBackground),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: ListView.separated(
            itemCount: cities.length,
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              String word = cities[index];

              return Container(
                decoration: BoxDecoration(
                    color: ThemeColors.weatherBackground,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: -6.0,
                        blurRadius: 12.0,
                      ),
                    ]),
                child: ListTile(
                  title: Text(word, style: TextStyle(color: ThemeColors.black),),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: ThemeColors.black,
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      setState(() {
                        cities.removeAt(index);
                      });
                      prefs.setStringList('savedcities', cities);
                    },
                  ),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('activeCity', cities.elementAt(index));
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                          return const Loading();}), (route) => false);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}