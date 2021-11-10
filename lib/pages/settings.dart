import 'package:flutter/material.dart';
import 'package:test_weather_flutter_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loading.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool tempSettings = true;
  bool windSettings = true;
  bool paSettings = true;
  bool themeSettings = true;

  Future<void> initSettings() async {
    SharedPreferences folder = await SharedPreferences.getInstance();
    setState(() {
      bool temp = folder.getBool('tempSettings');
      bool wind = folder.getBool('windSettings');
      bool pa = folder.getBool('paSettings');
      bool theme = folder.getBool('themeSettings');
      if (temp != null) {tempSettings = temp;}
      if (wind != null) {windSettings = wind;}
      if (pa != null) {paSettings = pa;}
      if (theme != null) {themeSettings = theme;}
    });
  }

  @protected
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    initSettings();
  }

  Widget createSetting(
      name, value, attrName, attrList, valuesNamesList) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              color: ThemeColors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w600),
        ),
        Container(
          height: 25.0,
          decoration: BoxDecoration(
            color: ThemeColors.weatherBackground,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 9,
                offset: const Offset(0, 9), // changes position of shadow
              ),
            ],
          ),
          child: ToggleButtons(
            children: <Widget>[
              SizedBox(
                width: 65.0,
                child: Center(
                  child: Text(
                    valuesNamesList[0],
                    style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
                  ),
                ),
              ),
              SizedBox(
                width: 65.0,
                child: Center(
                  child: Text(
                    valuesNamesList[1],
                    style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
                  ),
                ),
              ),
            ],
            isSelected: attrList,
            borderRadius: BorderRadius.circular(20.0),
            color: ThemeColors.black,
            selectedColor: Colors.white,
            fillColor: Color(0x4B5F8888),
            onPressed: (int index) async {
              if (attrName == 'themeSettings') {
                if (attrList[0]) { // light
                  ThemeColors.black = Colors.black;
                  ThemeColors.white = Colors.white;
                  ThemeColors.weatherBackground = const Color(0xFFE2EBFF);
                  ThemeColors.weatherPreview = const Color(0xFFE0E9FD);
                  ThemeColors.weekGradientStart = const Color(0xFFCDDAF5);
                  ThemeColors.weekGradientEnd = const Color(0xFF9CBCFF);
                  ThemeColors.menuButtons = const Color(0xFF0256FF);
                  ThemeImages.background = const AssetImage("assets/images/light.png");
                } else {
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                for (int i = 0; i < attrList.length; i++) {
                  if (i == index) {
                    attrList[i] = true;}
                  else {attrList[i] = false;}
                }
              });
              prefs.setBool(attrName, attrList[0]);
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return const Settings();}));
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.weatherBackground,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
                  return const Loading();}), (route) => false);
            // Navigator.pop(context);
            },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        iconTheme: IconThemeData(
          color: ThemeColors.black,
        ),
        title: Text(
          'Настройки',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: ThemeColors.black,
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          color: ThemeColors.weatherBackground,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
                child: Row(
                  children: const [
                    Text(
                      'Единицы измерения',
                      style: TextStyle(
                          color: Color(0xFF828282),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                width: 375.0,
                decoration: BoxDecoration(
                  color: ThemeColors.weatherBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 9,
                      offset: const Offset(0, 9), // changes position of shadow
                    ),
                    BoxShadow(
                      color: ThemeColors.black,
                    ),
                    BoxShadow(
                      color: ThemeColors.weatherBackground,
                      spreadRadius: -12.0,
                      blurRadius: 12.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      createSetting(
                          'Температура',
                          tempSettings,
                          "tempSettings",
                          [tempSettings, !tempSettings],
                          ['˚C', '˚F']),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: Colors.black.withOpacity(.15),
                      ),
                      createSetting(
                          'Сила ветра',
                          windSettings,
                          "windSettings",
                          [windSettings, !windSettings],
                          ['м/с', 'км/ч']),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: Colors.black.withOpacity(.15),
                      ),
                      createSetting(
                          'Давление',
                          paSettings,
                          "paSettings",
                          [paSettings, !paSettings],
                          ['мм.рт.ст.', 'гПа']),
                      Divider(
                        height: 32.0,
                        thickness: 1.0,
                        color: Colors.black.withOpacity(.15),
                      ),
                      createSetting(
                          'Тема оформления',
                          themeSettings,
                          "themeSettings",
                          [themeSettings, !themeSettings],
                          ['Темная', 'Светлая']),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       vertical: 16.0, horizontal: 20.0),
              //   child: Row(
              //     children: const [
              //       Text(
              //         'Изменения применятся после перезагрузки, или:',
              //         style: TextStyle(
              //             color: Color(0xFF828282),
              //             fontSize: 10.0,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ],
              //   ),
              // ),
              // OutlinedButton(
              //   onPressed: () {
              //     Navigator.pushAndRemoveUntil(context,
              //         MaterialPageRoute(builder: (context) {
              //           return const Loading();}), (route) => false);
              //   },
              //   style: ButtonStyle(
              //     backgroundColor:
              //     MaterialStateProperty.resolveWith<Color>(
              //             (states) {
              //           if (states.contains(MaterialState.pressed)) {
              //             return ThemeColors.weatherBackground;
              //           }
              //           return ThemeColors.weatherBackground;
              //         }),
              //     overlayColor:
              //     MaterialStateProperty.resolveWith<Color>(
              //             (states) {
              //           if (states.contains(MaterialState.pressed)) {
              //             return Colors.white;
              //           }
              //           return Colors.transparent;
              //         }),
              //     side: MaterialStateProperty.resolveWith((states) {
              //       Color _borderColor;
              //       if (states.contains(MaterialState.pressed)) {
              //         _borderColor = Colors.white;
              //       }
              //       _borderColor = Colors.blue;
              //
              //       return BorderSide(color: _borderColor, width: 1);
              //     }),
              //     shape: MaterialStateProperty.resolveWith<
              //         OutlinedBorder>((_) {
              //       return RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10));
              //     }),
              //   ),
              //   child: const Text("Применить"),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
