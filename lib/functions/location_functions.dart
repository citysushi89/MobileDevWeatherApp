import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Location {
  late double latitude;
  late double longitude;

  Future getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    //  Test if the device has location services disabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('error 1');
      return Future.error(
          'Location services are disabled, good luck using a weather app genius');
    }

    // Check and ask for permission if by default denied
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print('error 2');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('error 3');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('error 4');
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    //  Assigning the variables based on outputs
    latitude = position.latitude;
    longitude = position.longitude;

    // Call to get the data based on the location (Different function)
    return getWeatherData();

    // print(latitude);
    // print(longitude);
  }

  Future getWeatherData() async {
    Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      "lat": latitude.toString(),
      "lon": longitude.toString(),
      "appid": "4d6a218b2c5bf94ac7a6aff7af4b1a17",
      "units": "imperial",
    });
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getCityWeather(String cityName) async {
    Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      "q": cityName,
      "appid": "4d6a218b2c5bf94ac7a6aff7af4b1a17",
      "units": "imperial",
    });
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
