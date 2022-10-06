package com.itheamc.mapbox_map_gl

import android.content.Context
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.ViewTreeLifecycleOwner
import com.mapbox.maps.MapInitOptions
import com.mapbox.maps.MapView
import com.mapbox.maps.plugin.compass.compass
import com.mapbox.maps.plugin.scalebar.scalebar
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

/**
 * MapboxMapGlNativeView.kt
 *
 * Created by Amit Chaudhary, 2022/10/3
 */
internal class MapboxMapGlNativeView(
    context: Context,
    private val id: Int,
    private val creationParams: Map<*, *>?,
    private val messenger: BinaryMessenger,
    private val lifecycleOwnerProvider: MapboxMapGlPlugin.MapboxLLifecycleOwnerProvider,
) : PlatformView, DefaultLifecycleObserver {


    /**
     * Map View
     */
    private var mapView: MapView?


    /**
     * Initializing the views and adding lifecycle observer
     */
    init {

        /**
         * Adding lifecycle observer for the map view
         */
        lifecycleOwnerProvider
            .lifecycleOwner?.lifecycle?.addObserver(this)

        mapView = MapView(
            context = context,
            mapInitOptions = MapInitOptions(
                context = context
            )
        ).apply {
            scalebar.enabled = false
            compass.enabled = false
            id = this@MapboxMapGlNativeView.id
        }.also {
            MapboxMapGlController(
                messenger = messenger,
                mapboxMap = it.getMapboxMap(),
                creationParams = creationParams
            )
        }

        /**
         * Setting lifecycle owner to the map view
         */
        mapView?.let {
            ViewTreeLifecycleOwner.set(it, lifecycleOwnerProvider.lifecycleOwner)
        }
    }


    /**
     * Method to get the view
     */
    override fun getView(): View? {
        return mapView
    }


    /**
     * On Dispose of Platform View
     */
    override fun dispose() {
        /**
         * Removing listener attached with the mapview on dispose
         */
        lifecycleOwnerProvider
            .lifecycleOwner?.lifecycle?.removeObserver(this)
    }
}