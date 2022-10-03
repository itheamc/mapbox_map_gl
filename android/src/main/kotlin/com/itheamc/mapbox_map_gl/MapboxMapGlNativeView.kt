package com.itheamc.mapbox_map_gl

import android.content.Context
import android.util.Log
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.ViewTreeLifecycleOwner
import com.itheamc.mapbox_map_gl.utility.CameraPosition
import com.mapbox.maps.*
import com.mapbox.maps.extension.observable.eventdata.MapLoadingErrorEventData
import com.mapbox.maps.plugin.animation.flyTo
import com.mapbox.maps.plugin.delegates.listeners.OnMapLoadErrorListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

private const val TAG = "MapboxMapGlNativeView"

internal class MapboxMapGlNativeView(
    private val context: Context,
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
        Log.d(TAG, ": $creationParams")

        lifecycleOwnerProvider.lifecycleOwner?.lifecycle?.addObserver(this)

        mapView = MapView(
            context = context,
            mapInitOptions = MapInitOptions(
                context = context
            )
        ).also {
            it.getMapboxMap().loadStyleUri(
                Style.LIGHT,
                styleTransitionOptions = TransitionOptions.Builder()
                    .duration(500L)
                    .delay(0)
                    .enablePlacementTransitions(false)
                    .build(),
                onStyleLoaded = { sty ->
                    Log.d(TAG, "onStyleLoadedListener: Loaded ${sty.styleLayers.size}")
                },
                onMapLoadErrorListener = object : OnMapLoadErrorListener {
                    override fun onMapLoadError(eventData: MapLoadingErrorEventData) {
                        Log.d(TAG, "onMapLoadError: ${eventData.message}")
                    }
                }
            )
        }.also {
            val hasInitialCameraPosition =
                creationParams?.containsKey("initialCameraPosition") ?: false
            val initialCameraPosition = creationParams?.get("initialCameraPosition")

            if (hasInitialCameraPosition && initialCameraPosition != null) {
                val cameraPosition: CameraPosition =
                    CameraPosition.fromMap(initialCameraPosition as Map<*, *>)

                it.getMapboxMap().flyTo(
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
        }

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
        lifecycleOwnerProvider.lifecycleOwner?.lifecycle?.removeObserver(this)
    }
}