# Mapbox Map GL
[![Pub](https://img.shields.io/pub/v/mapbox_map_gl)](https://pub.dev/packages/mapbox_map_gl)
[![License](https://img.shields.io/github/license/itheamc/mapbox_map_gl)](https://github.com/itheamc/mapbox_map_gl/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/itheamc/mapbox_map_gl.svg?style=social)](https://github.com/itheamc/mapbox_map_gl)

## Introduction

This flutter plugin allow you to embed Mapbox Map to your flutter app. This plugin uses the latest
version of the Mapbox Map SDK so that you can experience all the latest feature introduced.
Currently this plugin only support android platform. It is based on Mapbox Android
SDK ```com.mapbox.maps:android:10.8.1```

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

This plugin not available in IOS yet.


### How to add style source?
 This api supports all the style sources that is supported by the Mapbox Map Android Sdk. 
 You can add the style source like this.
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
Like sources, this api also supports all the style layers that is supported by the Mapbox Map Android Sdk.
You can add the style layer like this.
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
        sdf: true,
      ),
    );
```

### Supported Mapbox Api

| Feature              | Android             | iOS | 
|----------------------|---------------------| --- | 
| Style                | :white_check_mark:  | :x: | 
| Camera               | :white_check_mark:  | :x: | 
| Circle Layer         | :white_check_mark:  | :x: | 
| Line Layer           | :white_check_mark:  | :x: | 
| Fill Layer           | :white_check_mark:  | :x: | 
| Symbol Layer         | :white_check_mark:  | :x: | 
| Raster Layer         | :white_check_mark:  | :x: | 
| Hillshade Layer      | :white_check_mark:  | :x: | 
| Heatmap Layer        | :white_check_mark:  | :x: | 
| Fill Extrusion Layer | :white_check_mark:  | :x: | 
| Sky Layer            | :white_check_mark:  | :x: | 
| Background Layer     | :white_check_mark:  | :x: | 
| Vector Source        | :white_check_mark:  | :x: | 
| Raster Source        | :white_check_mark:  | :x: | 
| RasterDem Source     | :white_check_mark:  | :x: | 
| GeoJson Source       | :white_check_mark:  | :x: | 
| Image Source         | :white_check_mark:  | :x: | 
| Expressions          | :white_check_mark:  | :x: |


