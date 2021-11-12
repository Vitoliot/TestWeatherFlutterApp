import 'package:flutter/material.dart';
import '../constants.dart';

class WeatherPreview extends StatelessWidget{

  final String time;
  final String image;
  final dynamic data;

  const WeatherPreview({Key key, this.time, this.image, this.data}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      width: 65,
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 9.0),
      decoration: BoxDecoration(
        color: ThemeColors.preview,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.3),
          //   spreadRadius: 0,
          //   blurRadius: 9,
          //   offset: const Offset(0, 9), // changes position of shadow
          // ),
          BoxShadow(
            color: ThemeColors.black.withOpacity(0.2),
            blurRadius: 1
          ),
          BoxShadow(
            color: ThemeColors.background,
            spreadRadius: -12.0,
            blurRadius: 12.0,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 17.0,
                fontStyle: FontStyle.normal,
                fontFamily: 'Manrope',
                // fontWeight: FontWeight.w400,
                color: ThemeColors.black),
          ),
          const Divider(
            height: 10.0,
          ),
          Image.asset(
            image,
            width: 40.0,
          ),
          const Divider(
            height: 10.0,
          ),
          Text(
            data,
            style: TextStyle(
                fontSize: 17.0,
                fontStyle: FontStyle.normal,
                fontFamily: 'Manrope',
                // fontWeight: FontWeight.w400,
                letterSpacing: -1.0, color: ThemeColors.black),
          ),
        ],
      ),
    );
  }

}