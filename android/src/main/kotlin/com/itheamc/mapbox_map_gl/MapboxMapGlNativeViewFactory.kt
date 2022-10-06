package com.itheamc.mapbox_map_gl

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/**
 * MapboxMapGlNativeViewFactory.kt
 *
 * Created by Amit Chaudhary, 2022/10/3
 */
internal class MapboxMapGlNativeViewFactory(
    private val messenger: BinaryMessenger,
    private val lifecycleOwnerProvider: MapboxMapGlPlugin.MapboxLLifecycleOwnerProvider
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<*, *>?
        return MapboxMapGlNativeView(context, viewId, creationParams, messenger, lifecycleOwnerProvider)
    }

}