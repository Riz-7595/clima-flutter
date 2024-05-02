import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'deb09726855713f01a72b83a93819e6d';
const url = "https://api.openweathermap.org/data/2.5/weather";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var locationData;

  void getLocationData() async {
    Location location = Location();
    await location.getCurrenLocation();
    print("Latitude: ${location.getLatitude()}");
    print("Longitude: ${location.getLongitude()}");

    NetworkHelper networkHelper =
        NetworkHelper("$url?lat=${location.getLatitude()}&lon=${location.getLongitude()}&appid=$apiKey");

    locationData = await networkHelper.getData();

    print(locationData['weather'][0]['description']);
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
