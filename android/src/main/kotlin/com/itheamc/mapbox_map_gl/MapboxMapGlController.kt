package com.itheamc.mapbox_map_gl

import com.itheamc.mapbox_map_gl.utils.CameraPosition
import com.mapbox.bindgen.Expected
import com.mapbox.bindgen.None
import com.mapbox.geojson.Point
import com.mapbox.maps.QueryFeatureExtensionCallback
import com.mapbox.maps.QueryFeatureStateCallback
import com.mapbox.maps.QueryFeaturesCallback
import com.mapbox.maps.ScreenCoordinate
import com.mapbox.maps.Size
import com.mapbox.maps.extension.style.layers.generated.*
import com.mapbox.maps.extension.style.sources.generated.*
import io.flutter.plugin.common.MethodChannel

internal interface MapboxMapGlController : MethodChannel.MethodCallHandler {

    /**
     * Method to load the style uri
     */
    fun loadStyleUri(styleUri: String?)

    /**
     * Method to load the style json
     */
    fun loadStyleJson(styleJson: String): Expected<String, None>

    /**
     * Method to reduce memory uses
     */
    fun reduceMemoryUse(): Expected<String, None>

    /**
     * Method to set map memory budget
     */
    fun setMapMemoryBudget(args: Map<*, *>): Expected<String, None>

    /**
     * Method to trigger map repaint
     */
    fun triggerRepaint(): Expected<String, None>

    /**
     * Method to
     */
    fun animateToInitialCameraPosition()

    /**
     * Method to toggle map style
     */
    fun toggleStyle(list: List<*>): String?


    /**
     * Method to animate camera
     */
    fun animateCameraPosition(cameraPosition: CameraPosition)

    /**
     * Method to add geo json sources
     * Remember: If your want to add line layer or fill layer along with the circle layer
     * then you clustering feature will not working. Turning [cluster = true] will throw an error
     */
    fun addGeoJsonSource(
        sourceId: String,
        block: GeoJsonSource.Builder.() -> Unit
    )

    /**
     * Method to add vector sources
     */
    fun addVectorSource(
        sourceId: String,
        block: VectorSource.Builder.() -> Unit
    )

    /**
     * Method to add raster sources
     */
    fun addRasterSource(
        sourceId: String,
        block: RasterSource.Builder.() -> Unit
    )

    /**
     * Method to add raster dem sources
     */
    fun addRasterDemSource(
        sourceId: String,
        block: RasterDemSource.Builder.() -> Unit
    )


    /**
     * Method to add image sources
     */
    fun addImageSource(
        sourceId: String,
        block: ImageSource.Builder.() -> Unit
    )


    /**
     * Method to add style image
     * It is basically used on symbol layer
     */
    fun addStyleImage(args: Map<*, *>)

    /**
     * Method to add line layer
     */
    fun addLineLayer(
        layerId: String,
        sourceId: String,
        block: LineLayerDsl.() -> Unit
    )

    /**
     * Method to add circle layer
     */
    fun addCircleLayer(
        layerId: String,
        sourceId: String,
        block: CircleLayerDsl.() -> Unit
    )

    /**
     * Method to add fill layer
     */
    fun addFillLayer(
        layerId: String,
        sourceId: String,
        block: FillLayerDsl.() -> Unit
    )

    /**
     * Method to add symbol layer
     */
    fun addSymbolLayer(
        layerId: String,
        sourceId: String,
        block: SymbolLayerDsl.() -> Unit
    )

    /**
     * Method to add raster layer
     */
    fun addRasterLayer(
        layerId: String,
        sourceId: String,
        block: RasterLayerDsl.() -> Unit
    )

    /**
     * Method to add hill shade layer
     */
    fun addHillShadeLayer(
        layerId: String,
        sourceId: String,
        block: HillshadeLayerDsl.() -> Unit
    )

    /**
     * Method to add heatmap layer
     */
    fun addHeatmapLayer(
        layerId: String,
        sourceId: String,
        block: HeatmapLayerDsl.() -> Unit
    )

    /**
     * Method to add fill extrusion layer
     */
    fun addFillExtrusionLayer(
        layerId: String,
        sourceId: String,
        block: FillExtrusionLayerDsl.() -> Unit
    )

    /**
     * Method to add location indicator layer
     */
    fun addLocationIndicatorLayer(
        layerId: String,
        block: LocationIndicatorLayerDsl.() -> Unit
    )

    /**
     * Method to add background layer
     */
    fun addSkyLayer(
        layerId: String,
        block: SkyLayerDsl.() -> Unit
    )

    /**
     * Method to add background layer
     */
    fun addBackgroundLayer(
        layerId: String,
        block: BackgroundLayerDsl.() -> Unit
    )

    /**
     * Method to add style model
     */
    fun addStyleModel(modelId: String, modelUri: String): Expected<String, None>

    /**
     * Method to check if style model with particular id is already added or not
     */
    fun hasStyleModel(modelId: String): Boolean

    /**
     * Method to remove style model with particular id if already added
     */
    fun removeStyleModel(modelId: String): Expected<String, None>

    /**
     * Method to set style source property to the already added source with given id
     */
    fun setStyleSourceProperty(args: Map<*, *>): Expected<String, None>

    /**
     * Method to set style source properties to the already added source with given id
     */
    fun setStyleSourceProperties(args: Map<*, *>): Expected<String, None>

    /**
     * Method to set style layer property to the already added layer with given id
     */
    fun setStyleLayerProperty(args: Map<*, *>): Expected<String, None>

    /**
     * Method to set style layer properties to the already added layer with given id
     */
    fun setStyleLayerProperties(args: Map<*, *>): Expected<String, None>

    /**
     * Method to move style layer above given layer
     */
    fun moveStyleLayerAbove(args: Map<*, *>): Expected<String, None>

    /**
     * Method to move style layer below given layer
     */
    fun moveStyleLayerBelow(args: Map<*, *>): Expected<String, None>

    /**
     * Method to move style layer at specific position
     */
    fun moveStyleLayerAt(args: Map<*, *>): Expected<String, None>

    /**
     * Method to query the map for source features.
     */
    fun querySourceFeatures(args: Map<*, *>, queryFeaturesCallback: QueryFeaturesCallback)

    /**
     * Method to query the map for rendered features.
     */
    fun queryRenderedFeatures(args: Map<*, *>, queryFeaturesCallback: QueryFeaturesCallback)

    /**
     * Method to get geo json cluster leaves.
     */
    fun getGeoJsonClusterLeaves(
        args: Map<*, *>,
        queryFeatureExtensionCallback: QueryFeatureExtensionCallback
    )

    /**
     * Method to get geo json cluster children.
     */
    fun getGeoJsonClusterChildren(
        args: Map<*, *>,
        queryFeatureExtensionCallback: QueryFeatureExtensionCallback
    )

    /**
     * Method to update the state map of a feature within a style source.
     */
    fun setFeatureState(args: Map<*, *>): Expected<String, None>

    /**
     * Method to remove entries from a feature state map
     */
    fun removeFeatureState(args: Map<*, *>): Expected<String, None>

    /**
     * Method to get the state map of a feature within a style source.
     */
    fun getFeatureState(
        args: Map<*, *>,
        callback: QueryFeatureStateCallback
    )

    /**
     * Method to get the coordinate as per given pixel
     */
    fun coordinateForPixel(args: Map<*, *>): Expected<String, Point>

    /**
     * Method to get the list of coordinates for given pixels
     */
    fun coordinatesForPixels(args: List<*>): Expected<String, List<*>>

    /**
     * Method to get the screen pixel for the given coordinate
     */
    fun pixelForCoordinate(args: Map<*, *>): Expected<String, ScreenCoordinate>

    /**
     * Method to get the list of screen pixel for given coordinates
     */
    fun pixelsForCoordinates(args: List<*>): Expected<String, List<*>>

    /**
     * Method to get the size of the rendered map in pixels
     */
    fun getMapSize(): Expected<String, Size>

    /**
     * Method to set the view port mode of the rendered map
     */
    fun setViewportMode(mode: String): Expected<String, None>

    /**
     * Method to set camera of the map]
     */
    fun setCamera(args: Map<*, *>): Expected<String, None>

    /**
     * Method to create circle annotation as per the given args
     */
    fun createCircleAnnotation(args: Map<*, *>): Expected<String, Map<*, *>>

    /**
     * Method to create point annotation as per the given args
     */
    fun createPointAnnotation(args: Map<*, *>): Expected<String, Map<*, *>>

    /**
     * Method to create polygon annotation as per the given args
     */
    fun createPolygonAnnotation(args: Map<*, *>): Expected<String, Map<*, *>>

    /**
     * Method to create polyline annotation as per the given args
     */
    fun createPolylineAnnotation(args: Map<*, *>): Expected<String, Map<*, *>>

    /**
     * Method to add map related listeners
     */
    fun addMapRelatedListeners()

    /**
     * Method to remove all map related listeners
     */
    fun removeAllListeners()

    /**
     * Method to get the list of applied layer id on given source
     * params:
     * {sourceId} -> Id of the source
     */
    fun appliedLayers(sourceId: String): List<String>

    /**
     * Method to remove layer if already added
     */
    fun removeLayerIfAny(layerId: String): Expected<String, None>


    /**
     * Method to remove style source if already added
     */
    fun removeStyleSourceIfAny(sourceId: String): Expected<String, None>

    /**
     * Method to remove style image if already added
     */
    fun removeStyleImageIfAny(imageId: String): Expected<String, None>

    /**
     * Method to remove layers
     */
    fun removeLayers(layersId: List<String>): Expected<String, None>

    /**
     * Method to remove circle annotations if any
     */
    fun removeCircleAnnotationsIfAny(args: Map<*, *>): Expected<String, None>

    /**
     * Method to remove point annotations if any
     */
    fun removePointAnnotationsIfAny(args: Map<*, *>): Expected<String, None>

    /**
     * Method to remove polygon annotations if any
     */
    fun removePolygonAnnotationsIfAny(args: Map<*, *>): Expected<String, None>

    /**
     * Method to remove polyline annotations if any
     */
    fun removePolylineAnnotationsIfAny(args: Map<*, *>): Expected<String, None>
}