import 'package:clima_flutter_made_manually/functions/location_functions.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter_made_manually/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
