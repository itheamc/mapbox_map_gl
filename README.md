# Mapbox Map GL

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

## Supported Mapbox Api

|----------------------|---------------------| --- |
| Feature              | Android             | iOS | 
|----------------------|---------------------| --- | 
| Style                | :white_check_mark:  | :x:| 
| Camera               | :white_check_mark:  | :x: | 
| Circle Layer         | :white_check_mark:  | :x: | 
| Line Layer           | :white_check_mark:  | :x: | 
| Fill Layer           | :white_check_mark:  | :x: | 
| Symbol Layer         | : white_check_mark: | :x: | 
| Raster Layer         | :white_check_mark:  | :x: | 
| Hillshade Layer      | : white_check_mark: | :x: | 
| Heatmap Layer        | :white_check_mark:  | :x: | 
| Fill Extrusion Layer | :white_check_mark:  | :x: | 
| Sky Layer            | :white_check_mark:  | :x: | 
| Background Layer     | : white_check_mark: | :x: | 
| Vector Source        | :white_check_mark:  | :x: | 
| Raster Source        | : white_check_mark: | :x: | 
| RasterDem Source     | :white_check_mark:  | :x: | 
| GeoJson Source       | : white_check_mark: | :x: | 
| Image Source         | :white_check_mark:  | :x: | 
| Expressions          | : white_check_mark: | :x: |
|----------------------|---------------------| --- | 


