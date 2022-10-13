package com.itheamc.mapbox_map_gl

import android.os.Build
import android.util.Log
import com.itheamc.mapbox_map_gl.helper.StyleHelper
import com.itheamc.mapbox_map_gl.helper.layer_helper.*
import com.itheamc.mapbox_map_gl.helper.source_helper.*
import com.itheamc.mapbox_map_gl.utils.*
import com.mapbox.bindgen.Expected
import com.mapbox.bindgen.ExpectedFactory
import com.mapbox.bindgen.None
import com.mapbox.maps.*
import com.mapbox.maps.extension.observable.eventdata.MapLoadingErrorEventData
import com.mapbox.maps.extension.style.layers.addLayer
import com.mapbox.maps.extension.style.layers.generated.*
import com.mapbox.maps.extension.style.sources.addSource
import com.mapbox.maps.extension.style.sources.generated.*
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
internal class MapboxMapGlControllerImpl(
    messenger: BinaryMessenger,
    private val mapboxMap: MapboxMap,
    private val creationParams: Map<*, *>?,
) : MapboxMapGlController {

    /**
     * Method channel to handle native method call
     */
    private val methodChannel: MethodChannel =
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
    private val _interactiveLayers = mutableListOf<StyleLayerInfo>()
    private val interactiveLayers: List<StyleLayerInfo> = _interactiveLayers

    /**
     * List of layer sources added by the user
     * that might need interaction
     */
    private val _interactiveLayerSources = mutableListOf<StyleSourceInfo>()

    /**
     * List of style image that was added
     */
    private val _styleImages = mutableListOf<StyleImageInfo>()

    /**
     * Getter for style
     */
    private val style: Style?
        get() = if (mapboxMap.isValid()) mapboxMap.getStyle() else null


    /**
     * Method to load the style uri
     */
    override fun loadStyleUri() {
        if (!mapboxMap.isValid()) return

        val mapStyle = creationParams?.get("style") as String?

        mapboxMap.loadStyleUri(
            StyleHelper.fromArgs(mapStyle),
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
    override fun animateToInitialCameraPosition() {

        if (!mapboxMap.isValid()) return

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
     * Method to toggle map style
     */
    override fun toggleStyle(list: List<*>): String? {

        // If mapbox is null
        if (!mapboxMap.isValid()) return null

        // return value
        var returnStr: String? = null

        // style uris as per the list args
        val styleUris = list.map { StyleHelper.fromArgs(if (it is String) it else it.toString()) }

        // If toggle between 2 style
        if (styleUris.isNotEmpty() && styleUris.size <= 2) {
            style?.let {
                mapboxMap.loadStyleUri(
                    if (it.styleURI == styleUris.first()) styleUris.last() else styleUris.first()
                )
                returnStr =
                    if (it.styleURI == styleUris.first()) list.first() as String else list.last() as String
            }
            return returnStr
        }

        // If toggle among the styles
        style?.let {

            // Current applied style index
            val i = styleUris.indexOf(it.styleURI)

            mapboxMap.loadStyleUri(
                if (i != -1) styleUris[(i + 1) % styleUris.size] else styleUris.first()
            )

            returnStr = if (i != -1) list[(i + 1) % list.size] as String else list.first() as String
        }

        return returnStr

    }

    /**
     * Method to animate camera
     */
    override fun animateCameraPosition(cameraPosition: CameraPosition) {
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
    override fun addGeoJsonSource(
        sourceId: String,
        block: GeoJsonSource.Builder.() -> Unit
    ) {
        style?.let {

            removeLayers(appliedLayers(sourceId))
                .onValue {
                    removeStyleSourceIfAny(sourceId)
                        .onValue {
                            style!!.addSource(geoJsonSource(sourceId, block)).also {
                                _interactiveLayerSources.add(
                                    StyleSourceInfo(
                                        sourceId,
                                        "GeoJsonSource"
                                    )
                                )
                            }
                        }
                }
        }
    }

    /**
     * Method to add vector sources
     */
    override fun addVectorSource(
        sourceId: String,
        block: VectorSource.Builder.() -> Unit
    ) {
        style?.let {
            removeLayers(appliedLayers(sourceId))
                .onValue {
                    removeStyleSourceIfAny(sourceId = sourceId)
                        .onValue {
                            style!!.addSource(
                                vectorSource(sourceId, block)
                            ).also {
                                _interactiveLayerSources.add(
                                    StyleSourceInfo(
                                        sourceId,
                                        "VectorSource"
                                    )
                                )

                            }
                        }
                }
        }
    }

    /**
     * Method to add raster sources
     */
    override fun addRasterSource(
        sourceId: String,
        block: RasterSource.Builder.() -> Unit
    ) {
        style?.let {
            removeLayers(appliedLayers(sourceId))
                .onValue {
                    removeStyleSourceIfAny(sourceId = sourceId)
                        .onValue {
                            style!!.addSource(
                                rasterSource(sourceId, block)
                            ).also {
                                _interactiveLayerSources.add(
                                    StyleSourceInfo(
                                        sourceId,
                                        "RasterSource"
                                    )
                                )

                            }
                        }
                }
        }
    }

    /**
     * Method to add raster dem sources
     */
    override fun addRasterDemSource(
        sourceId: String,
        block: RasterDemSource.Builder.() -> Unit
    ) {
        style?.let {
            removeLayers(appliedLayers(sourceId))
                .onValue {
                    removeStyleSourceIfAny(sourceId = sourceId)
                        .onValue {
                            style!!.addSource(
                                rasterDemSource(sourceId, block)
                            ).also {
                                _interactiveLayerSources.add(
                                    StyleSourceInfo(
                                        sourceId,
                                        "RasterDemSource"
                                    )
                                )

                            }
                        }
                }
        }
    }


    /**
     * Method to add image sources
     */
    override fun addImageSource(
        sourceId: String,
        block: ImageSource.Builder.() -> Unit
    ) {
        style?.let {
            removeLayers(appliedLayers(sourceId))
                .onValue {
                    removeStyleSourceIfAny(sourceId = sourceId)
                        .onValue {
                            style!!.addSource(
                                imageSource(sourceId, block)
                            ).also {
                                _interactiveLayerSources.add(
                                    StyleSourceInfo(
                                        sourceId,
                                        "ImageSource"
                                    )
                                )

                            }
                        }
                }
        }
    }


    /**
     * Method to add style image
     * It is basically used on symbol layer
     */
    override fun addStyleImage(args: Map<*, *>) {
        val imageId = args["imageId"] as String
        val sdf = args["sdf"] as Boolean

        val bitmap = StyleImageHelper.bitmapFromArgs(args)

        style?.let {
            bitmap?.let { b ->
                try {
                    removeStyleImageIfAny(imageId)
                        .onValue {
                            style!!.addImage(imageId, b, sdf).onValue {
                                _styleImages.add(StyleImageInfo(imageId, "ImageSource"))
                            }
                        }
                } catch (e: Exception) {
                    Log.e(TAG, "addStyleImage: ${e.message}", e)
                }
            }
        }
    }

    /**
     * Method to add line layer
     */
    override fun addLineLayer(
        layerId: String,
        sourceId: String,
        block: LineLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        lineLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "LineLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add circle layer
     */
    override fun addCircleLayer(
        layerId: String,
        sourceId: String,
        block: CircleLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        circleLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "CircleLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add fill layer
     */
    override fun addFillLayer(
        layerId: String,
        sourceId: String,
        block: FillLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        fillLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "FillLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add symbol layer
     */
    override fun addSymbolLayer(
        layerId: String,
        sourceId: String,
        block: SymbolLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        symbolLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "SymbolLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add raster layer
     */
    override fun addRasterLayer(
        layerId: String,
        sourceId: String,
        block: RasterLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        rasterLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "RasterLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add hill shade layer
     */
    override fun addHillShadeLayer(
        layerId: String,
        sourceId: String,
        block: HillshadeLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        hillshadeLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "HillShadeLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add heatmap layer
     */
    override fun addHeatmapLayer(
        layerId: String,
        sourceId: String,
        block: HeatmapLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        heatmapLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "HeatmapLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add fill extrusion layer
     */
    override fun addFillExtrusionLayer(
        layerId: String,
        sourceId: String,
        block: FillExtrusionLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        fillExtrusionLayer(
                            layerId = layerId,
                            sourceId = sourceId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = sourceId,
                                    layerType = "FillExtrusionLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add location indicator layer
     */
    override fun addLocationIndicatorLayer(
        layerId: String,
        block: LocationIndicatorLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        locationIndicatorLayer(
                            layerId = layerId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = null,
                                    layerType = "LocationIndicatorLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add background layer
     */
    override fun addSkyLayer(
        layerId: String,
        block: SkyLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        skyLayer(
                            layerId = layerId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = null,
                                    layerType = "SkyLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add background layer
     */
    override fun addBackgroundLayer(
        layerId: String,
        block: BackgroundLayerDsl.() -> Unit
    ) {
        style?.let {
            removeLayerIfAny(layerId)
                .onValue {
                    style!!.addLayer(
                        backgroundLayer(
                            layerId = layerId,
                            block = block
                        ).also {
                            _interactiveLayers.add(
                                StyleLayerInfo(
                                    layerId = layerId,
                                    sourceId = null,
                                    layerType = "BackgroundLayer"
                                )
                            )
                        }
                    )
                }
        }
    }

    /**
     * Method to add style model
     */
    @OptIn(MapboxExperimental::class)
    override fun addStyleModel(modelId: String, modelUri: String): Expected<String, None> {
        return if (style != null) {
            style!!.addStyleModel(modelId, modelUri)
        } else {
            ExpectedFactory.createError("Style is null!")
        }
    }

    /**
     * Method to add map related listeners
     * --------------------------------------------------------------------------------------
     */
    override fun addMapRelatedListeners() {
        if (!mapboxMap.isValid()) return

        /**
         * On Map Loaded Listener
         */
        mapboxMap.addOnMapLoadedListener {
            methodChannel.invokeMethod(Methods.onMapLoaded, null)
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
                options = RenderedQueryOptions(interactiveLayers.map { l -> l.layerId }, null),
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
                options = RenderedQueryOptions(interactiveLayers.map { l -> l.layerId }, null),
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
     * Method to get the list of applied layer id on given source
     * params:
     * {sourceId} -> Id of the source
     */
    override fun appliedLayers(sourceId: String): List<String> {
        return interactiveLayers
            .filter { it.sourceId == sourceId }
            .map { it.layerId }
    }

    /**
     * Method to remove layer if already added
     */
    override fun removeLayerIfAny(layerId: String): Expected<String, None> {
        return if (_interactiveLayers.any { it.layerId == layerId }) {
            if (Build.VERSION.SDK_INT >= 24) {
                _interactiveLayers.removeIf { it.layerId == layerId }
            } else {
                _interactiveLayers.clear()
                _interactiveLayers.addAll(_interactiveLayers.filter { it.layerId != layerId })
            }
            style!!.removeStyleLayer(layerId)
        } else if (style?.styleLayerExists(layerId) == true) {
            style!!.removeStyleLayer(layerId)
        } else {
            ExpectedFactory.createValue(None.getInstance())
        }
    }


    /**
     * Method to remove style source if already added
     */
    override fun removeStyleSourceIfAny(
        sourceId: String,
    ): Expected<String, None> {
        return if (_interactiveLayerSources.any { it.sourceId == sourceId }) {

            if (Build.VERSION.SDK_INT >= 24) {
                _interactiveLayerSources.removeIf { it.sourceId == sourceId }
            } else {
                _interactiveLayerSources.clear()
                _interactiveLayerSources.addAll(_interactiveLayerSources.filter { it.sourceId == sourceId })
            }

            style!!.removeStyleSource(sourceId)
        } else if (style?.styleSourceExists(sourceId) == true) {
            style!!.removeStyleSource(sourceId)
        } else {
            ExpectedFactory.createValue(None.getInstance())
        }
    }

    /**
     * Method to remove style image if already added
     */
    override fun removeStyleImageIfAny(imageId: String): Expected<String, None> {
        return if (_styleImages.any { it.imageId == imageId }) {

            if (Build.VERSION.SDK_INT >= 24) {
                _styleImages.removeIf { it.imageId == imageId }
            } else {
                _styleImages.clear()
                _styleImages.addAll(_styleImages.filter { it.imageId == imageId })
            }

            style!!.removeStyleImage(imageId)
        } else if (style?.hasStyleImage(imageId) == true) {
            style!!.removeStyleImage(imageId)
        } else {
            ExpectedFactory.createValue(None.getInstance())
        }
    }

    /**
     * Method to remove layers
     */
    override fun removeLayers(layersId: List<String>): Expected<String, None> {
        layersId.forEach { id ->
            style?.let {
                val expectedResult = style!!.removeStyleLayer(id)
                expectedResult.onValue {
                    if (Build.VERSION.SDK_INT >= 24) {
                        _interactiveLayers.removeIf { it.layerId == id }
                    } else {
                        _interactiveLayers.clear()
                        _interactiveLayers.addAll(_interactiveLayers.filter { it.layerId != id })
                    }
                }
            }
        }.also {
            return ExpectedFactory.createValue(None.getInstance())
        }
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
                val sourceId = args as String
                val isExist = style?.styleSourceExists(sourceId) ?: false
                return result.success(isExist)
            }
            Methods.isLayerExist -> {
                val layerId = args as String
                val isExist = style?.styleLayerExists(layerId) ?: false
                return result.success(isExist)
            }
            Methods.isStyleImageExist -> {
                val imageId = args as String
                val isExist = style?.hasStyleImage(imageId) ?: false
                return result.success(isExist)
            }
            Methods.toggleStyle -> {
                args = args as List<*>
                val selectedStyle = toggleStyle(args)
                return result.success(selectedStyle)
            }
            Methods.animateCameraPosition -> {
                val cameraPosition: CameraPosition = CameraPosition
                    .fromArgs(args as Map<*, *>)
                animateCameraPosition(cameraPosition)
                return result.success(true)
            }
            Methods.addGeoJsonSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addGeoJsonSource(
                    sourceId = sourceId,
                    block = GeoJsonSourceHelper.blockFromArgs(args)
                )
                return result.success(true)
            }
            Methods.addVectorSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addVectorSource(
                    sourceId = sourceId,
                    block = VectorSourceHelper.blockFromArgs(args)
                )
                return result.success(true)
            }
            Methods.addRasterSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addRasterSource(
                    sourceId = sourceId,
                    block = RasterSourceHelper.blockFromArgs(args)
                )
                return result.success(true)
            }
            Methods.addRasterDemSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addRasterDemSource(
                    sourceId = sourceId,
                    block = RasterDemSourceHelper.blockFromArgs(args)
                )
                return result.success(true)
            }
            Methods.addImageSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addImageSource(
                    sourceId = sourceId,
                    block = ImageSourceHelper.blockFromArgs(args)
                )
                return result.success(true)
            }
            Methods.addVideoSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addImageSource(
                    sourceId = sourceId,
                    block = VideoSourceHelper.blockFromArgs(args)
                )
                return result.success(true)
            }
            Methods.addCircleLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addCircleLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = CircleLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addLineLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addLineLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = LineLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addFillLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addFillLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = FillLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addSymbolLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addSymbolLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = SymbolLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addRasterLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addRasterLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = RasterLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addSkyLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>
                addSkyLayer(
                    layerId = layerId,
                    block = SkyLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addFillExtrusionLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addFillExtrusionLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = FillExtrusionLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addHeatmapLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addHeatmapLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = HeatmapLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addHillShadeLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val sourceId = args["sourceId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addHillShadeLayer(
                    layerId = layerId,
                    sourceId = sourceId,
                    block = HillShadeLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addBackgroundLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addBackgroundLayer(
                    layerId = layerId,
                    block = BackgroundLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addLocationIndicatorLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addLocationIndicatorLayer(
                    layerId = layerId,
                    block = LocationIndicatorLayerHelper.blockFromArgs(layerProperties)
                )
                return result.success(true)
            }
            Methods.addStyleImage -> {
                addStyleImage(args as Map<*, *>)
                result.success(true)
            }
            Methods.removeLayer -> {
                val layerId = args as String
                removeLayerIfAny(layerId)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.removeLayers -> {
                val layersId = args as List<*>
                removeLayers(layersId.map { if (it is String) it else it.toString() })
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.removeSource -> {
                val sourceId = args as String
                removeStyleSourceIfAny(sourceId)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.removeStyleImage -> {
                val imageId = args as String
                removeStyleImageIfAny(imageId)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.addStyleModel -> {
                args = args as Map<*, *>

                val modelId = args["modelId"] as String
                val modelUri = args["modelUri"] as String

                addStyleModel(modelId = modelId, modelUri = modelUri)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            else -> {
                Log.d(TAG, "onMethodCall: NOT Implemented")
            }
        }

    }
}