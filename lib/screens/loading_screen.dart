import 'package:clima_flutter_made_manually/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter_made_manually/functions/location_functions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // When app is booted, initState() runs ... not under the Widget build()
  // because that would re-run everytime the widget is rebuilt

  @override
  void initState() {
    super.initState();
    getLocationData();
    // moveToLocationPage();
  }

  void getLocationData() async {
    Location userLocation = Location();
    var weatherData = await userLocation.getLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  SpinKitRing spinkit = const SpinKitRing(
    color: Colors.white,
    size: 100,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
