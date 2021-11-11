import 'package:test_weather_flutter_app/constants.dart';


class WeatherDailyForecast {
  City city;
  String cod;
  double message;
  int cnt;
  List<WeatherList> list;

  WeatherDailyForecast({this.city, this.cod, this.message, this.cnt, this.list});

  WeatherDailyForecast.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list.add(WeatherList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (city != null) {
      data['city'] = city.toJson();
    }
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (list != null) {
      data['list'] = list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;

  City(
      {this.id,
        this.name,
        this.coord,
        this.country,
        this.population,
        this.timezone});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (coord != null) {
      data['coord'] = coord.toJson();
    }
    data['country'] = country;
    data['population'] = population;
    data['timezone'] = timezone;
    return data;
  }
}

class Coord {
  double lon;
  double lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class WeatherList {
  num dt;
  num sunrise;
  num sunset;
  Temp temp;
  FeelsLike feelsLike;
  num pressure;
  num humidity;
  List<Weather> weather;
  num speed;
  num deg;
  num clouds;
  num rain;

  WeatherList(
      {this.dt,
        this.sunrise,
        this.sunset,
        this.temp,
        this.feelsLike,
        this.pressure,
        this.humidity,
        this.weather,
        this.speed,
        this.deg,
        this.clouds,
        this.rain});

  WeatherList.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    feelsLike = json['feels_like'] != null
        ? FeelsLike.fromJson(json['feels_like'])
        : null;
    pressure = json['pressure'];
    humidity = json['humidity'];
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }
    speed = json['speed'];
    deg = json['deg'];
    clouds = json['clouds'];
    rain = json['rain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    if (temp != null) {
      data['temp'] = temp.toJson();
    }
    if (feelsLike != null) {
      data['feels_like'] = feelsLike.toJson();
    }
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    if (weather != null) {
      data['weather'] = weather.map((v) => v.toJson()).toList();
    }
    data['speed'] = speed;
    data['deg'] = deg;
    data['clouds'] = clouds;
    data['rain'] = rain;
    return data;
  }

  String getIconUrl() {
    return Constants.WEATHER_IMAGES_URL + weather[0].icon + '.png';
  }
}

class Temp {
  num day;
  num min;
  num max;
  num night;
  num eve;
  num morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  Temp.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    min = json['min'];
    max = json['max'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class FeelsLike {
  num day;
  num night;
  num eve;
  num morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  FeelsLike.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
    eve = json['eve'];
    morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}

class Weather {
  num id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}


// class WeatherOneDay



//
// class WeatherDailyForecast {
//   City city = City(0, "undefined");
//   String? cod;
//   int? cnt;
//   List<WeatherList> list = [];
//
//   WeatherDailyForecast(this.city, this.cod, this.cnt, this.list);
//
//   WeatherDailyForecast.fromJson(Map<String, dynamic> json) {
//     if (json['city']  != null){
//       this.city = City.fromJson(json['city']);
//     }
//     else {
//       this.city = City(0, "undefined");
//     }
//     this.cod = json['cod'];
//     this.cnt = json['cnt'];
//     if (json['list'] != null) {
//       this.list = [];
//       json['list'].forEach((v) {
//         this.list.add(WeatherList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.city != null) {
//       data['city'] = this.city.toJson();
//     }
//     data['cod'] = this.cod;
//     data['cnt'] = this.cnt;
//     if (this.list != null) {
//       data['list'] = this.list.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
//
// }
//
// class City {
//   int id = 0;
//   String name = "undefined";
//
//   City(this.id, this.name);
//
//   City.fromJson(Map<String, dynamic> json) {
//     this.id = json['id'];
//     this.name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
//
// }
//
// class Temp {
//   double? day;
//   double? min;
//   double? max;
//   double? night;
//   double? eve;
//   double? morn;
//
//   Temp(this.day, this.min, this.max, this.night, this.eve, this.morn);
//
//   Temp.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     min = json['min'];
//     max = json['max'];
//     night = json['night'];
//     eve = json['eve'];
//     morn = json['morn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['min'] = this.min;
//     data['max'] = this.max;
//     data['night'] = this.night;
//     data['eve'] = this.eve;
//     data['morn'] = this.morn;
//     return data;
//   }
// }
//
// class FeelsLike {
//   double? day;
//   double? night;
//   double? eve;
//   double? morn;
//
//   FeelsLike(this.day, this.night, this.eve, this.morn);
//
//   FeelsLike.fromJson(Map<String, dynamic> json) {
//     day = json['day'];
//     night = json['night'];
//     eve = json['eve'];
//     morn = json['morn'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['night'] = this.night;
//     data['eve'] = this.eve;
//     data['morn'] = this.morn;
//     return data;
//   }
// }
//
// class WeatherList {
//   int? dt;
//   int? sunrise;
//   int? sunset;
//   Temp temp = Temp(0, 0, 0, 0, 0, 0);
//   FeelsLike feelsLike = FeelsLike(0, 0, 0, 0);
//   int? pressure;
//   int? humidity;
//   List<Weather> weather = [];
//   double? speed;
//   int? deg;
//   int? clouds;
//   num? rain;
//
//   WeatherList(
//       this.dt,
//       this.sunrise,
//       this.sunset,
//       this.temp,
//       this.feelsLike,
//       this.pressure,
//       this.humidity,
//       this.weather,
//       this.speed,
//       this.deg,
//       this.clouds,
//       this.rain);
//
//   WeatherList.fromJson(Map<String, dynamic> json) {
//     dt = json['dt'];
//     sunrise = json['sunrise'];
//     sunset = json['sunset'];
//     temp = (json['temp'] != null ? new Temp.fromJson(json['temp']) : null)!;
//     feelsLike = json['feels_like'] != null ? new FeelsLike.fromJson(json['feels_like']) : new FeelsLike(0, 0, 0, 0);
//     pressure = json['pressure'];
//     humidity = json['humidity'];
//     if (json['weather'] != null) {
//       weather = [];
//       json['weather'].forEach((v) {
//         weather.add(new Weather.fromJson(v));
//       });
//     }
//     speed = json['speed'];
//     deg = json['deg'];
//     clouds = json['clouds'];
//     rain = json['rain'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['dt'] = this.dt;
//     data['sunrise'] = this.sunrise;
//     data['sunset'] = this.sunset;
//     if (this.temp != null) {
//       data['temp'] = this.temp.toJson();
//     }
//     if (this.feelsLike != null) {
//       data['feels_like'] = this.feelsLike.toJson();
//     }
//     data['pressure'] = this.pressure;
//     data['humidity'] = this.humidity;
//     if (this.weather != null) {
//       data['weather'] = this.weather.map((v) => v.toJson()).toList();
//     }
//     data['speed'] = this.speed;
//     data['deg'] = this.deg;
//     data['clouds'] = this.clouds;
//     data['rain'] = this.rain;
//     return data;
//   }
//
//   String getIconUrl() {
//     return Constants.WEATHER_IMAGES_URL + weather[0].icon + '.png';
//   }
// }
//
//
// class Weather {
//   late int id;
//   late String main;
//   late String description;
//   late String icon;
//
//   Weather(this.id, this.main, this.description, this.icon);
//
//   Weather.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     main = json['main'];
//     description = json['description'];
//     icon = json['icon'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['main'] = this.main;
//     data['description'] = this.description;
//     data['icon'] = this.icon;
//     return data;
//   }
// }