import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Result extends StatefulWidget {
  final String place;

  const Result({super.key, required this.place});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  String city = "Loading...";
  double currentTemp = 0;
  double minTemp = 0;
  double maxTemp = 0;
  String weatherMain = "Loading...";
  String weatherMain2 = "Loading...";
  String dateStr = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      String? apiKey = dotenv.env['API_KEY'];
      if (apiKey == null) {
        throw Exception('API_KEY not found in .env');
      }
      String url =
          'https://api.openweathermap.org/data/2.5/weather?q=${widget.place}&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          city = data['name'] ?? 'Unknown';
          currentTemp = data['main']['temp'].toDouble();
          minTemp = data['main']['temp_min'].toDouble();
          maxTemp = data['main']['temp_max'].toDouble();
          weatherMain2 = data['weather'][0]['description'];
          weatherMain = data['weather'][0]['main'];
        });
      } else {
        setState(() {
          city = "Failed to load data";
        });
      }
    } catch (e) {
      setState(() {
        city = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    // Format tanggal dan waktu
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);

    String cuaca = "search.jpg";
    IconData iconData;

    switch (weatherMain.toLowerCase()) {
      case 'clouds':
        iconData = WeatherIcons.cloud;
        cuaca = "cloud.jpg";
        break;
      case 'clear':
        iconData = WeatherIcons.day_sunny;
        cuaca = "sun.jpg";
        break;
      case 'atmosphere':
        iconData = WeatherIcons.fog;
        cuaca = "fog.jpg";
        break;
      case 'snow':
        iconData = WeatherIcons.snow;
        cuaca = "snow.jpg";
        break;
      case 'rain':
        iconData = WeatherIcons.rain;
        cuaca = "rain.jpg";
        break;
      case 'drizzle':
        iconData = WeatherIcons.sprinkle;
        cuaca = "drizzle.jpg";
        break;
      case 'thunderstorm':
        iconData = WeatherIcons.thunderstorm;
        cuaca = "thunderstorm.jpg";
        break;
      default:
        iconData = WeatherIcons.na; // not available
        break;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hasil Cuaca",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/$cuaca', fit: BoxFit.cover),
            Container(color: Colors.black54),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Stack(
                        children: [
                          Text(
                            widget.place,
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black54, // warna border
                            ),
                          ),
                          Text(
                            widget.place,
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black45, // warna border
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black45, // warna border
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            "${currentTemp.round()}°C",
                            style: TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black45, // warna border
                            ),
                          ),
                          Text(
                            "${currentTemp.round()}°C",
                            style: TextStyle(
                              fontSize: 90,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            "---------------------------",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black45, // warna border
                            ),
                          ),
                          Text(
                            "---------------------------",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Text(
                            weatherMain2,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black45, // warna border
                            ),
                          ),
                          Text(
                            weatherMain2,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Icon(iconData, size: 48, color: Colors.white),
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          Text(
                            "${minTemp.round()}°C / ${maxTemp.round()}°C",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              foreground:
                                  Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 6
                                    ..color = Colors.black45, // warna border
                            ),
                          ),
                          Text(
                            "${minTemp.round()}°C / ${maxTemp.round()}°C",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        "This App Is Developed By AndreasXin",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
