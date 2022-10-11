import 'package:flutter/material.dart';
import 'package:mapbox_map_gl_example/screens/geojson_source_example_screen.dart';
import 'package:mapbox_map_gl_example/screens/image_source_example.dart';
import 'package:mapbox_map_gl_example/screens/raster_source_example.dart';
import 'package:mapbox_map_gl_example/screens/toggle_style_example_screen.dart';
import 'package:mapbox_map_gl_example/screens/vector_source_example.dart';

import 'animate_camera_example_screen.dart';
import 'geojson_source_example2_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _examples = <ExamplePage>[
    ExamplePage(
      title: "Toggle Map Style",
      subtitle: "Toggle between and among all the map styles",
      page: const ToggleStyleExampleScreen(),
    ),
    ExamplePage(
      title: "Animate Camera",
      subtitle: "See here how animate camera position works!",
      page: const AnimateCameraExampleScreen(),
    ),
    ExamplePage(
      title: "Geojson Clustering",
      subtitle: "Geojson clustering example",
      page: const GeoJsonSourceExampleScreen(),
    ),
    ExamplePage(
      title: "Symbol Layer",
      subtitle: "Circle & Symbol layer added using geo-son source!",
      page: const GeoJsonSourceExample2Screen(),
    ),
    ExamplePage(
      title: "Vector Source",
      subtitle: "Vector layer added using vector source!",
      page: const VectorSourceExampleScreen(),
    ),
    ExamplePage(
      title: "Raster Source",
      subtitle: "Raster layer added using raster source!",
      page: const RasterSourceExampleScreen(),
    ),
    ExamplePage(
      title: "Image Source",
      subtitle: "Raster layer added using image source!",
      page: const ImageSourceExampleScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapbox Map Gl"),
      ),
      body: ListView.builder(
        itemCount: _examples.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              _examples[index].title,
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              _examples[index].subtitle ?? "",
              style: theme.textTheme.caption,
            ),
            onTap: () => _examples[index].go(context),
          );
        },
      ),
    );
  }
}

/// Example Page
class ExamplePage {
  final String title;
  final String? subtitle;
  final Widget page;

  ExamplePage({
    required this.title,
    this.subtitle,
    required this.page,
  });

  /// Method to push to page
  Future<dynamic> go(BuildContext context) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }
}
