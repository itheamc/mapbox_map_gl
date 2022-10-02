package com.itheamc.mapbox_map_gl

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import android.view.View
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.mapbox.maps.MapInitOptions
import com.mapbox.maps.MapView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

private const val TAG = "MapboxMapNativeView"

internal class MapboxMapNativeView(
    private val context: Context,
    private val id: Int,
    private val creationParams: Map<*, *>?,
    private val messenger: BinaryMessenger,
    private val lifecycleProvider: MapboxMapGlPlugin.MapboxLifecycleProvider
) : PlatformView, DefaultLifecycleObserver {


    private var mapView: MapView?


    init {
        Log.d(TAG, ": $creationParams")
        lifecycleProvider.lifecycle?.addObserver(this)
        mapView = MapView(
            context = context,
            mapInitOptions = MapInitOptions(context = context)
        ).apply {
            id = this@MapboxMapNativeView.id
        }
    }


    override fun getView(): View? {
        return mapView
    }


    override fun dispose() {
        lifecycleProvider.lifecycle?.removeObserver(this)
        mapView = null
    }


    /**
     * Overrided from MapboxLifecycleObserver
     */
    @SuppressLint("Lifecycle")
    override fun onStart(owner: LifecycleOwner) {
        super.onStart(owner)
        mapView?.onStart()
    }

    @SuppressLint("Lifecycle")
    override fun onStop(owner: LifecycleOwner) {
        super.onStop(owner)
        mapView?.onStop()
    }

    @SuppressLint("Lifecycle")
    override fun onDestroy(owner: LifecycleOwner) {
        owner.lifecycle.removeObserver(this)
        super.onDestroy(owner)
        mapView?.onDestroy()
        mapView = null
    }


}