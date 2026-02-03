import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;

  void fetchWeather() async {
    try {
      final Position position = await _weatherService.getCurrentPosition();
      final weather = await _weatherService.getWeather(position);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Weather error: $e");
    }
  }

  String getLottieAsset(String? mainCondition) {
    if (mainCondition == null) {
      return "assets/sunny.json";
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "assets/cloud.json";
      case 'sunny':
        return "assets/sunny.json";
      case 'rain':
        return "assets/storm.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("W E A T H E R")),
      body: SafeArea(
        child: Center(
          child: _weather == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_weather!.cityName.toString()),
                    Lottie.asset(getLottieAsset(_weather!.mainCondition)),
                    Text(
                      "${_weather!.temperature.round()}°C",
                      style: TextStyle(fontSize: 48),
                    ),
                    Text(_weather!.mainCondition),
                  ],
                ),
        ),
      ),
    );
  }
}
