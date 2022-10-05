package com.itheamc.mapbox_map_gl

import androidx.lifecycle.LifecycleOwner
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.lifecycle.HiddenLifecycleReference
import io.flutter.plugin.common.MethodChannel


/** MapboxMapGlPlugin */
internal class MapboxMapGlPlugin : FlutterPlugin, ActivityAware {
    private lateinit var channel: MethodChannel
    private var lifecycleOwner: LifecycleOwner? = null

    companion object {
        const val VIEW_TYPE_ID = "com.itheamc.mapbox_map_gl/view_type_id"
        const val METHOD_CHANNEL_NAME = "com.itheamc.mapbox_map_gl/method_channel"
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL_NAME)

        flutterPluginBinding
            .platformViewRegistry
            .registerViewFactory(
                VIEW_TYPE_ID,
                MapboxMapGlNativeViewFactory(
                    messenger = flutterPluginBinding.binaryMessenger,
                    lifecycleOwnerProvider = MapboxLLifecycleOwnerProvider(),
                )
            )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * Override from ActivityAware
     */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val reference = binding.lifecycle as HiddenLifecycleReference
        lifecycleOwner = LifecycleOwner {
            reference.lifecycle
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivity() {
        lifecycleOwner = null
    }

    /**
     * Inner Provider class for providing lifecycle owner for map view
     */
    inner class MapboxLLifecycleOwnerProvider {
        val lifecycleOwner: LifecycleOwner?
            get() = this@MapboxMapGlPlugin.lifecycleOwner
    }
}
