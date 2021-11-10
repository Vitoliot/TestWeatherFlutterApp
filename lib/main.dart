import 'package:flutter/material.dart';
import 'package:test_weather_flutter_app/pages/loading.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Loading(),
    );
  }
}
