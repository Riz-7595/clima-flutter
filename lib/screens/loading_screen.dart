import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocationData() async {
    WeatherModel weather = WeatherModel();
    var locationWeather = await weather.getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather);
        },
      ),
    );
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          const Center(
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 48,
            ),
          ),
          const SizedBox(height: 10),
          Container(child: const Text("make sure location is turned on\nand app has access to location")),
        ],
      ),
    );
  }
}
