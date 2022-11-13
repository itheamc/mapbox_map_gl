package com.itheamc.mapbox_map_gl.utils

/**
 * Methods.kt
 *
 * Created by Amit Chaudhary, 2022/10/3
 *
 * Objects containing methods to communicate with flutter
 */
object Methods {
    /**
     * These are the methods triggered from the native side
     */
    const val onMapLoaded = "onMapLoaded"
    const val onStyleLoaded = "onStyleLoaded"
    const val onMapLoadError = "onMapLoadError"

    const val onMapClick = "onMapClick"
    const val onMapLongClick = "onMapLongClick"

    const val onFeatureClick = "onFeatureClick"
    const val onFeatureLongClick = "onFeatureLongClick"

    const val onMapIdle = "onMapIdle"
    const val onCameraChange = "onCameraChange"
    const val onSourceAdded = "onSourceAdded"
    const val onSourceDataLoaded = "onSourceDataLoaded"
    const val onSourceRemoved = "onSourceRemoved"
    const val onRenderFrameStarted = "onRenderFrameStarted"
    const val onRenderFrameFinished = "onRenderFrameFinished"


    /**
     * These are the methods triggered from the flutter side
     */
    const val animateCameraPosition = "animateCameraPosition"
    const val toggleStyle = "toggleStyle"
    const val isSourceExist = "isSourceExist"
    const val isLayerExist = "isLayerExist"
    const val isStyleImageExist = "isStyleImageExist"
    const val isStyleModelExist = "isStyleModelExist"
    const val addGeoJsonSource = "addGeoJsonSource"
    const val addVectorSource = "addVectorSource"
    const val addRasterSource = "addRasterSource"
    const val addRasterDemSource = "addRasterDemSource"
    const val addImageSource = "addImageSource"
    const val addVideoSource = "addVideoSource"
    const val addCircleLayer = "addCircleLayer"
    const val addFillLayer = "addFillLayer"
    const val addLineLayer = "addLineLayer"
    const val addSymbolLayer = "addSymbolLayer"
    const val addRasterLayer = "addRasterLayer"
    const val addSkyLayer = "addSkyLayer"
    const val addStyleModel = "addStyleModel"

    const val addLocationIndicatorLayer = "addLocationIndicatorLayer"
    const val addFillExtrusionLayer = "addFillExtrusionLayer"
    const val addHeatmapLayer = "addHeatmapLayer"
    const val addHillShadeLayer = "addHillShadeLayer"
    const val addBackgroundLayer = "addBackgroundLayer"
    const val removeLayer = "removeLayer"
    const val removeLayers = "removeLayers"
    const val removeSource = "removeSource"
    const val addStyleImage = "addStyleImage"
    const val removeStyleImage = "removeStyleImage"
    const val removeStyleModel = "removeStyleModel"

    const val setStyleLayerProperty = "setStyleLayerProperty"
    const val setStyleLayerProperties = "setStyleLayerProperties"
    const val setStyleSourceProperty = "setStyleSourceProperty"
    const val setStyleSourceProperties = "setStyleSourceProperties"
    const val moveStyleLayerAbove = "moveStyleLayerAbove"
    const val moveStyleLayerBelow = "moveStyleLayerBelow"
    const val moveStyleLayerAt = "moveStyleLayerAt"

    const val getFeatureState = "getFeatureState"
    const val setFeatureState = "setFeatureState"
    const val removeFeatureState = "removeFeatureState"
    const val querySourceFeatures = "querySourceFeatures"
    const val queryRenderedFeatures = "queryRenderedFeatures"

    const val getGeoJsonClusterChildren = "getGeoJsonClusterChildren"
    const val getGeoJsonClusterLeaves = "getGeoJsonClusterLeaves"
    const val loadStyleJson = "loadStyleJson"
    const val reduceMemoryUse = "reduceMemoryUse"
    const val setMapMemoryBudget = "setMapMemoryBudget"
    const val triggerRepaint = "triggerRepaint"
    const val coordinateForPixel = "coordinateForPixel"
    const val coordinatesForPixels = "coordinatesForPixels"
    const val pixelForCoordinate = "pixelForCoordinate"
    const val pixelsForCoordinates = "pixelsForCoordinates"
    const val getMapSize = "getMapSize"
    const val setViewportMode = "setViewportMode"
    const val setCamera = "setCamera"
    const val loadStyleUri = "loadStyleUri"
}