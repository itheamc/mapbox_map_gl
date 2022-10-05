package com.itheamc.mapbox_map_gl

import android.graphics.Bitmap
import android.os.Build
import android.util.Log
import com.itheamc.mapbox_map_gl.utils.CameraPosition
import com.itheamc.mapbox_map_gl.utils.LayerUtils
import com.itheamc.mapbox_map_gl.utils.Methods
import com.mapbox.bindgen.Expected
import com.mapbox.bindgen.ExpectedFactory
import com.mapbox.bindgen.None
import com.mapbox.maps.*
import com.mapbox.maps.extension.observable.eventdata.MapLoadingErrorEventData
import com.mapbox.maps.extension.style.layers.addLayer
import com.mapbox.maps.extension.style.layers.generated.*
import com.mapbox.maps.extension.style.sources.addSource
import com.mapbox.maps.extension.style.sources.generated.GeoJsonSource
import com.mapbox.maps.extension.style.sources.generated.VectorSource
import com.mapbox.maps.extension.style.sources.generated.geoJsonSource
import com.mapbox.maps.extension.style.sources.generated.vectorSource
import com.mapbox.maps.plugin.animation.flyTo
import com.mapbox.maps.plugin.delegates.listeners.OnMapLoadErrorListener
import com.mapbox.maps.plugin.gestures.addOnMapClickListener
import com.mapbox.maps.plugin.gestures.addOnMapLongClickListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

private const val TAG = "MapboxMapGlController"

class MapboxMapGlController(
    private val messenger: BinaryMessenger,
    private val mapboxMap: MapboxMap,
    private val creationParams: Map<*, *>?,
) : MethodChannel.MethodCallHandler {

    /**
     * Method channel to handle native method call
     */
    var methodChannel: MethodChannel =
        MethodChannel(messenger, MapboxMapGlPlugin.METHOD_CHANNEL_NAME)


    /**
     * Init Block
     */
    init {
        methodChannel.setMethodCallHandler(this)
        addMapRelatedListeners()
        loadStyleUri()
    }

    /**
     * List of layers added by the user to the style
     */
    private val _interactiveLayers = mutableListOf<StyleObjectInfo>()
    private val interactiveLayers: List<StyleObjectInfo> = _interactiveLayers

    /**
     * List of layer sources added by the user
     * that might need interaction
     */
    private val _interactiveLayerSources = mutableListOf<StyleObjectInfo>()

    /**
     * Getter for style
     */
    private val style: Style?
        get() = if (mapboxMap.isValid()) mapboxMap.getStyle() else null


    /**
     * Method to load the style uri
     */
    private fun loadStyleUri() {
        if (!mapboxMap.isValid()) return

        mapboxMap.loadStyleUri(
            Style.LIGHT,
            styleTransitionOptions = TransitionOptions
                .Builder()
                .duration(500L)
                .delay(0)
                .enablePlacementTransitions(false)
                .build(),
            onStyleLoaded = {
                animateToInitialCameraPosition()
            }
        )
    }

    /**
     * Method to
     */
    private fun animateToInitialCameraPosition() {

        if (!mapboxMap.isValid()) return;

        val hasInitialCameraPosition =
            creationParams?.containsKey("initialCameraPosition") ?: false
        val initialCameraPosition = creationParams?.get("initialCameraPosition")

        if (!hasInitialCameraPosition || initialCameraPosition == null) return

        val cameraPosition: CameraPosition = CameraPosition
            .fromMap(initialCameraPosition as Map<*, *>)

        mapboxMap.flyTo(
            cameraOptions = CameraOptions
                .Builder()
                .center(cameraPosition.center)
                .zoom(cameraPosition.zoom)
                .bearing(cameraPosition.bearing)
                .pitch(cameraPosition.pitch)
                .anchor(cameraPosition.anchor)
                .build(),
            animationOptions = cameraPosition.animationOptions
        )
    }

    /**
     * Method to switch the map style
     */
    private fun toggleSatelliteMode(dark: Boolean = false) {
        if (!mapboxMap.isValid()) return

        mapboxMap.getStyle()?.let {
            mapboxMap.loadStyleUri(
                if (it.styleURI == Style.SATELLITE) if (dark) Style.DARK else Style.LIGHT else Style.SATELLITE,
            )
        }
    }

    /**
     * Method to animate camera
     */
    private fun animateCameraPosition(cameraPosition: CameraPosition) {
        if (!mapboxMap.isValid()) return

        mapboxMap.flyTo(
            cameraOptions = CameraOptions.Builder()
                .center(cameraPosition.center)
                .zoom(cameraPosition.zoom)
                .bearing(cameraPosition.bearing)
                .pitch(cameraPosition.pitch)
                .anchor(cameraPosition.anchor)
                .build(),
            animationOptions = cameraPosition.animationOptions
        )
    }


    /**
     * Method to add geo json sources
     * Remember: If your want to add line layer or fill layer along with the circle layer
     * then you clustering feature will not working. Turning [cluster = true] will throw an error
     */
    private fun addGeoJsonSource(
        sourceId: String,
        layerId: String,
        lineLayer: (LineLayerDsl.() -> Unit)? = null,
        circleLayer: (CircleLayerDsl.() -> Unit)? = null,
        fillLayer: (FillLayerDsl.() -> Unit)? = null,
        symbolLayer: (SymbolLayerDsl.() -> Unit)? = null,
        block: GeoJsonSource.Builder.() -> Unit = {}
    ) {
        style?.let {

            removeLayers(
                LayerType.values()
                    .map { layerType -> suffixedLayerId(layerId = layerId, layerType = layerType) }
            )
                .onValue {
                    removeStyleSourceIfAny(sourceId)
                        .onValue {
                            _interactiveLayerSources.add(StyleObjectInfo(sourceId, "GeoJsonSource"))
                            style!!.addSource(
                                geoJsonSource(sourceId, block)
                            )
                            fillLayer?.let {
                                addFillLayer(layerId, sourceId, it)
                            }
                            lineLayer?.let {
                                addLineLayer(layerId, sourceId, it)
                            }
                            circleLayer?.let {
                                addCircleLayer(layerId, sourceId, it)
                            }
                            symbolLayer?.let {
                                addSymbolLayer(layerId, sourceId, it)
                            }
                        }
                }
        }
    }

    /**
     * Method to add vector sources
     */
    private fun addVectorSource(
        sourceId: String,
        layerId: String,
        lineLayer: (LineLayerDsl.() -> Unit)? = null,
        fillLayer: (FillLayerDsl.() -> Unit)? = null,
        block: VectorSource.Builder.() -> Unit
    ) {
        style?.let {

            removeLayers(
                LayerType.values()
                    .map { layerType -> suffixedLayerId(layerId = layerId, layerType = layerType) }
            )
                .onValue {
                    removeStyleSourceIfAny(sourceId = sourceId)
                        .onValue {
                            _interactiveLayerSources.add(StyleObjectInfo(sourceId, "VectorSource"))
                            style!!.addSource(
                                vectorSource(sourceId, block)
                            )

                            fillLayer?.let {
                                addFillLayer(layerId, sourceId, it)
                            }
                            lineLayer?.let {
                                addLineLayer(layerId, sourceId, it)
                            }
                        }
                }
        }
    }


    /**
     * Method to add image
     */
    private fun addStyleImage(
        imageId: String,
        bitmap: Bitmap,
        sdf: Boolean = false
    ) {
        style?.let {
            removeStyleSourceIfAny(sourceId = imageId, isImageSource = true)
                .onValue {
                    _interactiveLayerSources.add(StyleObjectInfo(imageId, "ImageSource"))
                    style!!.addImage(imageId, bitmap, sdf)
                }
        }

    }

    /**
     * Method to add line layer
     */
    private fun addLineLayer(layerId: String, sourceId: String, block: LineLayerDsl.() -> Unit) {
        style?.let {
            val formattedLayerId = suffixedLayerId(layerId = layerId, layerType = LayerType.LINE)

            removeLayerIfAny(formattedLayerId)
                .onValue {
                    _interactiveLayers.add(StyleObjectInfo(formattedLayerId, "LineLayer"))
                    style!!.addLayer(
                        lineLayer(formattedLayerId, sourceId, block)
                    )
                }
        }
    }

    /**
     * Method to add circle layer
     */
    private fun addCircleLayer(
        layerId: String,
        sourceId: String,
        block: CircleLayerDsl.() -> Unit
    ) {
        style?.let {
            val formattedLayerId = suffixedLayerId(layerId = layerId, layerType = LayerType.CIRCLE)

            removeLayerIfAny(formattedLayerId)
                .onValue {
                    _interactiveLayers.add(StyleObjectInfo(formattedLayerId, "CircleLayer"))
                    style!!.addLayer(
                        circleLayer(formattedLayerId, sourceId, block)
                    )
                }
        }
    }

    /**
     * Method to add fill layer
     */
    private fun addFillLayer(layerId: String, sourceId: String, block: FillLayerDsl.() -> Unit) {
        style?.let {
            val formattedLayerId = suffixedLayerId(layerId = layerId, layerType = LayerType.FILL)

            removeLayerIfAny(formattedLayerId)
                .onValue {
                    _interactiveLayers.add(StyleObjectInfo(formattedLayerId, "FillLayer"))
                    style!!.addLayer(
                        fillLayer(formattedLayerId, sourceId, block)
                    )
                }
        }
    }

    /**
     * Method to add symbol layer
     */
    private fun addSymbolLayer(
        layerId: String,
        sourceId: String,
        block: SymbolLayerDsl.() -> Unit
    ) {
        style?.let {
            val formattedLayerId = suffixedLayerId(layerId = layerId, layerType = LayerType.SYMBOL)

            removeLayerIfAny(formattedLayerId)
                .onValue {
                    _interactiveLayers.add(StyleObjectInfo(formattedLayerId, "SymbolLayer"))
                    style!!.addLayer(
                        symbolLayer(formattedLayerId, sourceId, block)
                    )
                }
        }
    }

    /**
     * Method to add map related listeners
     * --------------------------------------------------------------------------------------
     */
    private fun addMapRelatedListeners() {
        if (!mapboxMap.isValid()) return

        /**
         * On Map Loaded Listener
         */
        mapboxMap.addOnMapLoadedListener {
            methodChannel.invokeMethod(Methods.onMapCreated, null)
        }

        /**
         * On Map Load Error Listener
         */
        mapboxMap.addOnMapLoadErrorListener(object : OnMapLoadErrorListener {
            override fun onMapLoadError(eventData: MapLoadingErrorEventData) {
                methodChannel.invokeMethod(Methods.onMapLoadError, eventData.message)
            }
        })

        /**
         * On Style Loaded Listener
         */
        mapboxMap.addOnStyleLoadedListener {
            _interactiveLayerSources.clear()
            _interactiveLayers.clear()
            methodChannel.invokeMethod(Methods.onStyleLoaded, null)
        }

        /**
         * On Map Idle Listener
         */
        mapboxMap.addOnMapIdleListener {
            methodChannel.invokeMethod(Methods.onMapIdle, null)
        }

        /**
         * On Camera Change Listener
         */
        mapboxMap.addOnCameraChangeListener {
            methodChannel.invokeMethod(Methods.onCameraMove, null)
        }

        /**
         * On Source Added Listener
         */
        mapboxMap.addOnSourceAddedListener {
            methodChannel.invokeMethod(Methods.onSourceAdded, it.id)
        }

        /**
         * On Source Data Loaded Listener
         */
        mapboxMap.addOnSourceDataLoadedListener {
            val args = mapOf(
                "id" to it.id,
                "type" to it.type.value,
                "loaded" to it.loaded
            )
            methodChannel.invokeMethod(Methods.onSourceDataLoaded, args)
        }

        /**
         * On Source Removed Listener
         */
        mapboxMap.addOnSourceRemovedListener {
            methodChannel.invokeMethod(Methods.onSourceRemoved, it.id)
        }


        /**
         * On Map Click Listener
         */
        mapboxMap.addOnMapClickListener {

            val screenCoordinate: ScreenCoordinate = mapboxMap.pixelForCoordinate(it)

            mapboxMap.queryRenderedFeatures(
                geometry = RenderedQueryGeometry(screenCoordinate),
                options = RenderedQueryOptions(interactiveLayers.map { l -> l.id }, null),
                callback = { expectedValue ->
                    expectedValue.onValue { features ->

                        val latLng =
                            mapOf("latitude" to it.latitude(), "longitude" to it.longitude())
                        val scrCords = mapOf("x" to screenCoordinate.x, "y" to screenCoordinate.y)

                        if (features.isNotEmpty()) {

                            val source = features[0].source
                            val feature = features[0].feature

                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "latLng" to latLng,
                                    "screen_coordinate" to scrCords,
                                    "feature" to feature.toJson(),
                                    "source" to source
                                )

                            methodChannel.invokeMethod(Methods.onFeatureClick, arguments)
                        } else {
                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "latLng" to latLng,
                                    "screen_coordinate" to scrCords,
                                )
                            methodChannel.invokeMethod(Methods.onMapClick, arguments)
                        }
                    }

                    expectedValue.onError {
                        Log.d(TAG, "addOnClickListener: Error")
                    }
                }
            )
            true
        }

        /**
         * On Map Long Click listener
         */
        mapboxMap.addOnMapLongClickListener {

            val screenCoordinate: ScreenCoordinate = mapboxMap.pixelForCoordinate(it)

            mapboxMap.queryRenderedFeatures(
                geometry = RenderedQueryGeometry(mapboxMap.pixelForCoordinate(it)),
                options = RenderedQueryOptions(interactiveLayers.map { l -> l.id }, null),
                callback = { expectedValue ->
                    expectedValue.onValue { features ->

                        val latLng =
                            mapOf("latitude" to it.latitude(), "longitude" to it.longitude())
                        val scrCords = mapOf("x" to screenCoordinate.x, "y" to screenCoordinate.y)

                        if (features.isNotEmpty()) {
                            val source = features[0].source
                            val feature = features[0].feature

                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "latLng" to latLng,
                                    "screen_coordinate" to scrCords,
                                    "feature" to feature.toJson(),
                                    "source" to source
                                )

                            methodChannel.invokeMethod(Methods.onFeatureLongClick, arguments)
                        } else {
                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "latLng" to latLng,
                                    "screen_coordinate" to scrCords,
                                )
                            methodChannel.invokeMethod(Methods.onMapLongClick, arguments)
                        }
                    }

                    expectedValue.onError {
                        Log.d(TAG, "addOnLongClickListener: Error")
                    }
                }
            )
            true
        }
    }

    /**
     * Method to remove layer if already added
     */
    private fun removeLayerIfAny(formattedLayerId: String): Expected<String, None> {
        return if (_interactiveLayers.any { it.id == formattedLayerId }) {
            if (Build.VERSION.SDK_INT >= 24) {
                _interactiveLayers.removeIf { it.id == formattedLayerId }
            } else {
                _interactiveLayers.clear()
                _interactiveLayers.addAll(_interactiveLayers.filter { it.id != formattedLayerId })
            }
            style!!.removeStyleLayer(formattedLayerId)
        } else {
            ExpectedFactory.createValue(None.getInstance())
        }
    }

    /**
     * Method to remove style image if already added with given id
     */
    /**
     * Method to remove layer if already added
     */
    private fun removeStyleSourceIfAny(
        sourceId: String,
        isImageSource: Boolean = false
    ): Expected<String, None> {
        return if (_interactiveLayerSources.any { it.id == sourceId }) {

            if (Build.VERSION.SDK_INT >= 24) {
                _interactiveLayerSources.removeIf { it.id == sourceId }
            } else {
                _interactiveLayerSources.clear()
                _interactiveLayerSources.addAll(_interactiveLayerSources.filter { it.id == sourceId })
            }

            if (isImageSource) {
                style!!.removeStyleImage(sourceId)
            } else {
                style!!.removeStyleSource(sourceId)
            }
        } else {
            ExpectedFactory.createValue(None.getInstance())
        }
    }

    /**
     * Method to remove layers
     */
    private fun removeLayers(layersId: List<String>): Expected<String, None> {
        layersId.forEach { id ->
            style.let {
                val expectedResult = style!!.removeStyleLayer(id)
                expectedResult.onValue {
                    if (Build.VERSION.SDK_INT >= 24) {
                        _interactiveLayers.removeIf { it.id == id }
                    } else {
                        _interactiveLayers.clear()
                        _interactiveLayers.addAll(_interactiveLayers.filter { it.id != id })
                    }
                }
            }
        }.also {
            return ExpectedFactory.createValue(None.getInstance())
        }
    }

    /**
     * Method to get suffix for layer id
     */
    private fun suffixedLayerId(layerId: String, layerType: LayerType = LayerType.CIRCLE): String {
        return "${layerId}_${layerType.name.lowercase()}_layer"
    }


    /**
     * Method to handle method call
     * --------------------------------------------------------------------------------------
     */
    override fun onMethodCall(
        call: MethodCall,
        result: MethodChannel.Result
    ) {

        var args = call.arguments

        when (call.method) {
            Methods.isSourceExist -> {
                val objectInfo = _interactiveLayerSources.firstOrNull {
                    it.id == args as String
                }
                return result.success(objectInfo != null)
            }
            Methods.isLayerExist -> {
                args = args as Map<*, *>
                val layerId = args["layerId"]
                val layerType = args["layerType"]
                val objectInfo = interactiveLayers.firstOrNull {
                    it.id == suffixedLayerId(
                        layerId as String,
                        layerTypeFromString(
                            layerType as String
                        )
                    )
                }
                return result.success(objectInfo != null)
            }
            Methods.toggleMode -> {
                toggleSatelliteMode(dark = if (args != null && args is Boolean) args else false)
                return result.success(true)
            }
            Methods.animateCameraPosition -> {
                val cameraPosition: CameraPosition = CameraPosition
                    .fromMap(args as Map<*, *>)
                animateCameraPosition(cameraPosition)
                return result.success(true)
            }
            Methods.addGeoJsonSource -> {
                args = args as Map<*, *>

                val sourceId = args["sourceId"]
                val layerId = args["layerId"]
                val lineLayer = args["lineLayer"]
                val circleLayer = args["circleLayer"]
                val fillLayer = args["fillLayer"]
                val symbolLayer = args["symbolLayer"]

                addGeoJsonSource(
                    sourceId = sourceId as String,
                    layerId = layerId as String,
                    circleLayer = if (circleLayer != null) LayerUtils.processCircleLayerArguments(
                        (circleLayer as Map<*, *>)["options"] as Map<*, *>
                    ) else null
                ) {
                    data(
                        """
                        {
                          "type": "FeatureCollection",
                          "features": [
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 2,
                                "name": "Niagara Falls",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 43.087653,
                                "long_x": -79.044073,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "waterfall"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -79.04411780507252,
                                  43.08771393436908
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 2,
                                "name": "Salto Angel",
                                "comment": null,
                                "name_alt": "Angel Falls",
                                "lat_y": 5.686836,
                                "long_x": -62.061848,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "waterfall"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -62.06181800038502,
                                  5.686896063275327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 2,
                                "name": "Iguazu Falls",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -25.568265,
                                "long_x": -54.582842,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "waterfall"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -54.58299719960377,
                                  -25.568291925005923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Gees Gwardafuy",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 11.812855,
                                "long_x": 51.235173,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  51.258313644180184,
                                  11.822028799226407
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Victoria Falls",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -17.77079,
                                "long_x": 25.460133,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "waterfall"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  25.852793816021233,
                                  -17.928033135943423
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Wright I.",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -50.959168,
                                "long_x": -72.995002,
                                "region": "Antarctica",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -116.89262854726002,
                                  -74.06670501094342
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Grant I.",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -50.959168,
                                "long_x": -72.995002,
                                "region": "Antarctica",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -131.48540198476002,
                                  -74.48272063594342
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Newman I.",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -50.959168,
                                "long_x": -72.995002,
                                "region": "Antarctica",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -145.68681800038502,
                                  -75.59185149531842
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Dean I.",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -50.959168,
                                "long_x": -72.995002,
                                "region": "Antarctica",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -127.63438880116627,
                                  -74.50066497188092
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape Canaveral",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 28.483713,
                                "long_x": -80.534941,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -80.53625603636821,
                                  28.473056814472134
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape Mendocino",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 40.350222,
                                "long_x": -124.323474,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -124.39201745043425,
                                  40.44222065537283
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cabo San Lucas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 22.887711,
                                "long_x": -109.969843,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -109.96983801991627,
                                  22.887762762494077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape Churchill",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 58.752014,
                                "long_x": -93.182023,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -93.18211829335377,
                                  58.75208161015033
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape Cod",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 41.734867,
                                "long_x": -69.964865,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -70.03687833567446,
                                  41.9914589934385
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape May",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 37.2017,
                                "long_x": -75.926791,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -74.95121933164988,
                                  38.92969645987068
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cabo de Hornos",
                                "comment": null,
                                "name_alt": "Cape Horn",
                                "lat_y": -55.862824,
                                "long_x": -67.169425,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -67.16942298085377,
                                  -55.86284758906842
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape of Good Hope",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.307311,
                                "long_x": 18.441206,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  18.441294792583733,
                                  -34.30718352656842
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape Palmas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 4.373924,
                                "long_x": -7.457356,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -7.457386848041267,
                                  4.373968817181577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cape Verde",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 14.732312,
                                "long_x": -17.471776,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -17.471730109760017,
                                  14.732489324994077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Cap Bon",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 37.073954,
                                "long_x": 11.024061,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  11.024180534771233,
                                  37.07398102421283
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "Oceanic pole of inaccessibility",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -48.865032,
                                "long_x": -123.401986,
                                "region": "Seven seas (open ocean)",
                                "subregion": "South Pacific Ocean",
                                "featureclass": "pole"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -123.40202796132252,
                                  -48.86504485469342
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "South Magnetic Pole 2005 (est)",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -48.865032,
                                "long_x": -123.401986,
                                "region": "Antarctica",
                                "subregion": "Southern Ocean",
                                "featureclass": "pole"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  137.85425865977123,
                                  -64.51824309688092
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 3,
                                "name": "North Magnetic Pole 2005 (est)",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -48.865032,
                                "long_x": -123.401986,
                                "region": "Seven seas (open ocean)",
                                "subregion": "Arctic Ocean",
                                "featureclass": "pole"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -114.40569007069752,
                                  82.71008942265033
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Lands End",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 50.069677,
                                "long_x": -5.668629,
                                "region": "Europe",
                                "subregion": "British Isles",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -5.668629523822517,
                                  50.06970856327533
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape York",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 76.218919,
                                "long_x": -68.218612,
                                "region": "North America",
                                "subregion": "Greenland",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -68.21861731679127,
                                  76.21887848515033
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Nunap Isua",
                                "comment": null,
                                "name_alt": "Cape Farewell",
                                "lat_y": 59.862583,
                                "long_x": -43.90088,
                                "region": "North America",
                                "subregion": "Greenland",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -43.90080725819752,
                                  59.86267731327533
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape Vohimena",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -25.546355,
                                "long_x": 45.158683,
                                "region": "Africa",
                                "subregion": "Indian Ocean",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  45.15870201914623,
                                  -25.546319268755923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Vavau",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -18.590062,
                                "long_x": -173.976769,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -173.97673499257252,
                                  -18.590020440630923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "I. de Pascua",
                                "comment": null,
                                "name_alt": "Easter I.",
                                "lat_y": -27.102117,
                                "long_x": -109.367953,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -109.36790930897877,
                                  -27.102227471880923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape Agulhas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.801182,
                                "long_x": 19.993472,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  19.993418816021233,
                                  -34.80108001094342
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Plain of Jars",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 20.550709,
                                "long_x": 101.890532,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "plain"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  101.89063561289623,
                                  20.550909735150327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cabo Corrientes",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 20.409471,
                                "long_x": -105.683581,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -105.67795873874799,
                                  20.420365114940253
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Pt. Eugenia",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 27.861925,
                                "long_x": -115.07629,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -115.04623945046137,
                                  27.842887092585283
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Point Conception",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 34.582313,
                                "long_x": -120.659016,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -120.46360036202867,
                                  34.46027592467621
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape Hatteras",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 35.437762,
                                "long_x": -75.450543,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -75.54032952413311,
                                  35.24475263812895
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape Sable",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 25.124896,
                                "long_x": -81.090442,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -81.09044348866627,
                                  25.124762274212827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape Hope",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 68.35638,
                                "long_x": -166.815582,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -166.81321268769543,
                                  68.35380207543972
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Point Barrow",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 71.372637,
                                "long_x": -156.615894,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -156.4719492091668,
                                  71.40589128763096
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Punta Negra",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -5.948875,
                                "long_x": -81.108252,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -81.10832678944752,
                                  -5.948663018755923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Punta Lavapié",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -37.262867,
                                "long_x": -73.606377,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -73.60304396243782,
                                  -37.17120002933805
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Punta Galera",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 0.731221,
                                "long_x": -80.062205,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -80.06212317616627,
                                  0.731207586712827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cap Lopez",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -0.604761,
                                "long_x": 8.726423,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  8.727299789450319,
                                  -0.615086490513119
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cape Bobaomby",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -11.966598,
                                "long_x": 49.262904,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  49.26282799570873,
                                  -11.966485284380923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 4,
                                "name": "Cap Blanc",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 20.822108,
                                "long_x": -17.052856,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -17.052906867572517,
                                  20.822088934369077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "South West Cape",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -43.510984,
                                "long_x": 146.054227,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  146.03379804609568,
                                  -43.5404025683706
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Howe",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -37.488775,
                                "long_x": 149.95853,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  149.95838463633373,
                                  -37.48894622188092
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Otway",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -38.857622,
                                "long_x": 143.565403,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  143.537005108191,
                                  -38.85472383068997
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Jaffa",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -36.944244,
                                "long_x": 139.690866,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  139.68061977964746,
                                  -36.95624316107086
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Carnot",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.920233,
                                "long_x": 135.656027,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  135.65378326897053,
                                  -34.93870859313661
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Byron",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -28.658282,
                                "long_x": 153.632849,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  153.62799176015545,
                                  -28.66197417050363
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Manifold",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -22.702081,
                                "long_x": 150.811228,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  150.81116783945873,
                                  -22.702080987505923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape York",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -10.710859,
                                "long_x": 142.522018,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  142.52173912852123,
                                  -10.710747979693423
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Melville",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -14.163629,
                                "long_x": 144.506417,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  144.50660240977123,
                                  -14.163506768755923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Arnhem",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -12.337984,
                                "long_x": 136.952429,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  136.91481885262823,
                                  -12.295662864626316
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "West Cape Howe",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -35.104301,
                                "long_x": 117.597011,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  117.59693444102123,
                                  -35.10430266719342
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Leeuwin",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.297841,
                                "long_x": 115.10633,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  115.1280088910596,
                                  -34.328007092559645
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Pasley",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -33.929054,
                                "long_x": 123.517283,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  123.51722252695873,
                                  -33.92888762813092
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Londonderry",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -13.713856,
                                "long_x": 126.964514,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  126.94130045687105,
                                  -13.74290642667802
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Steep Point",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -26.16822,
                                "long_x": 113.169959,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  113.14519563289093,
                                  -26.157463616878637
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "North West Cape",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -21.809776,
                                "long_x": 114.117534,
                                "region": "Oceania",
                                "subregion": "Australia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  114.16010761213809,
                                  -21.801474697071743
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Gracias a Dios",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 14.994242,
                                "long_x": -83.15866,
                                "region": "North America",
                                "subregion": "Central America",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -83.15874182851002,
                                  14.994208074994077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Brewster",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 70.150754,
                                "long_x": -22.122616,
                                "region": "North America",
                                "subregion": "Greenland",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -22.122731086322517,
                                  70.15088532108783
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Morris Jesup",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 83.626331,
                                "long_x": -32.491541,
                                "region": "North America",
                                "subregion": "Greenland",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -32.49150550038502,
                                  83.62628815311908
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Grmsey",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 66.669359,
                                "long_x": -18.251096,
                                "region": "Europe",
                                "subregion": "Iceland",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -18.251088019916267,
                                  66.66937897343158
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Surtsey",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 63.217764,
                                "long_x": -20.434929,
                                "region": "Europe",
                                "subregion": "Iceland",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -20.434803840228767,
                                  63.21771881718158
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cap Est",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -15.274849,
                                "long_x": 50.499889,
                                "region": "Africa",
                                "subregion": "Indian Ocean",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  50.49976647227123,
                                  -15.274956964068423
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Cretin",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -6.637492,
                                "long_x": 147.852392,
                                "region": "Oceania",
                                "subregion": "Melanesia",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  147.85242760508373,
                                  -6.637261651568423
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Îles Chesterfield",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -19.20447,
                                "long_x": 159.95171,
                                "region": "Oceania",
                                "subregion": "Melanesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  159.95167076914623,
                                  -19.204644464068423
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Pagan",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 18.119631,
                                "long_x": 145.785087,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  145.78492272227123,
                                  18.119635321087827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Wake I.",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 19.303497,
                                "long_x": 166.63626,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  166.63624108164623,
                                  19.303595282025327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Tabiteuea",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -1.201405,
                                "long_x": 174.755207,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  174.75513756602123,
                                  -1.201348565630923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Aranuka",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 0.226766,
                                "long_x": 173.626286,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  173.62623131602123,
                                  0.226752020306577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Nauru",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -0.505856,
                                "long_x": 166.930778,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  166.93067467539623,
                                  -0.505791925005923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ebon",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 4.59977,
                                "long_x": 168.736432,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  168.73633873789623,
                                  4.599798895306577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Jaluit",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 5.964455,
                                "long_x": 169.682894,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  169.68299401133373,
                                  5.964483953900327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Mili",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 6.107334,
                                "long_x": 171.725875,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  171.72584069102123,
                                  6.107489324994077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Majuro",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 7.118009,
                                "long_x": 171.159743,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  171.15980065195873,
                                  7.117987371869077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ailinglapalap",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 7.276392,
                                "long_x": 168.596926,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  168.59693444102123,
                                  7.276495672650327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Kwajalein",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 8.746619,
                                "long_x": 167.735072,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  167.73511803477123,
                                  8.746710516400327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Rongelap",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 11.164329,
                                "long_x": 166.869876,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  166.86988365977123,
                                  11.164496160931577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Bikini",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 11.639231,
                                "long_x": 165.550698,
                                "region": "Oceania",
                                "subregion": "Micronesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  165.55042565195873,
                                  11.639288641400327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Reinga",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.432767,
                                "long_x": 172.7285,
                                "region": "Oceania",
                                "subregion": "New Zealand",
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  172.70558117137455,
                                  -34.42039113947056
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Kanton",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -2.757106,
                                "long_x": -171.71703,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -171.71703040272877,
                                  -2.757134698443423
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Tabuaeran",
                                "comment": null,
                                "name_alt": "Fanning I.",
                                "lat_y": 3.866545,
                                "long_x": -159.326781,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -159.32683264882252,
                                  3.866705633587827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Malden",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -4.042491,
                                "long_x": -154.983478,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -154.98350989491627,
                                  -4.042657159380923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Rarotonga",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -21.201867,
                                "long_x": -159.797637,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -159.79771887929127,
                                  -21.201836846880923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Rangiroa",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -15.2046,
                                "long_x": -147.773967,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -147.77403723866627,
                                  -15.204766534380923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Funafuti",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -8.491577,
                                "long_x": 179.19841,
                                "region": "Oceania",
                                "subregion": "Polynesia",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  179.19837487070873,
                                  -8.491631768755923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "St. Croix",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 17.762944,
                                "long_x": -64.763088,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -64.76317298085377,
                                  17.763006903119077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Grand Cayman",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 19.315829,
                                "long_x": -81.271416,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -81.27159583241627,
                                  19.315802313275327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "San  Salvador",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 24.052793,
                                "long_x": -74.492848,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -74.49290930897877,
                                  24.052801824994077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Grenada",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 12.105978,
                                "long_x": -61.723079,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.72319495351002,
                                  12.105963446087827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Barbuda",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 17.622525,
                                "long_x": -61.789243,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.78929602772877,
                                  17.622626043744077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Antigua",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 17.040441,
                                "long_x": -61.775982,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.77592932851002,
                                  17.040594793744077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Guadeloupe",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 16.180583,
                                "long_x": -61.656947,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.65703284413502,
                                  16.180670477337827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Dominica",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 15.452943,
                                "long_x": -61.352652,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.35271155507252,
                                  15.452887274212827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Martinique",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 14.672462,
                                "long_x": -61.008715,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.00883948476002,
                                  14.672491766400327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Saint Lucia",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 13.918332,
                                "long_x": -60.982225,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -60.98222815663502,
                                  13.918280340619077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Saint Vincent",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 13.270131,
                                "long_x": -61.207143,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -61.20720374257252,
                                  13.270209051556577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Barbados",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 13.164326,
                                "long_x": -59.566742,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -59.56682288319752,
                                  13.164252020306577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Tobago",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 11.259334,
                                "long_x": -60.677992,
                                "region": "South America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -60.67808997304127,
                                  11.259283758587827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Margarita",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 10.981467,
                                "long_x": -64.051401,
                                "region": "South America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -64.05144202382252,
                                  10.981512762494077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Curaao",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 12.185355,
                                "long_x": -68.999109,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -68.99919593007252,
                                  12.185309149212827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Aruba",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 12.502849,
                                "long_x": -69.96488,
                                "region": "North America",
                                "subregion": "West Indies",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -69.96501624257252,
                                  12.502752996869077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ras Banäs",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 23.950592,
                                "long_x": 35.778059,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  35.77808678477123,
                                  23.950628973431577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ponta das Salinas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -12.832908,
                                "long_x": 12.928991,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  12.968705086077254,
                                  -12.855718342716505
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ponta das Palmeirinhas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -9.071387,
                                "long_x": 12.999549,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  13.033811372274608,
                                  -9.099938228394153
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Bojador",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 26.157836,
                                "long_x": -14.473111,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -14.473194953510017,
                                  26.157965399212827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Comorin",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 8.143554,
                                "long_x": 77.471497,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  77.51210506924555,
                                  8.085338515340696
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Dondra Head",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 5.947528,
                                "long_x": 80.616321,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  80.59180925571331,
                                  5.929580617022318
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Yelizavety",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 54.416083,
                                "long_x": 142.720445,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  142.72059166758373,
                                  54.41620514530658
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Pt. Yuzhnyy",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 57.733572,
                                "long_x": 156.796426,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  156.79664147227123,
                                  57.73346588749408
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Sata",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 31.026941,
                                "long_x": 130.695089,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  130.69520104258373,
                                  31.026922918744077
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Aniva",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 46.081706,
                                "long_x": 143.43487,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  143.43482506602123,
                                  46.08179352421283
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Terpeniya",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 48.66928,
                                "long_x": 144.712582,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  144.71253502695873,
                                  48.66937897343158
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Lopatka",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 50.914155,
                                "long_x": 156.651536,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  156.65162194102123,
                                  50.91412994999408
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Ozernoy",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 57.7708,
                                "long_x": 163.246685,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  163.24683678477123,
                                  57.77088043827533
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Olyutorskiy",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 59.960807,
                                "long_x": 170.31265,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  170.31287682383373,
                                  59.96082184452533
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Navarin",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 62.327239,
                                "long_x": 179.074225,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  179.07422936289623,
                                  62.32727692265033
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Lopatka",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 71.907853,
                                "long_x": 150.066042,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  150.06592858164623,
                                  71.90778229374408
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Ince",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 42.084312,
                                "long_x": 34.983358,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  34.98328698008373,
                                  42.08417389530658
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ras Fartak",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 15.677412,
                                "long_x": 52.229105,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  52.2389696999939,
                                  15.65795249845498
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ras Sharbatat",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 18.164534,
                                "long_x": 56.56827,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  56.558165806017215,
                                  18.166986171245085
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ra's al Had",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 22.530158,
                                "long_x": 59.849134,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  59.7995168175437,
                                  22.518675327148298
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Hachijjima",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 33.109796,
                                "long_x": 139.804903,
                                "region": "Asia",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  139.80482018320873,
                                  33.10980866093158
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Nordkapp",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 71.18337,
                                "long_x": 25.662398,
                                "region": "Europe",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  25.66067519711473,
                                  71.15450206702127
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo de São Vicentete",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 37.038304,
                                "long_x": -8.969391,
                                "region": "Europe",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -8.969410773822517,
                                  37.03827545780658
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Fisterra",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 42.952418,
                                "long_x": -9.267837,
                                "region": "Europe",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -9.26996282865152,
                                  42.92873605781255
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape San Blas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 29.713967,
                                "long_x": -85.270961,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -85.27092444569752,
                                  29.713995672650327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Sable",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 43.469097,
                                "long_x": -65.610769,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -65.61082923085377,
                                  43.46900055546283
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Bauld",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 51.568576,
                                "long_x": -55.430306,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -55.43028723866627,
                                  51.56848786015033
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape Fear",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 33.867949,
                                "long_x": -77.990568,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -77.99058997304127,
                                  33.86798737186908
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "I. Guadalupe",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 29.052552,
                                "long_x": -118.317465,
                                "region": "Seven seas (open ocean)",
                                "subregion": "North Pacific Ocean",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -118.31749426991627,
                                  29.052496649212827
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Miquelon",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 46.929526,
                                "long_x": -56.329884,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -56.32988440663502,
                                  46.92938873905658
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "I. Robinson Crusoe",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -33.589852,
                                "long_x": -78.872522,
                                "region": "Seven seas (open ocean)",
                                "subregion": "South Pacific Ocean",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -78.87254798085377,
                                  -33.58965422969342
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Orange",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 4.125735,
                                "long_x": -51.242144,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -51.26287766987179,
                                  4.135614177285231
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo de Santa Marta Grande",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -28.558078,
                                "long_x": -48.735526,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -48.80338037734664,
                                  -28.57198267323537
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Punta del Este",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.975503,
                                "long_x": -54.933154,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -54.94628769070382,
                                  -34.96658679840526
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo San Antonio",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -36.381052,
                                "long_x": -56.655377,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -56.716792100626165,
                                  -36.40959917438929
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Corrientes",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -38.135985,
                                "long_x": -57.546212,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -57.56252349612641,
                                  -38.066376942128464
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Punta Rasa",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -40.834718,
                                "long_x": -62.282201,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -62.25911745789756,
                                  -40.72626411656719
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Dos Bahías",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -44.9887,
                                "long_x": -65.615952,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -65.5438334451688,
                                  -44.89439847091873
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Delgado",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -10.670103,
                                "long_x": 40.624309,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  40.62440026133373,
                                  -10.670098565630923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ponta da Barra",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -23.829888,
                                "long_x": 35.515696,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  35.51563561289623,
                                  -23.830010675005923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ponta São Sebastio",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -22.118899,
                                "long_x": 35.480417,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  35.48023522227123,
                                  -22.118829034380923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ras Cantin",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 32.581636,
                                "long_x": -9.273918,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -9.273915168353767,
                                  32.58161041874408
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ras Kasr",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 18.076817,
                                "long_x": 38.573746,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  38.58027735871919,
                                  18.075167704493374
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ponta de Jericoacoara",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -2.85044,
                                "long_x": -40.067208,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -39.991649927946355,
                                  -2.851822991583529
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo de São Roque",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -5.193476,
                                "long_x": -35.447654,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -35.50994900651512,
                                  -5.156866121305913
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Ponta da Baleia",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -17.710136,
                                "long_x": -39.157619,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -39.14557867836578,
                                  -17.678753845220847
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo de São Tomé",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -21.996382,
                                "long_x": -41.009692,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -40.98763990313761,
                                  -21.971754611783773
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Frio",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -22.869501,
                                "long_x": -41.962188,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -41.89015627474056,
                                  -22.759730815669258
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo San Diego",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -54.6406,
                                "long_x": -65.21365,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -65.21361243397877,
                                  -54.64067962031842
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cabo Tres Puntas",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -47.237629,
                                "long_x": -65.774707,
                                "region": "South America",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -65.74439816328368,
                                  -47.328778975372465
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cap Saint André",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -16.174457,
                                "long_x": 44.467405,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  44.46729576914623,
                                  -16.174493096880923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape St. Lucia",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -28.552694,
                                "long_x": 32.367221,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  32.36732018320873,
                                  -28.552666925005923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Cape St. Francis",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -34.171766,
                                "long_x": 24.817688,
                                "region": "Africa",
                                "subregion": null,
                                "featureclass": "cape"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  24.84143613032799,
                                  -34.18861022316314
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Minamitori-shima",
                                "comment": null,
                                "name_alt": "Marcus I.",
                                "lat_y": 24.319813,
                                "long_x": 153.958899,
                                "region": "Seven seas (open ocean)",
                                "subregion": "North Pacific Ocean",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  153.95887291758373,
                                  24.319769598431577
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Is. Martin Vaz",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": -20.559422,
                                "long_x": -29.338439,
                                "region": "Seven seas (open ocean)",
                                "subregion": "Southern Atlantic Ocean",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -29.338429328510017,
                                  -20.559502862505923
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Rockall",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 58.163524,
                                "long_x": -12.408715,
                                "region": "Seven seas (open ocean)",
                                "subregion": "North Atlantic Ocean",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -12.408741828510017,
                                  58.16339752811908
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "I. de Cozumel",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 20.444687,
                                "long_x": -86.880555,
                                "region": "North America",
                                "subregion": null,
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -86.88060462147877,
                                  20.444708563275327
                                ]
                              }
                            },
                            {
                              "type": "Feature",
                              "properties": {
                                "scalerank": 5,
                                "name": "Bermuda Islands",
                                "comment": null,
                                "name_alt": null,
                                "lat_y": 32.317339,
                                "long_x": -64.742895,
                                "region": "Seven seas (open ocean)",
                                "subregion": "North Atlantic Ocean",
                                "featureclass": "island"
                              },
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  -64.74290930897877,
                                  32.31726715702533
                                ]
                              }
                            }
                          ]
                        }
                    """.trimIndent()
                    )
                    cluster(true)
                    clusterRadius(50)
                    clusterMaxZoom(14)
                }

                Log.d(TAG, "onMethodCall: ADD GeoJson")
                return result.success(true)
            }
            else -> {
                Log.d(TAG, "onMethodCall: NOT Implemented")
            }
        }

    }

}

private enum class LayerType {
    FILL,
    LINE,
    CIRCLE,
    SYMBOL,
    VECTOR,
    RASTER
}

private fun layerTypeFromString(s: String): LayerType {
    return when (s) {
        "fill" -> LayerType.FILL
        "line" -> LayerType.LINE
        "circle" -> LayerType.CIRCLE
        "symbol" -> LayerType.SYMBOL
        "vector" -> LayerType.VECTOR
        "raster" -> LayerType.RASTER
        else -> LayerType.FILL
    }
}