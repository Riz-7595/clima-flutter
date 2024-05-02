import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';

const apiKey = 'deb09726855713f01a72b83a93819e6d';
const url = "https://api.openweathermap.org/data/2.5/weather?units=metric&";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var locationWeather;

  void getLocationData() async {
    Location location = Location();
    await location.getCurrenLocation();
    print("Latitude: ${location.getLatitude()}");
    print("Longitude: ${location.getLongitude()}");

    NetworkHelper networkHelper = NetworkHelper(
        "${url}lat=${location.getLatitude()}&lon=${location.getLongitude()}&appid=$apiKey");

    locationWeather = await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather);
    }));
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
          SizedBox(height: 32),
          Center(
            child: SpinKitThreeBounce(
              color: Colors.white,
              size: 48,
            ),
          ),
          SizedBox(height: 10),
          Container(child: Text("make sure location is turned on\nand app has access to location")),
        ],
      ),
    );
  }
}
