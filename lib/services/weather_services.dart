import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
import 'dart:convert';

class WeatherServices {
  final String apiKey = '2d472e996759f68f22d1163716bb830f';

  Future<Weather> fetchWeather(String cityName) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load weather data');
    }
  }
}
