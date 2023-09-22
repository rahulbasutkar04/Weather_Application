import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Additional_info.dart';
import 'package:weather_app/hourly_forecast_iteml.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Mumbai';
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApiKey'),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      //out from appbar
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10, //shadow of card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10), //makes backround of card blur
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp K',
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Icon(
                              currentSky == 'Clouds' || currentSky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              size: 65,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              currentSky,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //weather forecast cards
              const SizedBox(
                height: 20,
              ),

              const Text(
                'Hourly ForeCast',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for (int i = 0; i < 39; i++)
              //         HourlyForecasrWidget(
              //           time: data['list'][i + 1]['dt'].toString(),
              //           icon: data['list'][i + 1]['weather'][0]['main'] ==
              //                       'Clouds' ||
              //                   data['list'][i + 1]['weather'][0]['main'] ==
              //                       'Rain'
              //               ? Icons.cloud
              //               : Icons.sunny,
              //           temperature:
              //               data['list'][i + 1]['main']['temp'].toString(),
              //         ),
              //     ],
              //   ),
              // ),

              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final hourlyforecast = data['list'][index + 1];
                    final iconlst =
                        data['list'][index + 1]['weather'][0]['main'];
                    final hourlytemp =
                        hourlyforecast['main']['temp'].toString();
                    final time = DateTime.parse(hourlyforecast['dt_txt']);
                    return HourlyForecasrWidget(
                        time: DateFormat.j().format(time),
                        temperature: hourlytemp,
                        icon: iconlst == 'Clouds' || iconlst == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny);
                  },
                ),
              ),
              //additiona information

              const SizedBox(
                height: 20,
              ),
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInformationWidget(
                      icon: Icons.water_drop, label: 'Humidity', value: '90'),
                  AdditionalInformationWidget(
                      icon: Icons.air, label: 'windSpeed', value: '7.2'),
                  AdditionalInformationWidget(
                    icon: Icons.beach_access,
                    label: 'pressure',
                    value: '1000',
                  ),
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
