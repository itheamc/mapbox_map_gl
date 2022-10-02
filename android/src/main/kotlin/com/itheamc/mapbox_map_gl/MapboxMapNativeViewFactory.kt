package com.itheamc.mapbox_map_gl

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

internal class MapboxMapNativeViewFactory(
    private val messenger: BinaryMessenger,
    private val lifecycleProvider: MapboxMapGlPlugin.MapboxLifecycleProvider
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<*, *>?
        return MapboxMapNativeView(context, viewId, creationParams, messenger, lifecycleProvider)
    }
}