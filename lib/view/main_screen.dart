import 'package:flutter/material.dart';
import 'package:flutter_weather_ap/utils/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.weatherData}) : super(key: key);

  final WeatherData weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? temperature;
  Icon? weatherDisplayIcon;
  AssetImage? backgroundImage;
  String? city;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemprature?.round();
      city = weatherData.city;
      WeatherDisplayData? weatherDisplayData = weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData?.weatherImage;
      weatherDisplayIcon = weatherDisplayData?.weatherIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(image: backgroundImage!, fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Container(
              child: weatherDisplayIcon,
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                '$temperature°',
                style: const TextStyle(color: Colors.white, fontSize: 70, letterSpacing: -5),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                '$city',
                style: const TextStyle(color: Colors.white, fontSize: 50, letterSpacing: -5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
