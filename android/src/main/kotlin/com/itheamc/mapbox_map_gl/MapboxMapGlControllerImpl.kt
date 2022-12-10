package com.itheamc.mapbox_map_gl

import android.os.Build
import android.util.Log
import com.itheamc.mapbox_map_gl.helper.*
import com.itheamc.mapbox_map_gl.helper.annotation_helper.CircleAnnotationOptionsHelper
import com.itheamc.mapbox_map_gl.helper.annotation_helper.PointAnnotationOptionsHelper
import com.itheamc.mapbox_map_gl.helper.annotation_helper.PolygonAnnotationOptionsHelper
import com.itheamc.mapbox_map_gl.helper.annotation_helper.PolylineAnnotationOptionsHelper
import com.itheamc.mapbox_map_gl.helper.layer_helper.*
import com.itheamc.mapbox_map_gl.helper.source_helper.*
import com.itheamc.mapbox_map_gl.utils.*
import com.mapbox.bindgen.Expected
import com.mapbox.bindgen.ExpectedFactory
import com.mapbox.bindgen.None
import com.mapbox.geojson.Feature
import com.mapbox.geojson.Point
import com.mapbox.maps.*
import com.mapbox.maps.extension.observable.eventdata.MapLoadingErrorEventData
import com.mapbox.maps.extension.style.layers.addLayer
import com.mapbox.maps.extension.style.layers.generated.*
import com.mapbox.maps.extension.style.layers.properties.generated.*
import com.mapbox.maps.extension.style.sources.addSource
import com.mapbox.maps.extension.style.sources.generated.*
import com.mapbox.maps.plugin.animation.flyTo
import com.mapbox.maps.plugin.annotation.*
import com.mapbox.maps.plugin.annotation.Annotation
import com.mapbox.maps.plugin.annotation.generated.*
import com.mapbox.maps.plugin.delegates.listeners.*
import com.mapbox.maps.plugin.gestures.*
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
    private val mapView: MapView,
    private val creationParams: Map<*, *>?,
) : MapboxMapGlController {

    /**
     * Method channel to handle native method call
     */
    private val methodChannel: MethodChannel =
        MethodChannel(messenger, MapboxMapGlPlugin.METHOD_CHANNEL_NAME)


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
     * Getter for mapbox map
     */
    private val mapboxMap: MapboxMap
        get() = mapView.getMapboxMap()

    /**
     * Getter for style
     */
    private val style: Style?
        get() = if (mapboxMap.isValid()) mapboxMap.getStyle() else null


    /**
     * Circle Annotation manager instance
     */
    private val circleAnnotationManager = mapView.annotations.createCircleAnnotationManager(
        annotationConfig = AnnotationConfig(
            annotationSourceOptions = AnnotationSourceOptions()
        )
    )

    /**
     * Point Annotation manager instance
     */
    private val pointAnnotationManager = mapView.annotations.createPointAnnotationManager(
        annotationConfig = AnnotationConfig(
            annotationSourceOptions = AnnotationSourceOptions()
        )
    )

    /**
     * Polygon Annotation manager instance
     */
    private val polygonAnnotationManager = mapView.annotations.createPolygonAnnotationManager(
        annotationConfig = AnnotationConfig(
            annotationSourceOptions = AnnotationSourceOptions()
        )
    )

    /**
     * Polyline Annotation manager instance
     */
    private val polylineAnnotationManager = mapView.annotations.createPolylineAnnotationManager(
        annotationConfig = AnnotationConfig(
            annotationSourceOptions = AnnotationSourceOptions()
        )
    )


    /**
     * Listeners that will be added on Mapbox Map
     * ---------------------------------------------------------------------
     */

    /**
     * MapLoadedListener object
     */
    private val mapLoadedListener = OnMapLoadedListener {
        methodChannel.invokeMethod(Methods.onMapLoaded, null)
    }

    /**
     * MapLoadErrorListener object
     */
    private val mapLoadErrorListener = object : OnMapLoadErrorListener {
        override fun onMapLoadError(eventData: MapLoadingErrorEventData) {
            methodChannel.invokeMethod(Methods.onMapLoadError, eventData.message)
        }
    }

    /**
     * StyleLoadedListener object
     */
    private val styleLoadedListener = OnStyleLoadedListener {
        _interactiveLayerSources.clear()
        _interactiveLayers.clear()
        methodChannel.invokeMethod(Methods.onStyleLoaded, null)
    }

    /**
     * MapIdleListener object
     */
    private val mapIdleListener = OnMapIdleListener {
        methodChannel.invokeMethod(Methods.onMapIdle, null)
    }

    /**
     * CameraChangeListener object
     */
    private val cameraChangeListener = OnCameraChangeListener {
        methodChannel.invokeMethod(Methods.onCameraChange, null)
    }

    /**
     * SourceAddedListener object
     */
    private val sourceAddedListener = OnSourceAddedListener {
        methodChannel.invokeMethod(Methods.onSourceAdded, it.id)
    }

    /**
     * SourceDataLoadedListener object
     */
    private val sourceDataLoadedListener = OnSourceDataLoadedListener {
        val args = mapOf(
            "id" to it.id,
            "type" to it.type.value,
            "loaded" to it.loaded
        )
        methodChannel.invokeMethod(Methods.onSourceDataLoaded, args)
    }

    /**
     * SourceRemovedListener object
     */
    private val sourceRemovedListener = OnSourceRemovedListener {
        methodChannel.invokeMethod(Methods.onSourceRemoved, it.id)
    }

    /**
     * RenderFrameStartedListener object
     */
    private val renderFrameStartedListener = OnRenderFrameStartedListener {
        methodChannel.invokeMethod(Methods.onRenderFrameStarted, null)
    }

    /**
     * RenderFrameFinishedListener object
     */
    private val renderFrameFinishedListener = OnRenderFrameFinishedListener {
        methodChannel.invokeMethod(Methods.onRenderFrameFinished, null)
    }

    /**
     * MapClickListener object
     */
    private val mapClickListener = OnMapClickListener {
        val screenCoordinate: ScreenCoordinate = mapboxMap.pixelForCoordinate(it)

        mapboxMap.queryRenderedFeatures(
            geometry = RenderedQueryGeometry(screenCoordinate),
            options = RenderedQueryOptions(interactiveLayers.map { l -> l.layerId }, null),
            callback = { expectedValue ->
                expectedValue.onValue { features ->

                    val scrCords = mapOf("x" to screenCoordinate.x, "y" to screenCoordinate.y)

                    if (features.isNotEmpty()) {

                        val source = features[0].source
                        val sourceLayer = features[0].sourceLayer
                        val feature = features[0].feature

                        val arguments: Map<String, Any?> =
                            mapOf(
                                "point" to it.toJson(),
                                "screen_coordinate" to scrCords,
                                "feature" to feature.toJson(),
                                "source" to source,
                                "source_layer" to sourceLayer
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
     * MapLongClickListener object
     */
    private val mapLongClickListener = OnMapLongClickListener {
        val screenCoordinate: ScreenCoordinate = mapboxMap.pixelForCoordinate(it)

        mapboxMap.queryRenderedFeatures(
            geometry = RenderedQueryGeometry(mapboxMap.pixelForCoordinate(it)),
            options = RenderedQueryOptions(interactiveLayers.map { l -> l.layerId }, null),
            callback = { expectedValue ->
                expectedValue.onValue { features ->

                    val scrCords = mapOf("x" to screenCoordinate.x, "y" to screenCoordinate.y)

                    if (features.isNotEmpty()) {
                        val source = features[0].source
                        val sourceLayer = features[0].sourceLayer
                        val feature = features[0].feature

                        val arguments: Map<String, Any?> =
                            mapOf(
                                "point" to it.toJson(),
                                "screen_coordinate" to scrCords,
                                "feature" to feature.toJson(),
                                "source" to source,
                                "source_layer" to sourceLayer
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

    /**
     * CircleAnnotationClickListener object
     */
    private val circleAnnotationClickListener = OnCircleAnnotationClickListener {
        methodChannel.invokeMethod(
            Methods.onCircleAnnotationClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * PointAnnotationClickListener object
     */
    private val pointAnnotationClickListener = OnPointAnnotationClickListener {
        methodChannel.invokeMethod(
            Methods.onPointAnnotationClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * PolylineAnnotationClickListener object
     */
    private val polylineAnnotationClickListener = OnPolylineAnnotationClickListener {
        methodChannel.invokeMethod(
            Methods.onPolylineAnnotationClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * PolygonAnnotationClickListener object
     */
    private val polygonAnnotationClickListener = OnPolygonAnnotationClickListener {
        methodChannel.invokeMethod(
            Methods.onPolygonAnnotationClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * CircleAnnotationLongClickListener object
     */
    private val circleAnnotationLongClickListener = OnCircleAnnotationLongClickListener {
        methodChannel.invokeMethod(
            Methods.onCircleAnnotationLongClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * PointAnnotationLongClickListener object
     */
    private val pointAnnotationLongClickListener = OnPointAnnotationLongClickListener {
        methodChannel.invokeMethod(
            Methods.onPointAnnotationLongClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * PolylineAnnotationLongClickListener object
     */
    private val polylineAnnotationLongClickListener = OnPolylineAnnotationLongClickListener {
        methodChannel.invokeMethod(
            Methods.onPolylineAnnotationLongClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * PolygonAnnotationLongClickListener object
     */
    private val polygonAnnotationLongClickListener = OnPolygonAnnotationLongClickListener {
        methodChannel.invokeMethod(
            Methods.onPolygonAnnotationLongClick, mapOf(
                "id" to it.id,
                "type" to it.getType().name,
                "data" to if (it.getData() != null) it.getData()!!.asJsonObject.toString() else null
            )
        )
        true
    }

    /**
     * CircleAnnotationDragListener object
     */
    private val circleAnnotationDragListener = object : OnCircleAnnotationDragListener {
        override fun onAnnotationDrag(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onCircleAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "point" to (annotation as CircleAnnotation).point.toJson(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragging"
                )
            )
        }

        override fun onAnnotationDragFinished(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onCircleAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "point" to (annotation as CircleAnnotation).point.toJson(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragFinished"
                )
            )
        }

        override fun onAnnotationDragStarted(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onCircleAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "point" to (annotation as CircleAnnotation).point.toJson(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragStarted"
                )
            )
        }
    }

    /**
     * PointAnnotationDragListener object
     */
    private val pointAnnotationDragListener = object : OnPointAnnotationDragListener {
        override fun onAnnotationDrag(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPointAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "point" to (annotation as PointAnnotation).point.toJson(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragging"
                )
            )
        }

        override fun onAnnotationDragFinished(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPointAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "point" to (annotation as PointAnnotation).point.toJson(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragFinished"
                )
            )
        }

        override fun onAnnotationDragStarted(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPointAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "point" to (annotation as PointAnnotation).point.toJson(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragStarted"
                )
            )
        }
    }

    /**
     * PolylineAnnotationDragListener object
     */
    private val polylineAnnotationDragListener = object : OnPolylineAnnotationDragListener {
        override fun onAnnotationDrag(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPolylineAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "points" to (annotation as PolylineAnnotation).points.map { it.toJson() }
                        .toList(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragging"
                )
            )
        }

        override fun onAnnotationDragFinished(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPolylineAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "points" to (annotation as PolylineAnnotation).points.map { it.toJson() }
                        .toList(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragFinished"
                )
            )
        }

        override fun onAnnotationDragStarted(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPolylineAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "points" to (annotation as PolylineAnnotation).points.map { it.toJson() }
                        .toList(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragStarted"
                )
            )
        }
    }

    /**
     * PolygonAnnotationDragListener object
     */
    private val polygonAnnotationDragListener = object : OnPolygonAnnotationDragListener {
        override fun onAnnotationDrag(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPolygonAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "points" to (annotation as PolygonAnnotation).points.map {
                        it.map { p -> p.toJson() }.toList()
                    }
                        .toList(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragging"
                )
            )
        }

        override fun onAnnotationDragFinished(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPolygonAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "points" to (annotation as PolygonAnnotation).points.map {
                        it.map { p -> p.toJson() }.toList()
                    }
                        .toList(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragFinished"
                )
            )
        }

        override fun onAnnotationDragStarted(annotation: Annotation<*>) {
            methodChannel.invokeMethod(
                Methods.onPolygonAnnotationDrag, mapOf(
                    "id" to annotation.id,
                    "type" to annotation.getType().name,
                    "points" to (annotation as PolygonAnnotation).points.map {
                        it.map { p -> p.toJson() }.toList()
                    }
                        .toList(),
                    "data" to if (annotation.getData() != null) annotation.getData()!!.asJsonObject.toString() else null,
                    "event" to "onDragStarted"
                )
            )
        }
    }

    /**
     * Init Block
     */
    init {
        methodChannel.setMethodCallHandler(this)
        addMapRelatedListeners()
        loadStyleUri(null)
    }


    /**
     * Method to load the style uri
     */
    override fun loadStyleUri(styleUri: String?) {
        if (!mapboxMap.isValid()) return

        if (styleUri == null) {
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
        } else {
            mapboxMap.loadStyleUri(
                styleUri = styleUri,
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
    }

    /**
     * Method to load the style json
     */
    override fun loadStyleJson(styleJson: String): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid mapbox")

        return try {
            mapboxMap.loadStyleJson(styleJson)
            ExpectedFactory.createNone()
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to reduce memory uses
     * Reduce memory use. Useful to call when the application gets paused
     * or sent to background.
     */
    override fun reduceMemoryUse(): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid mapbox")

        return try {
            mapboxMap.reduceMemoryUse()
            ExpectedFactory.createNone()
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to set map memory budget
     */
    @OptIn(MapboxExperimental::class)
    override fun setMapMemoryBudget(args: Map<*, *>): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid mapbox")

        return try {
            val memoryBudget = MapMemoryBudgetHelper.fromArgs(args)

            if (memoryBudget != null) {
                mapboxMap.setMemoryBudget(memoryBudget)
                ExpectedFactory.createNone()
            } else {
                ExpectedFactory.createError("Invalid parameters")
            }
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "Something went wrong")
        }
    }

    /**
     * Method to trigger map repaint
     */
    override fun triggerRepaint(): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid mapbox")

        return try {
            mapboxMap.triggerRepaint()
            ExpectedFactory.createNone()
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
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
        return if (style != null && style!!.isValid()) {
            style!!.addStyleModel(modelId, modelUri)
        } else {
            ExpectedFactory.createError("Style is null!")
        }
    }

    /**
     * Method to check if style model with particular id is already added or not
     */
    @OptIn(MapboxExperimental::class)
    override fun hasStyleModel(modelId: String): Boolean {
        return if (style != null && style!!.isValid()) {
            style!!.hasStyleModel(modelId)
        } else {
            false
        }
    }

    /**
     * Method to remove style model with particular id if already added
     */
    @OptIn(MapboxExperimental::class)
    override fun removeStyleModel(modelId: String): Expected<String, None> {
        return if (style != null && style!!.isValid()) {
            style!!.removeStyleModel(modelId)
        } else {
            ExpectedFactory.createError("Style is null!")
        }
    }

    /**
     * Method to set style source property to the already added source with given id
     */
    override fun setStyleSourceProperty(args: Map<*, *>): Expected<String, None> {

        return if (style != null && style!!.isValid()) {
            val sourceId = args["sourceId"] as String
            val property = args["property"] as String
            val value = ValueHelper.toValue(args["value"])

            style!!.setStyleSourceProperty(
                sourceId = sourceId,
                property = property,
                value = value
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to set style source properties to the already added source with given id
     */
    override fun setStyleSourceProperties(args: Map<*, *>): Expected<String, None> {

        return if (style != null && style!!.isValid()) {
            val sourceId = args["sourceId"] as String
            val properties = args["properties"] as Map<*, *>

            val propertiesAsValue = ValueHelper.toValue(properties)

            style!!.setStyleSourceProperties(
                sourceId = sourceId,
                properties = propertiesAsValue,
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to set style layer property to the already added layer with given id
     */
    override fun setStyleLayerProperty(args: Map<*, *>): Expected<String, None> {

        return if (style != null && style!!.isValid()) {
            val layerId = args["layerId"] as String
            val property = args["property"] as String
            val value = ValueHelper.toValue(args["value"])

            style!!.setStyleLayerProperty(
                layerId = layerId,
                property = property,
                value = value
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to set style layer properties to the already added layer with given id
     */
    override fun setStyleLayerProperties(args: Map<*, *>): Expected<String, None> {

        return if (style != null && style!!.isValid()) {
            val layerId = args["layerId"] as String
            val properties = args["properties"] as Map<*, *>

            val propertiesAsValue = ValueHelper.toValue(properties)

            style!!.setStyleLayerProperties(
                layerId = layerId,
                properties = propertiesAsValue,
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to move style layer above given layer
     */
    override fun moveStyleLayerAbove(args: Map<*, *>): Expected<String, None> {
        return if (style != null && style!!.isValid()) {
            val layerId = args["layerId"] as String
            val belowLayerId = args["belowLayerId"] as String

            style!!.moveStyleLayer(
                layerId = layerId,
                layerPosition = LayerPosition(
                    null,
                    belowLayerId,
                    null
                )
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to move style layer below given layer
     */
    override fun moveStyleLayerBelow(args: Map<*, *>): Expected<String, None> {
        return if (style != null && style!!.isValid()) {
            val layerId = args["layerId"] as String
            val aboveLayerId = args["aboveLayerId"] as String
            style!!.moveStyleLayer(
                layerId = layerId,
                layerPosition = LayerPosition(
                    aboveLayerId,
                    null,
                    null
                )
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to move style layer at specific position
     */
    override fun moveStyleLayerAt(args: Map<*, *>): Expected<String, None> {
        return if (style != null && style!!.isValid()) {
            val layerId = args["layerId"] as String
            val at = args["at"] as Int

            style!!.moveStyleLayer(
                layerId = layerId,
                layerPosition = LayerPosition(
                    null,
                    null,
                    at
                )
            )

        } else {
            ExpectedFactory.createError("Style is Null!")
        }
    }

    /**
     * Method to query the map for source features.
     */
    override fun querySourceFeatures(
        args: Map<*, *>,
        queryFeaturesCallback: QueryFeaturesCallback
    ) {
        if (mapboxMap.isValid()) {
            val sourceId = args["sourceId"] as String
            val options = args["options"] as Map<*, *>

            val sourceLayerIds =
                if (options.containsKey("sourceLayerIds")) (options["sourceLayerIds"] as List<*>).map { it as String } else null
            val filter = ValueHelper.toValue(options["filter"])

            mapboxMap.querySourceFeatures(
                sourceId = sourceId,
                options = SourceQueryOptions(
                    sourceLayerIds,
                    filter
                ),
                queryFeaturesCallback
            )

        } else {
            queryFeaturesCallback.run(ExpectedFactory.createError("Invalid mapbox"))
        }
    }

    /**
     * Method to query the map for rendered features.
     */
    override fun queryRenderedFeatures(
        args: Map<*, *>,
        queryFeaturesCallback: QueryFeaturesCallback
    ) {
        if (mapboxMap.isValid()) {
            val geometryArgs =
                if (args.containsKey("geometry")) args["geometry"] as Map<*, *> else null
            val optionsArgs =
                if (args.containsKey("options") && args["options"] != null) args["options"] as Map<*, *> else null

            if (geometryArgs == null || optionsArgs == null) {
                queryFeaturesCallback.run(ExpectedFactory.createError("Parameters are null"))
            }

            val geometry = RenderedQueryGeometryHelper.fromArgs(geometryArgs)
            val option = optionsArgs?.let {
                RenderedQueryOptions(
                    if (it.containsKey("layerIds")) (it["layerIds"] as List<*>).map { str -> str as String } else null,
                    ValueHelper.toValue(it["filter"])
                )
            }

            if (geometry != null) {
                mapboxMap.queryRenderedFeatures(
                    geometry = geometry,
                    options = option ?: RenderedQueryOptions(null, null),
                    queryFeaturesCallback
                )
            } else {
                queryFeaturesCallback.run(ExpectedFactory.createError("Geometry is invalid!"))
                return
            }

        } else {
            queryFeaturesCallback.run(ExpectedFactory.createError("Invalid mapbox"))
        }
    }

    /**
     * Method to get geo json cluster children.
     */
    override fun getGeoJsonClusterChildren(
        args: Map<*, *>,
        queryFeatureExtensionCallback: QueryFeatureExtensionCallback
    ) {
        if (mapboxMap.isValid()) {
            val sourceId = args["sourceId"] as String
            val cluster = args["cluster"] as String

            mapboxMap.getGeoJsonClusterChildren(
                sourceIdentifier = sourceId,
                cluster = Feature.fromJson(cluster),
                callback = queryFeatureExtensionCallback
            )

        } else {
            queryFeatureExtensionCallback.run(ExpectedFactory.createError("Invalid mapbox"))
        }
    }

    /**
     * Method to get geo json cluster leaves.
     */
    override fun getGeoJsonClusterLeaves(
        args: Map<*, *>,
        queryFeatureExtensionCallback: QueryFeatureExtensionCallback
    ) {
        if (mapboxMap.isValid()) {
            val sourceId = args["sourceId"] as String
            val cluster = args["cluster"] as String
            val limit = when (val v = args["limit"]) {
                is Long -> v
                is Int -> v.toLong()
                is Double -> v.toLong()
                else -> 10L
            }
            val offset = when (val v = args["offset"]) {
                is Long -> v
                is Int -> v.toLong()
                is Double -> v.toLong()
                else -> 0L
            }

            mapboxMap.getGeoJsonClusterLeaves(
                sourceIdentifier = sourceId,
                cluster = Feature.fromJson(cluster),
                limit = limit,
                offset = offset,
                callback = queryFeatureExtensionCallback
            )

        } else {
            queryFeatureExtensionCallback.run(ExpectedFactory.createError("Invalid mapbox"))
        }
    }

    /**
     * Method to update the state map of a feature within a style source.
     */
    override fun setFeatureState(args: Map<*, *>): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        val sourceId = args["sourceId"] as String
        val sourceLayerId = args["sourceLayerId"] as String?
        val featureId = args["featureId"] as String
        val state = args["state"] as Map<*, *>

        if (state.isEmpty()) return ExpectedFactory.createError("No state to update")

        mapboxMap.setFeatureState(
            sourceId = sourceId,
            sourceLayerId = sourceLayerId,
            featureId = featureId,
            state = ValueHelper.toValue(state)
        )

        return ExpectedFactory.createNone()

    }

    /**
     * Method to remove entries from a feature state map
     */
    override fun removeFeatureState(args: Map<*, *>): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        val sourceId = args["sourceId"] as String
        val featureId = args["featureId"] as String
        val sourceLayerId = args["sourceLayerId"] as String?
        val stateKey = args["stateKey"] as String?

        mapboxMap.removeFeatureState(
            sourceId = sourceId,
            sourceLayerId = sourceLayerId,
            featureId = featureId,
            stateKey = stateKey
        )
        return ExpectedFactory.createNone()
    }

    /**
     * Method to get the state map of a feature within a style source.
     */
    override fun getFeatureState(
        args: Map<*, *>,
        callback: QueryFeatureStateCallback
    ) {
        if (!mapboxMap.isValid()) {
            callback.run(ExpectedFactory.createError("Invalid MapboxMap!"))
            return
        }

        val sourceId = args["sourceId"] as String
        val featureId = args["featureId"] as String
        val sourceLayerId = args["sourceLayerId"] as String?

        mapboxMap.getFeatureState(
            sourceId = sourceId,
            featureId = featureId,
            sourceLayerId = sourceLayerId,
            callback = callback
        )
    }

    /**
     * Method to get the coordinate as per given pixel
     */
    override fun coordinateForPixel(args: Map<*, *>): Expected<String, Point> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            val screenCoordinate = ScreenCoordinateHelper.fromArgs(args)
            if (screenCoordinate != null) {
                val point = mapboxMap.coordinateForPixel(screenCoordinate)
                ExpectedFactory.createValue(point)
            } else {
                ExpectedFactory.createError("Invalid Screen Coordinate")
            }
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to get the list of coordinates for given pixels
     */
    override fun coordinatesForPixels(args: List<*>): Expected<String, List<*>> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            val screenCoordinates =
                args.map { ScreenCoordinateHelper.fromArgs(it as Map<*, *>) }.mapNotNull { it }
                    .toList()

            val points = mapboxMap.coordinatesForPixels(screenCoordinates)

            ExpectedFactory.createValue(points.map { it.toJson() }.toList())
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to get the screen pixel for the given coordinate
     */
    override fun pixelForCoordinate(args: Map<*, *>): Expected<String, ScreenCoordinate> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            val point = PointHelper.fromArgs(args)

            if (point != null) {
                val coordinate = mapboxMap.pixelForCoordinate(point)
                ExpectedFactory.createValue(coordinate)
            } else {
                ExpectedFactory.createError("Invalid Point")
            }
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to get the list of screen pixel for given coordinates
     */
    override fun pixelsForCoordinates(args: List<*>): Expected<String, List<*>> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            val points =
                args.map { PointHelper.fromArgs(it as Map<*, *>) }.mapNotNull { it }.toList()

            val coordinates = mapboxMap.pixelsForCoordinates(points)

            ExpectedFactory.createValue(coordinates.map { mapOf("x" to it.x, "y" to it.y) }
                .toList())
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to get the size of the rendered map in pixels
     */
    override fun getMapSize(): Expected<String, Size> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            val size = mapboxMap.getSize()
            ExpectedFactory.createValue(size)
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }

    }

    /**
     * Method to set the view port mode of the rendered map
     */
    override fun setViewportMode(mode: String): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            mapboxMap.setViewportMode(viewportMode = ViewportMode.valueOf(mode.uppercase()))
            ExpectedFactory.createNone()
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }
    }

    /**
     * Method to set camera of the map]
     */
    override fun setCamera(args: Map<*, *>): Expected<String, None> {
        if (!mapboxMap.isValid()) return ExpectedFactory.createError("Invalid MapboxMap!")

        return try {
            val cameraOptions = CameraPosition.fromArgs(args).toCameraOptions()
            mapboxMap.setCamera(cameraOptions = cameraOptions)
            ExpectedFactory.createNone()
        } catch (e: Exception) {
            ExpectedFactory.createError(e.message ?: "")
        }

    }

    /**
     * Method to create circle annotation as per the given args
     */
    override fun createCircleAnnotation(args: Map<*, *>): Expected<String, Long> {
        if (!args.containsKey("annotationOptions")) {
            return ExpectedFactory.createError(
                "Annotation Options not provided!"
            )
        }

        return try {
            val circleAnnotationOptions =
                CircleAnnotationOptionsHelper.fromArgs(args["annotationOptions"] as Map<*, *>)

            val annotation = circleAnnotationManager.create(option = circleAnnotationOptions)
            ExpectedFactory.createValue(annotation.id)
        } catch (err: Exception) {
            ExpectedFactory.createError(
                err.message ?: "Error occurred while creating circle annotation"
            )
        }
    }

    /**
     * Method to create point annotation as per the given args
     */
    override fun createPointAnnotation(args: Map<*, *>): Expected<String, Long> {
        if (!args.containsKey("annotationOptions")) {
            return ExpectedFactory.createError(
                "Annotation Options not provided!"
            )
        }

        return try {
            val pointAnnotationOptions =
                PointAnnotationOptionsHelper.fromArgs(args)

            val annotation = pointAnnotationManager.create(option = pointAnnotationOptions)
            ExpectedFactory.createValue(annotation.id)
        } catch (err: Exception) {
            ExpectedFactory.createError(
                err.message ?: "Error occurred while creating point annotation"
            )
        }
    }

    /**
     * Method to create polygon annotation as per the given args
     */
    override fun createPolygonAnnotation(args: Map<*, *>): Expected<String, Long> {
        if (!args.containsKey("annotationOptions")) {
            return ExpectedFactory.createError(
                "Annotation Options not provided!"
            )
        }

        return try {
            val polygonAnnotationOptions =
                PolygonAnnotationOptionsHelper.fromArgs(args["annotationOptions"] as Map<*, *>)

            val annotation = polygonAnnotationManager.create(option = polygonAnnotationOptions)
            ExpectedFactory.createValue(annotation.id)
        } catch (err: Exception) {
            ExpectedFactory.createError(
                err.message ?: "Error occurred while creating polygon annotation"
            )
        }
    }

    /**
     * Method to create polyline annotation as per the given args
     */
    override fun createPolylineAnnotation(args: Map<*, *>): Expected<String, Long> {
        if (!args.containsKey("annotationOptions")) {
            return ExpectedFactory.createError(
                "Annotation Options not provided!"
            )
        }

        return try {
            val polylineAnnotationOptions =
                PolylineAnnotationOptionsHelper.fromArgs(args["annotationOptions"] as Map<*, *>)

            val annotation = polylineAnnotationManager.create(option = polylineAnnotationOptions)
            ExpectedFactory.createValue(annotation.id)
        } catch (err: Exception) {
            ExpectedFactory.createError(
                err.message ?: "Error occurred while creating polyline annotation"
            )
        }
    }

    /**
     * Method to add map related listeners
     */
    override fun addMapRelatedListeners() {
        if (!mapboxMap.isValid()) return

        /**
         * On Map Loaded Listener
         */
        mapboxMap.addOnMapLoadedListener(mapLoadedListener)

        /**
         * On Map Load Error Listener
         */
        mapboxMap.addOnMapLoadErrorListener(mapLoadErrorListener)

        /**
         * On Style Loaded Listener
         */
        mapboxMap.addOnStyleLoadedListener(styleLoadedListener)

        /**
         * On Map Idle Listener
         */
        mapboxMap.addOnMapIdleListener(mapIdleListener)

        /**
         * On Camera Change Listener
         */
        mapboxMap.addOnCameraChangeListener(cameraChangeListener)

        /**
         * On Source Added Listener
         */
        mapboxMap.addOnSourceAddedListener(sourceAddedListener)

        /**
         * On Source Data Loaded Listener
         */
        mapboxMap.addOnSourceDataLoadedListener(sourceDataLoadedListener)

        /**
         * On Source Removed Listener
         */
        mapboxMap.addOnSourceRemovedListener(sourceRemovedListener)

        /**
         * On Render Frame Started Listener
         */
        mapboxMap.addOnRenderFrameStartedListener(renderFrameStartedListener)

        /**
         * On Render Frame Finished Listener
         */
        mapboxMap.addOnRenderFrameFinishedListener(renderFrameFinishedListener)

        /**
         * On Map Click Listener
         */
        mapboxMap.addOnMapClickListener(mapClickListener)

        /**
         * On Map Long Click listener
         */
        mapboxMap.addOnMapLongClickListener(mapLongClickListener)

        /**
         * On Circle Annotation Click Click listener
         */
        circleAnnotationManager.addClickListener(circleAnnotationClickListener)

        /**
         * On Point Annotation Click Click listener
         */
        pointAnnotationManager.addClickListener(pointAnnotationClickListener)

        /**
         * On Polyline Annotation Click Click listener
         */
        polylineAnnotationManager.addClickListener(polylineAnnotationClickListener)

        /**
         * On Polygon Annotation Click listener
         */
        polygonAnnotationManager.addClickListener(polygonAnnotationClickListener)

        /**
         * On Circle Annotation Long Click listener
         */
        circleAnnotationManager.addLongClickListener(circleAnnotationLongClickListener)

        /**
         * On Point Annotation Long Click listener
         */
        pointAnnotationManager.addLongClickListener(pointAnnotationLongClickListener)

        /**
         * On Polyline Annotation Long Click listener
         */
        polylineAnnotationManager.addLongClickListener(polylineAnnotationLongClickListener)

        /**
         * On Polygon Annotation Long Click listener
         */
        polygonAnnotationManager.addLongClickListener(polygonAnnotationLongClickListener)

        /**
         * On Circle Annotation Drag listener
         */
        circleAnnotationManager.addDragListener(circleAnnotationDragListener)

        /**
         * On Point Annotation Drag listener
         */
        pointAnnotationManager.addDragListener(pointAnnotationDragListener)

        /**
         * On Polyline Annotation Drag listener
         */
        polylineAnnotationManager.addDragListener(polylineAnnotationDragListener)

        /**
         * On Polygon Annotation Drag listener
         */
        polygonAnnotationManager.addDragListener(polygonAnnotationDragListener)

    }

    /**
     * Method to remove all the added listeners
     */
    override fun removeAllListeners() {
        if (!mapboxMap.isValid()) return

        /**
         * Removed OnMapLoaded Listener
         */
        mapboxMap.removeOnMapLoadedListener(mapLoadedListener)

        /**
         * Removed OnMapLoad Error Listener
         */
        mapboxMap.removeOnMapLoadErrorListener(mapLoadErrorListener)

        /**
         * Removed OnStyleLoaded Listener
         */
        mapboxMap.removeOnStyleLoadedListener(styleLoadedListener)

        /**
         * Removed OnMapIdle Listener
         */
        mapboxMap.removeOnMapIdleListener(mapIdleListener)

        /**
         * Removed OnCameraChange Listener
         */
        mapboxMap.removeOnCameraChangeListener(cameraChangeListener)

        /**
         * Removed OnSourceAdded Listener
         */
        mapboxMap.removeOnSourceAddedListener(sourceAddedListener)

        /**
         * Removed OnSourceData Loaded Listener
         */
        mapboxMap.removeOnSourceDataLoadedListener(sourceDataLoadedListener)

        /**
         * Removed OnSourceRemoved Listener
         */
        mapboxMap.removeOnSourceRemovedListener(sourceRemovedListener)

        /**
         * Remove OnRenderFrameStarted Listener
         */
        mapboxMap.removeOnRenderFrameStartedListener(renderFrameStartedListener)

        /**
         * Remove OnRenderFrameFinished Listener
         */
        mapboxMap.removeOnRenderFrameFinishedListener(renderFrameFinishedListener)

        /**
         * Removed OnMapClick Listener
         */
        mapboxMap.removeOnMapClickListener(mapClickListener)

        /**
         * Removed OnMapLong Click listener
         */
        mapboxMap.removeOnMapLongClickListener(mapLongClickListener)

        /**
         * Removed Circle Annotation Click listener
         */
        circleAnnotationManager.removeClickListener(circleAnnotationClickListener)

        /**
         * Removed Point Annotation Click listener
         */
        pointAnnotationManager.removeClickListener(pointAnnotationClickListener)

        /**
         * Removed Polyline Annotation Click listener
         */
        polylineAnnotationManager.removeClickListener(polylineAnnotationClickListener)

        /**
         * Removed Polygon Annotation Click listener
         */
        polygonAnnotationManager.removeClickListener(polygonAnnotationClickListener)

        /**
         * Removed Circle Annotation Long Click listener
         */
        circleAnnotationManager.removeLongClickListener(circleAnnotationLongClickListener)

        /**
         * Removed Point Annotation Long Click listener
         */
        pointAnnotationManager.removeLongClickListener(pointAnnotationLongClickListener)

        /**
         * Removed Polyline Annotation Long Click listener
         */
        polylineAnnotationManager.removeLongClickListener(polylineAnnotationLongClickListener)

        /**
         * Removed Polygon Annotation Long Click listener
         */
        polygonAnnotationManager.removeLongClickListener(polygonAnnotationLongClickListener)

        /**
         * Removed Circle Annotation Drag listener
         */
        circleAnnotationManager.removeDragListener(circleAnnotationDragListener)

        /**
         * Removed Point Annotation Drag listener
         */
        pointAnnotationManager.removeDragListener(pointAnnotationDragListener)

        /**
         * Removed Polyline Annotation Drag listener
         */
        polylineAnnotationManager.removeDragListener(polylineAnnotationDragListener)

        /**
         * Removed Polygon Annotation Drag listener
         */
        polygonAnnotationManager.removeDragListener(polygonAnnotationDragListener)
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
     * Method to remove circle annotations if any
     */
    override fun removeCircleAnnotationsIfAny(args: Map<*, *>): Expected<String, None> {
        return try {

            val removeAll =
                if (args.containsKey("all") && args["all"] is Boolean) args["all"] as Boolean else false

            if (removeAll) {
                circleAnnotationManager.deleteAll()
            } else {

                val ids = mutableListOf<Long>()

                if (args.containsKey("ids") && args["ids"] is List<*>) {
                    val temp =
                        (args["ids"] as List<*>).mapNotNull { id -> if (id is Int) id.toLong() else if (id is Long) id else null }
                    ids.addAll(temp)
                }

                val annotations = circleAnnotationManager.annotations.filter { ids.contains(it.id) }

                if (annotations.isNotEmpty()) {
                    circleAnnotationManager.delete(annotations)
                }
            }

            ExpectedFactory.createNone()
        } catch (err: Exception) {
            ExpectedFactory.createError("Error occurred while removing circle annotations!")
        }
    }

    /**
     * Method to remove point annotations if any
     */
    override fun removePointAnnotationsIfAny(args: Map<*, *>): Expected<String, None> {
        return try {

            val removeAll =
                if (args.containsKey("all") && args["all"] is Boolean) args["all"] as Boolean else false

            if (removeAll) {
                pointAnnotationManager.deleteAll()
            } else {

                val ids = mutableListOf<Long>()

                if (args.containsKey("ids") && args["ids"] is List<*>) {
                    val temp =
                        (args["ids"] as List<*>).mapNotNull { id -> if (id is Int) id.toLong() else if (id is Long) id else null }
                    ids.addAll(temp)
                }

                val annotations = pointAnnotationManager.annotations.filter { ids.contains(it.id) }

                if (annotations.isNotEmpty()) {
                    pointAnnotationManager.delete(annotations)
                }
            }
            ExpectedFactory.createNone()
        } catch (err: Exception) {
            ExpectedFactory.createError("Error occurred while removing point annotations!")
        }
    }

    /**
     * Method to remove polygon annotations if any
     */
    override fun removePolygonAnnotationsIfAny(args: Map<*, *>): Expected<String, None> {
        return try {

            val removeAll =
                if (args.containsKey("all") && args["all"] is Boolean) args["all"] as Boolean else false

            if (removeAll) {
                polygonAnnotationManager.deleteAll()
            } else {

                val ids = mutableListOf<Long>()

                if (args.containsKey("ids") && args["ids"] is List<*>) {
                    val temp =
                        (args["ids"] as List<*>).mapNotNull { id -> if (id is Int) id.toLong() else if (id is Long) id else null }
                    ids.addAll(temp)
                }

                val annotations =
                    polygonAnnotationManager.annotations.filter { ids.contains(it.id) }

                if (annotations.isNotEmpty()) {
                    polygonAnnotationManager.delete(annotations)
                }
            }
            ExpectedFactory.createNone()
        } catch (err: Exception) {
            ExpectedFactory.createError("Error occurred while removing polygon annotations!")
        }
    }

    /**
     * Method to remove polyline annotations if any
     */
    override fun removePolylineAnnotationsIfAny(args: Map<*, *>): Expected<String, None> {
        return try {

            val removeAll =
                if (args.containsKey("all") && args["all"] is Boolean) args["all"] as Boolean else false

            if (removeAll) {
                polylineAnnotationManager.deleteAll()
            } else {

                val ids = mutableListOf<Long>()

                if (args.containsKey("ids") && args["ids"] is List<*>) {
                    val temp =
                        (args["ids"] as List<*>).mapNotNull { id -> if (id is Int) id.toLong() else if (id is Long) id else null }
                    ids.addAll(temp)
                }

                val annotations =
                    polylineAnnotationManager.annotations.filter { ids.contains(it.id) }

                if (annotations.isNotEmpty()) {
                    polylineAnnotationManager.delete(annotations)
                }
            }
            ExpectedFactory.createNone()
        } catch (err: Exception) {
            ExpectedFactory.createError("Error occurred while removing polyline annotations!")
        }
    }

    /**
     * Method to remove all annotations
     */
    override fun removeAllAnnotationsIfAny(): Expected<String, None> {
        return try {
            circleAnnotationManager.deleteAll()
            pointAnnotationManager.deleteAll()
            polygonAnnotationManager.deleteAll()
            polylineAnnotationManager.deleteAll()
            ExpectedFactory.createNone()
        } catch (err: Exception) {
            ExpectedFactory.createError("Error occurred while removing all annotations!")
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
            Methods.loadStyleUri -> {
                args = args as String
                loadStyleUri(args)
                result.success(null)
            }
            Methods.isSourceExist -> {
                val sourceId = args as String
                val isExist = style?.styleSourceExists(sourceId) ?: false
                result.success(isExist)
            }
            Methods.isLayerExist -> {
                val layerId = args as String
                val isExist = style?.styleLayerExists(layerId) ?: false
                result.success(isExist)
            }
            Methods.isStyleImageExist -> {
                val imageId = args as String
                val isExist = style?.hasStyleImage(imageId) ?: false
                result.success(isExist)
            }
            Methods.isStyleModelExist -> {
                val modelId = args as String
                val isExist = hasStyleModel(modelId)
                result.success(isExist)
            }
            Methods.toggleStyle -> {
                args = args as List<*>
                val selectedStyle = toggleStyle(args)
                result.success(selectedStyle)
            }
            Methods.animateCameraPosition -> {
                val cameraPosition: CameraPosition = CameraPosition
                    .fromArgs(args as Map<*, *>)
                animateCameraPosition(cameraPosition)
                result.success(true)
            }
            Methods.addGeoJsonSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addGeoJsonSource(
                    sourceId = sourceId,
                    block = GeoJsonSourceHelper.blockFromArgs(args)
                )
                result.success(true)
            }
            Methods.addVectorSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addVectorSource(
                    sourceId = sourceId,
                    block = VectorSourceHelper.blockFromArgs(args)
                )
                result.success(true)
            }
            Methods.addRasterSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addRasterSource(
                    sourceId = sourceId,
                    block = RasterSourceHelper.blockFromArgs(args)
                )
                result.success(true)
            }
            Methods.addRasterDemSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addRasterDemSource(
                    sourceId = sourceId,
                    block = RasterDemSourceHelper.blockFromArgs(args)
                )
                result.success(true)
            }
            Methods.addImageSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addImageSource(
                    sourceId = sourceId,
                    block = ImageSourceHelper.blockFromArgs(args)
                )
                result.success(true)
            }
            Methods.addVideoSource -> {
                args = args as Map<*, *>
                val sourceId = args["sourceId"] as String
                addImageSource(
                    sourceId = sourceId,
                    block = VideoSourceHelper.blockFromArgs(args)
                )
                result.success(true)
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
                result.success(true)
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
                result.success(true)
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
                result.success(true)
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
                result.success(true)
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
                result.success(true)
            }
            Methods.addSkyLayer -> {
                args = args as Map<*, *>
                val layerId = args["layerId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>
                addSkyLayer(
                    layerId = layerId,
                    block = SkyLayerHelper.blockFromArgs(layerProperties)
                )
                result.success(true)
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
                result.success(true)
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
                result.success(true)
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
                result.success(true)
            }
            Methods.addBackgroundLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addBackgroundLayer(
                    layerId = layerId,
                    block = BackgroundLayerHelper.blockFromArgs(layerProperties)
                )
                result.success(true)
            }
            Methods.addLocationIndicatorLayer -> {
                args = args as Map<*, *>

                val layerId = args["layerId"] as String
                val layerProperties = args["layerProperties"] as Map<*, *>

                addLocationIndicatorLayer(
                    layerId = layerId,
                    block = LocationIndicatorLayerHelper.blockFromArgs(layerProperties)
                )
                result.success(true)
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
            Methods.removeStyleModel -> {
                val modelId = args as String
                removeStyleModel(modelId)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.setStyleSourceProperty -> {
                args = args as Map<*, *>
                setStyleSourceProperty(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.setStyleSourceProperties -> {
                args = args as Map<*, *>
                setStyleSourceProperties(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.setStyleLayerProperty -> {
                args = args as Map<*, *>
                setStyleLayerProperty(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.setStyleLayerProperties -> {
                args = args as Map<*, *>
                setStyleLayerProperties(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.moveStyleLayerAbove -> {
                args = args as Map<*, *>
                moveStyleLayerAbove(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.moveStyleLayerBelow -> {
                args = args as Map<*, *>
                moveStyleLayerBelow(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.moveStyleLayerAt -> {
                args = args as Map<*, *>
                moveStyleLayerAt(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.querySourceFeatures -> {
                args = args as Map<*, *>
                querySourceFeatures(args) {
                    it
                        .onValue { list ->
                            val queriedFeatureResult = list.map { qf ->
                                mapOf(
                                    "source" to qf.source,
                                    "sourceLayer" to qf.sourceLayer,
                                    "feature" to qf.feature.toJson(),
                                    "state" to qf.state.toJson()
                                )
                            }
                            result.success(queriedFeatureResult)
                        }
                        .onError { err ->
                            result.error("QUERY_SOURCE_FEATURES_ERROR", err, null)
                        }
                }

            }
            Methods.queryRenderedFeatures -> {
                args = args as Map<*, *>
                queryRenderedFeatures(args) {
                    it
                        .onValue { list ->
                            val queriedFeatureResult = list.map { qf ->
                                mapOf(
                                    "source" to qf.source,
                                    "sourceLayer" to qf.sourceLayer,
                                    "feature" to qf.feature.toJson(),
                                    "state" to qf.state.toJson()
                                )
                            }
                            result.success(queriedFeatureResult)
                        }
                        .onError { err ->
                            result.error("QUERY_RENDERED_FEATURES_ERROR", err, null)
                        }
                }

            }
            Methods.getGeoJsonClusterChildren -> {
                args = args as Map<*, *>
                getGeoJsonClusterChildren(args) {
                    it
                        .onValue { featureExtensionValue ->

                            val features = featureExtensionValue.featureCollection

                            val clusterChildrenAsMap = features?.map { f ->
                                f.toJson()
                            }

                            result.success(clusterChildrenAsMap)
                        }
                        .onError { err ->
                            result.error("GET_GEO_JSON_CLUSTER_CHILDREN_ERROR", err, null)
                        }
                }

            }
            Methods.getGeoJsonClusterLeaves -> {
                args = args as Map<*, *>
                getGeoJsonClusterLeaves(args) {
                    it
                        .onValue { featureExtensionValue ->

                            val features = featureExtensionValue.featureCollection

                            val clusterChildrenAsMap = features?.map { f ->
                                f.toJson()
                            }

                            result.success(clusterChildrenAsMap)
                        }
                        .onError { err ->
                            result.error("GET_GEO_JSON_CLUSTER_LEAVES_ERROR", err, null)
                        }
                }

            }
            Methods.setFeatureState -> {
                args = args as Map<*, *>

                setFeatureState(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.removeFeatureState -> {
                args = args as Map<*, *>
                removeFeatureState(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.success(false)
                    }

            }
            Methods.getFeatureState -> {
                args = args as Map<*, *>
                getFeatureState(args) {
                    it.onValue { value ->
                        result.success(value.toJson())
                    }
                    it.onError {
                        result.success(null)
                    }
                }

            }
            Methods.loadStyleJson -> {
                args = args as String
                loadStyleJson(args)
                    .onValue {
                        result.success(null)
                    }
                    .onError {
                        result.error("STYLE_LOAD_ERROR", it, null)
                    }

            }
            Methods.reduceMemoryUse -> {
                reduceMemoryUse()
                    .onValue {
                        result.success(null)
                    }
                    .onError {
                        result.error("REDUCE_MEMORY_USE_ERROR", it, null)
                    }

            }
            Methods.triggerRepaint -> {
                triggerRepaint()
                    .onValue {
                        result.success(null)
                    }
                    .onError {
                        result.error("TRIGGER_REPAINT_ERROR", it, null)
                    }

            }
            Methods.setMapMemoryBudget -> {
                args = args as Map<*, *>
                setMapMemoryBudget(args)
                    .onValue {
                        result.success(null)
                    }
                    .onError {
                        result.error("SET_MEMORY_BUDGET_ERROR", it, null)
                    }

            }
            Methods.coordinateForPixel -> {
                args = args as Map<*, *>
                coordinateForPixel(args)
                    .onValue {
                        result.success(it.toJson())
                    }
                    .onError {
                        result.error("COORDINATE_4_PIXEL_ERROR", it, null)
                    }

            }
            Methods.coordinatesForPixels -> {
                args = args as List<*>
                coordinatesForPixels(args)
                    .onValue {
                        result.success(it)
                    }
                    .onError {
                        result.error("COORDINATES_4_PIXELS_ERROR", it, null)
                    }

            }
            Methods.pixelForCoordinate -> {
                args = args as Map<*, *>
                pixelForCoordinate(args)
                    .onValue {
                        result.success(mapOf("x" to it.x, "y" to it.y))
                    }
                    .onError {
                        result.error("PIXEL_4_COORDINATE_ERROR", it, null)
                    }

            }
            Methods.pixelsForCoordinates -> {
                args = args as List<*>
                pixelsForCoordinates(args)
                    .onValue {
                        result.success(it)
                    }
                    .onError {
                        result.error("PIXELS_4_COORDINATES_ERROR", it, null)
                    }

            }
            Methods.getMapSize -> {
                getMapSize()
                    .onValue {
                        result.success(mapOf("width" to it.width, "height" to it.height))
                    }
                    .onError {
                        result.error("GET_SIZE_ERROR", it, null)
                    }

            }
            Methods.setCamera -> {
                args = args as Map<*, *>
                setCamera(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("SET_CAMERA_ERROR", it, null)
                    }

            }
            Methods.setViewportMode -> {
                args = args as String
                setViewportMode(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("SET_VIEW_PORT_MODE_ERROR", it, null)
                    }

            }
            Methods.createCircleAnnotation -> {
                args = args as Map<*, *>
                createCircleAnnotation(args)
                    .onValue {
                        result.success(it)
                    }
                    .onError {
                        result.error("CREATE_CIRCLE_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.createPointAnnotation -> {
                args = args as Map<*, *>
                Log.d(TAG, "onMethodCall: $args")
                createPointAnnotation(args)
                    .onValue {
                        result.success(it)
                    }
                    .onError {
                        result.error("CREATE_POINT_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.createPolygonAnnotation -> {
                args = args as Map<*, *>
                createPolygonAnnotation(args)
                    .onValue {
                        result.success(it)
                    }
                    .onError {
                        result.error("CREATE_POLYGON_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.createPolylineAnnotation -> {
                args = args as Map<*, *>
                createPolylineAnnotation(args)
                    .onValue {
                        result.success(it)
                    }
                    .onError {
                        result.error("CREATE_POLYLINE_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.removeCircleAnnotation -> {
                args = args as Map<*, *>
                removeCircleAnnotationsIfAny(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("REMOVE_CIRCLE_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.removePointAnnotation -> {
                args = args as Map<*, *>
                removePointAnnotationsIfAny(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("REMOVE_POINT_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.removePolygonAnnotation -> {
                args = args as Map<*, *>
                removePolygonAnnotationsIfAny(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("REMOVE_POLYGON_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.removePolylineAnnotation -> {
                args = args as Map<*, *>
                removePolylineAnnotationsIfAny(args)
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("REMOVE_POLYLINE_ANNOTATION_ERROR", it, null)
                    }

            }
            Methods.removeAllAnnotations -> {
                removeAllAnnotationsIfAny()
                    .onValue {
                        result.success(true)
                    }
                    .onError {
                        result.error("REMOVE_ALL_ANNOTATIONS_ERROR", it, null)
                    }

            }
            else -> {
                Log.d(TAG, "onMethodCall: NOT Implemented")
                result.notImplemented()
            }
        }

    }
}