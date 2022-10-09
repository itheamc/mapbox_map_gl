package com.itheamc.mapbox_map_gl.helper.source_helper

import com.mapbox.maps.extension.style.sources.generated.ImageSource

/**
 * VideoSourceHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object VideoSourceHelper {

    /**
     * Not Supported In Mobile SDK
     * Method to set properties got from the flutter side to VideoSource.Builder block
     */
    fun blockFromArgs(args: Map<*, *>): ImageSource.Builder.() -> Unit {

        val sourceProperties = args["sourceProperties"] as Map<*, *>

        return {

            // Setting Url
            if (args.containsKey("url") && args["url"] is String) {
                url(args["url"] as String)
            }

            // Setting Coordinates
            if (args.containsKey("coordinates") && args["coordinates"] is List<*>) {

                val list = args["coordinates"] as List<*>

                val formatted = list.map { l1 ->
                    (l1 as List<*>).map { l2 ->
                        when (l2) {
                            is Double -> l2
                            is Int -> l2.toDouble()
                            is Long -> l2.toDouble()
                            else -> 0.0
                        }
                    }
                }

                coordinates(formatted)
            }

            // Setting prefetchZoomDelta
            if (sourceProperties.containsKey("prefetchZoomDelta")) {
                when (val zoomDelta = sourceProperties["prefetchZoomDelta"]) {
                    is Double -> prefetchZoomDelta(zoomDelta.toLong())
                    is Int -> prefetchZoomDelta(zoomDelta.toLong())
                    is Long -> prefetchZoomDelta(zoomDelta)
                }
            }
        }
    }
}