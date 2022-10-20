package com.itheamc.mapbox_map_gl

import com.itheamc.mapbox_map_gl.utils.CameraPosition
import com.mapbox.bindgen.Expected
import com.mapbox.bindgen.None
import com.mapbox.maps.QueryFeatureStateCallback
import com.mapbox.maps.QueryFeaturesCallback
import com.mapbox.maps.extension.style.layers.generated.*
import com.mapbox.maps.extension.style.sources.generated.*
import io.flutter.plugin.common.MethodChannel

internal interface MapboxMapGlController : MethodChannel.MethodCallHandler {

    /**
     * Method to load the style uri
     */
    fun loadStyleUri()

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
     * Method to add map related listeners
     */
    fun addMapRelatedListeners()

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
}