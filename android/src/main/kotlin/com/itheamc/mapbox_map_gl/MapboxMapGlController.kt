package com.itheamc.mapbox_map_gl

import android.graphics.Bitmap
import android.os.Build
import android.util.Log
import com.itheamc.mapbox_map_gl.utils.CameraPosition
import com.itheamc.mapbox_map_gl.helper.layer_helper.CircleLayerHelper
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

/**
 * MapboxMapGlController.kt
 *
 * Created by Amit Chaudhary, 2022/10/3
 */
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
            .fromArgs(initialCameraPosition as Map<*, *>)

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

                        val scrCords = mapOf("x" to screenCoordinate.x, "y" to screenCoordinate.y)

                        if (features.isNotEmpty()) {

                            val source = features[0].source
                            val feature = features[0].feature

                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "point" to it.toJson(),
                                    "screen_coordinate" to scrCords,
                                    "feature" to feature.toJson(),
                                    "source" to source
                                )

                            methodChannel.invokeMethod(Methods.onFeatureClick, arguments)
                        } else {
                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "point" to it.toJson(),
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

                        val scrCords = mapOf("x" to screenCoordinate.x, "y" to screenCoordinate.y)

                        if (features.isNotEmpty()) {
                            val source = features[0].source
                            val feature = features[0].feature

                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "point" to it.toJson(),
                                    "screen_coordinate" to scrCords,
                                    "feature" to feature.toJson(),
                                    "source" to source
                                )

                            methodChannel.invokeMethod(Methods.onFeatureLongClick, arguments)
                        } else {
                            val arguments: Map<String, Any?> =
                                mapOf(
                                    "point" to it.toJson(),
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
                        LayerType.valueOf((layerType as String).uppercase())
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
                    .fromArgs(args as Map<*, *>)
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
                    circleLayer = if (circleLayer != null) CircleLayerHelper.blockFromArgs(
                        (circleLayer as Map<*, *>)["options"] as Map<*, *>
                    ) else null
                ) {
                    data(
                        TestingData.geoJson
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

/**
 * Enum class for Layer Type
 */
private enum class LayerType {
    FILL,
    LINE,
    CIRCLE,
    SYMBOL,
    VECTOR,
    RASTER
}