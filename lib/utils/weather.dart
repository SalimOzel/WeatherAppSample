// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_ap/utils/location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'location.dart';

const apiKey = "9b92d986b4c18b0e6f344df9d5a784b5";

class WeatherDisplayData {
  Icon? weatherIcon;
  AssetImage? weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double? currentTemprature;
  int? currentCondition;
  String? city;

  Future<void> getCurrentTemprature() async {
    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;

      Map<String, dynamic> currentWeather = jsonDecode(data);

      try {
        currentTemprature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
      } catch (e) {
        print('e');
      }
    } else {
      print('APİ den değer gelmiyor');
    }
  }

  // ignore: body_might_complete_normally_nullable
  WeatherDisplayData? getWeatherDisplayData() {
    if (currentCondition != null) {
      if (currentCondition! < 600) {
        return WeatherDisplayData(
          weatherIcon: const Icon(FontAwesomeIcons.cloud, size: 80, color: Colors.white),
          weatherImage: const AssetImage('assets/bulutlu.jpg'),
        );
      } else {
        //hava iyi
        //gece gündüz kontrolü
        var now = DateTime.now();
        if (now.hour >= 19) {
          // akşam
          return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.moon, size: 80, color: Colors.white),
            weatherImage: const AssetImage('assets/gece.jpg'),
          );
        } else {
          return WeatherDisplayData(
            weatherIcon: const Icon(FontAwesomeIcons.sun, size: 80, color: Colors.white),
            weatherImage: const AssetImage('assets/güneşli.jpg'),
          );
        }
      }
    } else {
      print('currentCondition boş');
    }
  }
}
