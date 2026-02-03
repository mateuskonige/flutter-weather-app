import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather.dart';

class WeatherService {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      queryParameters: {
        'appid': dotenv.env['OPENWEATHER_API_KEY'],
        'units': 'metric',
      },
    ),
  );

  WeatherService() {
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Future<Weather> getWeather(Position position) async {
    try {
      final response = await _dio.get(
        '/weather',
        queryParameters: {'lat': position.latitude, 'lon': position.longitude},
      );

      return Weather.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Erro ao buscar dados do clima',
      );
    }
  }

  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
