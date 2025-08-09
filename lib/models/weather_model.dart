class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double windSpeed;
  final int sunrise;

  final int sunset;
  final int humidity;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'] - 273.15,
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      windSpeed: json['wind']['speed'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}
