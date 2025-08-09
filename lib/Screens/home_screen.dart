import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:weather_app/widgets/weather_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherServices _weatherServices = WeatherServices();

  final TextEditingController _controller = TextEditingController();

  bool _isLoading = false;
  Weather? _weather;

  void _getWeather() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final weather = await _weatherServices.fetchWeather(_controller.text);
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        //   gradient:
        //       _weather != null &&
        //           _weather!.description.toLowerCase().contains('rain')
        //       ? const LinearGradient(
        //           colors: [Colors.blue, Colors.purple],
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //         )
        //       : _weather != null &&
        //             _weather!.description.toLowerCase().contains('clear')
        //       ? const LinearGradient(
        //           colors: [Colors.yellow, Colors.orange],
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //         )
        //       : const LinearGradient(
        //           colors: [Colors.blue, Colors.purple],
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //         ),\
          gradient: _weather != null && _weather!.description.toLowerCase().contains('rain')
              ? const LinearGradient(
            colors: [Colors.grey, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : _weather != null && _weather!.description.toLowerCase().contains('clear')
              ? const LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : const LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding:const  EdgeInsets.all(16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                const Text(
                  'Weatherly',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                // centerTitle : true,
                SizedBox(height: 25),
                TextField(

                  controller: _controller,
                  cursorColor: Colors.white,

                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(

                  onPressed: _getWeather,

                  child: Text('Get Weather', style: TextStyle(fontSize: 18),),
                  style : ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )),
                  if(_isLoading)
                    Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator( color: Colors.white,)),

                  if(_weather != null)
                    WeatherCard(weather: _weather!),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
