// import 'dart:convert';
// import 'package:flutter/material.dart';
// import "package:http/http.dart" as http;
//
// void main(List<String> args) {
//   runApp(new MaterialApp(
//     home: WeatherPage(),
//   ));
// }
//
// class WeatherPage extends StatefulWidget {
//   @override
//   _WeatherPageState createState() => _WeatherPageState();
// }
//
// class _WeatherPageState extends State<WeatherPage> {
//   String apiKey = 734454ae3dee8cbb3aade569fa83da3b ;
//   String cityName = 'Malaysia'; // Default city name
//
//   Future<Map<String, dynamic>> fetchWeatherData() async {
//     final response = await http.get(Uri.parse(
//         'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'));
//
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch weather data');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: fetchWeatherData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final weatherData = snapshot.data!;
//             final cityName = weatherData['name'];
//             final temperature = (weatherData['main']['temp'] - 273.15).toInt();
//             final weatherDescription =
//             weatherData['weather'][0]['description'];
//
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     cityName,
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     '$temperature°C',
//                     style: TextStyle(fontSize: 48),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     weatherDescription,
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Failed to fetch weather data'),
//             );
//           }
//
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
