package com.itheamc.mapbox_map_gl

import androidx.lifecycle.Lifecycle
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
        const val VIEW_TYPE = "mapbox_map_gl"
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, VIEW_TYPE)
        channel.setMethodCallHandler(MapboxMethodCallHandler())

        flutterPluginBinding
            .platformViewRegistry
            .registerViewFactory(
                VIEW_TYPE,
                MapboxMapNativeViewFactory(
                    messenger = flutterPluginBinding.binaryMessenger,
                    lifecycleOwnerProvider = MapboxLLifecycleOwnerProvider(),
                )
            )
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * Overrided from ActivityAware
     */
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        lifecycleOwner = LifecycleOwner {
            FlutterLifecycleAdapter.getActivityLifecycle(binding)
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

    inner class MapboxLLifecycleOwnerProvider {
        val lifecycleOwner: LifecycleOwner?
            get() = this@MapboxMapGlPlugin.lifecycleOwner
    }


    object FlutterLifecycleAdapter {
        fun getActivityLifecycle(
            activityPluginBinding: ActivityPluginBinding
        ): Lifecycle {
            val reference = activityPluginBinding.lifecycle as HiddenLifecycleReference
            return reference.lifecycle
        }
    }
}
