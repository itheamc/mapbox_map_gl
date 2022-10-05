import 'package:flutter/material.dart';
import 'package:mapbox_map_gl_example/screens/home_screen.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Mapbox Map Gl Example App",
      home: HomeScreen(),
    );
  }
}
