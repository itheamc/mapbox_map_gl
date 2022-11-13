## 0.0.1

* This is the first version that includes basic setup

## 0.0.2

* Added more functionality

## 0.0.3

* Added Support for GeoJson Source
* Added Support for Vector Source
* Circle Layer
* Line Layer
* Fill Layer

## 0.0.4

* Added support for Sources
    - GeoJson
    - Vector
    - Raster
    - RasterDem and
    - Image
* Added support for Layers
    - Circle Layer
    - Line Layer
    - Fill Layer
    - Symbol Layer
    - Raster Layer
    - Heatmap Layer
    - Hill Shade Layer
    - Fill Extrusion Layer
    - Sky Layer
    - Background Layer and
    - Location Indicator Layer
* Added support for Style Images
* Method to remove source
* Method to remove layers and many more.

## 0.0.5

* Added support for Changing Source & Style Properties
    - setStyleLayerProperty
    - setStyleLayerProperties
    - setStyleSourceProperty and
    - setStyleSourceProperties
* Added support for move Layers
    - moveStyleLayerAbove
    - moveStyleLayerBelow
    - moveStyleLayerAt
* Added support for Style Model
    - isStyleModelExist
    - addStyleModel
    - removeStyleModel
* And known bug fix

## 0.0.6

* Added Methods
    - setFeatureState
    - getFeatureState
    - removeFeatureState
    - querySourceFeatures and
    - queryRenderedFeatures
* Now your can enable the user current location puck
* Work on disposal of mapbox map and added listeners
* Upgraded to MapboxMap SDk version v10.9.0
* And known bug fix

## 0.0.7

* Improved Pub Score

## 0.0.8

* Added these methods:
    - getGeoJsonClusterChildren
    - getGeoJsonClusterLeaves
    - loadStyleJson
    - loadStyleUri
    - reduceMemoryUse
    - setMapMemoryBudget
    - triggerRepaint
    - coordinateForPixel
    - coordinatesForPixels
    - pixelForCoordinate
    - pixelsForCoordinates
    - getMapSize
    - setViewportMode
    - setCamera
* Upgraded Mapbox SDK version to 10.9.1
* Fix known bug from the previous version