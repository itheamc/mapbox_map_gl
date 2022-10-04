# Mapbox Map GL

## Introduction

This flutter plugin allow you to embed Mapbox Map to your flutter app. This plugin uses the latest
version of the Mapbox Map SDK so that you can experience all the latest feature introduced.
Currently this plugin only support android platform.

## Setting up

### Android
You have to include your mapbox map secret token and access token in order to use the mapbox map.

#### Mapbox Map Secret Token
Include your Mapbox Map Secret token to your ```gradle.properties```.
You can get your Mapbox Map secret token from your mapbox account page.
It starts with ```sk.```

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
Include your Mapbox Map access token to ```string.xml``` file of the ```app/src/main/res/values/``` directory of 
android section
It starts with ```pk.```

```
    <string name="mapbox_access_token">your-access-token</string>
```

### IOS
This plugin not available in IOS yet.

