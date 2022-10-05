package com.itheamc.mapbox_map_gl.utils

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
    const val isSourceExist = "isSourceExist"
    const val isLayerExist = "isLayerExist"
    const val toggleMode = "toggleMode"
    const val animateCameraPosition = "animateCameraPosition"

    const val addGeoJsonSource = "addGeoJsonSource"
    const val addCircleLayer = "addCircleLayer"

}