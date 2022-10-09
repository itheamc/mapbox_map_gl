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
    const val onMapCreated = "onMapCreated"
    const val onStyleLoaded = "onStyleLoaded"
    const val onMapLoadError = "onMapLoadError"

    const val onMapClick = "onMapClick"
    const val onMapLongClick = "onMapLongClick"

    const val onFeatureClick = "onFeatureClick"
    const val onFeatureLongClick = "onFeatureLongClick"

    const val onMapIdle = "onMapIdle"
    const val onCameraMove = "onCameraMove"
    const val onSourceAdded = "onSourceAdded"
    const val onSourceDataLoaded = "onSourceDataLoaded"
    const val onSourceRemoved = "onSourceRemoved"


    /**
     * These are the methods triggered from the flutter side
     */
    const val animateCameraPosition = "animateCameraPosition"
    const val toggleStyle = "toggleStyle"
    const val isSourceExist = "isSourceExist"
    const val isLayerExist = "isLayerExist"
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
    const val addLocationIndicatorLayer = "addLocationIndicatorLayer"
    const val addFillExtrusionLayer = "addFillExtrusionLayer"
    const val addHeatmapLayer = "addHeatmapLayer"
    const val addHillShadeLayer = "addHillShadeLayer"
    const val addBackgroundLayer = "addBackgroundLayer"
    const val removeLayer = "removeLayer"
    const val removeLayers = "removeLayers"
    const val removeSource = "removeSource"
    const val removeSources = "removeSources"

}