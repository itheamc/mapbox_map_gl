# Mapbox Map GL

[![Pub](https://img.shields.io/pub/v/mapbox_map_gl)](https://pub.dev/packages/mapbox_map_gl)
[![License](https://img.shields.io/github/license/itheamc/mapbox_map_gl)](https://github.com/itheamc/mapbox_map_gl/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/itheamc/mapbox_map_gl.svg?style=social)](https://github.com/itheamc/mapbox_map_gl)

## Introduction

This flutter plugin allow you to embed Mapbox Map to your flutter app. This plugin uses the latest
version of the Mapbox Map SDK so that you can experience all the latest feature introduced.
Currently this plugin only support android platform. It is based on Mapbox Map SDK
version```v10.10.0```

## Setting up

### Android

You have to include your mapbox map secret token and access token in order to use the mapbox map.

#### Mapbox Map Secret Token

Include your Mapbox Map Secret token to your ```gradle.properties```. You can get your Mapbox Map
secret token from your mapbox account page. It starts with ```sk.```

```
    MAPBOX_SECRET_TOKEN=<your-mapbox-map-secret-token>
```

Also include this line of code in your project level ```build.gradle``` file

```
allprojects {
    repositories {
        google()
        mavenCentral()
        
        // Add this line
        maven {
            url 'https://api.mapbox.com/downloads/v2/releases/maven'
            authentication {
                basic(BasicAuthentication)
            }
            credentials {
                username = "mapbox"
                password = project.properties['MAPBOX_SECRET_TOKEN']
            }
        }
    }
}
```

#### Mapbox Map Access Token

Include your Mapbox Map access token to ```string.xml``` file of the ```app/src/main/res/values/```
directory of android section It starts with ```pk.```

```
    <string name="mapbox_access_token">your-access-token</string>
```

### IOS

This plugin is not available in IOS yet.

### How to add MapboxMap?

You have to use ```MapboxMap()``` widget to add map in your page.

```
        MapboxMap(
          initialCameraPosition: CameraPosition(
            center: Point.fromLatLng(29.837785, 87.538961),
            zoom: 15.0,
            animationOptions: AnimationOptions.mapAnimationOptions(
              startDelay: 0,
              duration: const Duration(milliseconds: 750),
            ),
          ),
          style: MapStyle.light,
          showCurrentLocation: true,
          onMapCreated: (controller) {
            // controller - MapboxMapController instance
          },
          onStyleLoaded: () async {
            final isAlreadyAdded =
                await _controller?.isSourceExist("my-data-source") ?? false;
            if (!isAlreadyAdded) {
              _addGeoJson();
            }
          },
          onStyleLoadError: (err) {
            if (kDebugMode) {
              print(
                  "[onStyleLoadError] ---> $err");
            }
          },
          onMapClick(point, coordinates) {},
          onMapLongClick(point, coordinates) {},
          onFeatureClick: (details) {
             // details contain:
             // - point (lat and lng),
             // - coordinates (x and y screen coordinate)
             // - feature (Feature object)
             // - source
             // - sourceLayer
          },
          onFeatureLongClick: (details) {},
        ),
```

### How to add style source?

This api supports all the style sources that is supported by the latest Mapbox Map SDK. You can add
the style source like this.

```
    await _controller.addSource<GeoJsonSource>(
          source: GeoJsonSource(
            sourceId: "geojson-source-id",
            url: "https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_10m_land_ocean_label_points.geojson",
            sourceProperties: GeoJsonSourceProperties(
              cluster: true,
              clusterRadius: 50,
              clusterMaxZoom: 14,
              maxZoom: 20,
            ),
          ),
        )
```

### How to add style layer?

Like sources, this api also supports all the style layers that is supported by the latest Mapbox Map SDK. You can add the style layer like this.

```
    // Circle Layer
    await _controller.addLayer<CircleLayer>(
          layer: CircleLayer(
            layerId: "my-layer-id",
            sourceId: "geojson-source-id",
            layerProperties: CircleLayerProperties(
              circleColor: [
                'case',
                [
                  'boolean',
                  ['has', 'point_count'],
                  true
                ],
                'red',
                'blue'
              ],
              circleColorTransition: StyleTransition.build(
                delay: 500,
                duration: const Duration(milliseconds: 1000),
              ),
              circleRadius: [
                'case',
                [
                  'boolean',
                  ['has', 'point_count'],
                  true
                ],
                15,
                10
              ],
              circleStrokeWidth: [
                'case',
                [
                  'boolean',
                  ['has', 'point_count'],
                  true
                ],
                3,
                2
              ],
              circleStrokeColor: "#fff",
              circleTranslateTransition: StyleTransition.build(
                delay: 0,
                duration: const Duration(milliseconds: 1000),
              ),
            ),
          ),
        );
        
    // Symbol Layer
    await _controller.addLayer<SymbolLayer>(
      layer: SymbolLayer(
        layerId: "symbol-layer-example",
        sourceId: "geojson-source-id",
        layerProperties: SymbolLayerProperties(
          textField: ['get', 'point_count_abbreviated'],
          textSize: 12,
          textColor: '#fff',
          iconSize: 1,
          iconAllowOverlap: true,
        ),
      ),
    );
```

### How to add style image?

You can add style image from your assets or from the url. Svg image is not supported yet.

```
    // Add image stored on assets
    await _controller.addStyleImage<LocalStyleImage>(
          image: LocalStyleImage(
            imageId: "icon",
            imageName: "assets/images/your-image.png",
          ),
        );
    
    
    // Add image from url
    await _controller.addStyleImage<NetworkStyleImage>(
      image: NetworkStyleImage(
        imageId: "icon",
        url: "https://example.com/icon.png",
      ),
    );
```

### How to add annotations?

You can add circle, point/symbol, polyline and polygon annotations.

```
    // Add circle annotation
    final id = await _controller?.addAnnotation<CircleAnnotation>(
              annotation: CircleAnnotation(
                annotationOptions: CircleAnnotationOptions(
                  point: Point.fromLatLng(27.321, 82.323),
                  circleRadius: 20.0,
                  circleColor: "red",
                  circleStrokeWidth: 2.0,
                  circleStrokeColor: "#fff",
                  data: {"id": 124, "name": "testing circle"},
                  draggable: true,
                ),
              ),
            );
    
    
    // Add point annotation
    // You have three options for image source that you want to show
    // iconUrl: Url of the icon other than .svg format
    // iconPath: If you want to use image from assets then you can provide path here
    // iconImage: If you want to use image added through style image, then provide imageId here
    final id = await _controller?.addAnnotation<PointAnnotation>(
              annotation: PointAnnotation(
                iconUrl: "https://yourdomain.com/icons/name.png",
                            or
                iconPath: "assets/icons/name.png",
                            or
                iconImage: "image-Id-given-while-adding-style-image",
                annotationOptions: PointAnnotationOptions(
                  point: Point.fromLatLng(27.321, 82.323),
                  iconColor: "red",
                  iconSize: 1.2,
                  data: {"id": 124, "icon": "icon.png", "color": "#fff"},
                  draggable: true,
                ),
              ),
            );
    
    // Add Polyline Annotation
    final id = await _controller?.addAnnotation<PolylineAnnotation>(
              annotation: PolylineAnnotation(
                annotationOptions: PolylineAnnotationOptions(
                  points: [Point.fromLatLng(27.412, 82.331), Point.fromLatLng(27.432, 82.321)],
                  lineColor: "red",
                  lineGapWidth: 2,
                  lineSortKey: 0.3,
                  lineWidth: 2.0,
                  data: {"id": 124, "icon": "icon.png", "color": "#fff"},
                  draggable: true,
                ),
              ),
            );
```


### How to show users current location on Map (location puck)?

If you want to show the current location indicator (location puck) on map then you have to
set ```showCurrentLocation: true``` in ```MapboxMap()```.

By default, the Maps SDK uses the Android GPS and Network Providers to obtain raw location updates.
In applications using Android 11, the raw location updates might suffer from precision issues. In
order to get accurate location you can add this dependency to your app's ```build.gradle```.

For more info:
- [Mapbox Map Location Provider](https://docs.mapbox.com/android/maps/guides/user-location/#location-provider)

```
implementation "com.google.android.gms:play-services-location:18.0.0"
```

And these permissions to the AndroidManifest.xml
```
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### Supported Mapbox Api

| Feature                  | Android             | iOS | 
|--------------------------|---------------------| --- | 
| Style                    | :white_check_mark:  | :x: | 
| Camera                   | :white_check_mark:  | :x: | 
| Current Location         | :white_check_mark:  | :x: |
| Circle Layer             | :white_check_mark:  | :x: | 
| Line Layer               | :white_check_mark:  | :x: | 
| Fill Layer               | :white_check_mark:  | :x: | 
| Symbol Layer             | :white_check_mark:  | :x: | 
| Raster Layer             | :white_check_mark:  | :x: | 
| Hillshade Layer          | :white_check_mark:  | :x: | 
| Heatmap Layer            | :white_check_mark:  | :x: | 
| Fill Extrusion Layer     | :white_check_mark:  | :x: | 
| Sky Layer                | :white_check_mark:  | :x: | 
| Background Layer         | :white_check_mark:  | :x: | 
| Location Indicator Layer | :white_check_mark:  | :x: | 
| Vector Source            | :white_check_mark:  | :x: | 
| Raster Source            | :white_check_mark:  | :x: | 
| RasterDem Source         | :white_check_mark:  | :x: | 
| GeoJson Source           | :white_check_mark:  | :x: | 
| Image Source             | :white_check_mark:  | :x: | 
| Circle Annotation        | :white_check_mark:  | :x: | 
| Point Annotation         | :white_check_mark:  | :x: | 
| Polyline Annotation      | :white_check_mark:  | :x: | 
| Polygon Annotation       | :white_check_mark:  | :x: | 
| Expressions              | :white_check_mark:  | :x: |
| Transitions              | :white_check_mark:  | :x: |


