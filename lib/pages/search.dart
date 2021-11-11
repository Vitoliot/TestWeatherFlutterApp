import 'package:flutter/material.dart';
import 'package:test_weather_flutter_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loading.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() =>
      _SearchState();
}

class _SearchState extends State<Search> {
  List<String> constCities = ['Санкт-Петербург', 'Москва'];
  List<String> cities = ['Санкт-Петербург', 'Москва'];
  Set<String> savedCities = <String>{};
  String city;
  Future<void> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('cities') == null) {
      prefs.setStringList('cities', savedCities.toList());
    }
    setState(() {
      cities =
          (prefs.getStringList('cities') ?? ['Санкт-Петербург']);
      if (prefs.getStringList('savedcities') == null)
      {
      savedCities = constCities.toSet();
      }
      else {savedCities = prefs.getStringList('savedcities').toSet();}
    });

  }

  final _controller = TextEditingController();


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
          'Добавить в избранные',
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontFamily: 'Manrope',
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
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Manrope',
                    color: ThemeColors.black
                ),
                controller: _controller,
                onEditingComplete: () {
                  cities.add(city);
                  setState(() async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setStringList('cities', cities);
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const Search();}));
                  }
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Введите город...',
                  hintStyle: TextStyle(fontStyle: FontStyle.normal,
                      fontFamily: 'Manrope',color: ThemeColors.black),
                  suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: const Icon(Icons.clear),
                    color: ThemeColors.black,
                  ),
                ),
                onChanged: (value) {
                   city = value;
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: cities.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    String word = cities[index];
                    bool isSaved = savedCities.contains(word);

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
                        title: Text(word, style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Manrope',
                            color: ThemeColors.black),),
                        trailing: IconButton(
                                icon: Icon(isSaved ? Icons.star : Icons.star_border),
                                color: ThemeColors.black,
                                onPressed: () async {
                                  setState(() {
                                    isSaved
                                        ? savedCities.remove(word)
                                        : savedCities.add(word);
                                  });
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setStringList("savedcities", savedCities.toList());
                                },),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                           prefs.setString('activeCity', cities.elementAt(index));
                            Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                              return const Loading();}), (route) => false);},
                        onLongPress: () async {
    setState(() {
          cities.remove(word);
        });
        SharedPreferences prefs =
        await SharedPreferences.getInstance();
        prefs.setStringList("cities", cities);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}