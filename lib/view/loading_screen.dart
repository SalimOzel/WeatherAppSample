// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_ap/utils/location.dart';
import 'package:flutter_weather_ap/utils/weather.dart';
import 'package:flutter_weather_ap/view/main_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      print('Konum Bilgileri Gelmiyor');
    } else {
      print('latitude: ${locationData.latitude.toString()}');
      print('longitude: ${locationData.longitude.toString()}');
    }
  }

  void getWeatherData() async {
    await getLocationData();

    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemprature();

    if (weatherData.currentTemprature == null || weatherData.currentCondition == null) {
      print('APİ den sıcaklık veya durum bilgisi boş dönüyor.');
    }
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(weatherData: weatherData);
    }));
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.yellow, Colors.blue])),
        child: const Center(
          child: SpinKitWave(
            color: Colors.white,
            duration: Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
