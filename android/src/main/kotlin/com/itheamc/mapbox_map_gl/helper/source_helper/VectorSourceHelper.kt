package com.itheamc.mapbox_map_gl.helper.source_helper

import com.mapbox.maps.extension.style.sources.generated.Scheme
import com.mapbox.maps.extension.style.sources.generated.VectorSource
import com.mapbox.maps.extension.style.types.PromoteId
import java.util.*


/**
 * VectorSourceHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object VectorSourceHelper {

    /**
     * Method to set properties got from the flutter side to VectorSource block
     */
    fun blockFromArgs(args: Map<*, *>): VectorSource.Builder.() -> Unit {

        val sourceProperties = args["sourceProperties"] as Map<*, *>

        return {

            // set url
            if (args.containsKey("url") && args["url"] is String) {
                val value = args["url"] as String
                url(value)
            }

            // set tiles
            if (args.containsKey("tiles") && args["tiles"] is List<*>) {
                val value = args["tiles"] as List<*>
                tiles(value.map { if (it is String) it else it.toString() })
            }

            // set bounds
            if (sourceProperties.containsKey("bounds") && sourceProperties["bounds"] is List<*>) {
                val value = sourceProperties["bounds"] as List<*>
                if (value.size == 4) {
                    val list = value.map { it as Double }
                    bounds(list)
                }
            }

            // set scheme
            if (sourceProperties.containsKey("scheme") && sourceProperties["scheme"] is String) {
                val value = sourceProperties["scheme"] as String
                scheme(Scheme.valueOf(value.uppercase(Locale.ENGLISH)))
            }

            // set minZoom
            if (sourceProperties.containsKey("minZoom")) {
                when (val value = sourceProperties["minZoom"]) {
                    is Double -> minzoom(value.toLong())
                    is Int -> minzoom(value.toLong())
                    is Long -> minzoom(value)
                }
            }

            // set maxZoom
            if (sourceProperties.containsKey("maxZoom")) {
                when (val value = sourceProperties["maxZoom"]) {
                    is Double -> maxzoom(value.toLong())
                    is Int -> maxzoom(value.toLong())
                    is Long -> maxzoom(value)
                }
            }

            // set attribution
            if (sourceProperties.containsKey("attribution") && sourceProperties["attribution"] is String) {
                val value = sourceProperties["attribution"] as String
                attribution(value)
            }

            // set promoteId
            if (sourceProperties.containsKey("promoteId") && sourceProperties["promoteId"] is Map<*, *>) {
                val value = sourceProperties["promoteId"] as Map<*, *>

                val propertyName = value["propertyName"] as String
                val sourceId = value["sourceId"] as String?

                promoteId(
                    PromoteId(
                        propertyName,
                        sourceId
                    )
                )
            }

            // set volatile
            if (sourceProperties.containsKey("volatile") && sourceProperties["volatile"] is Boolean) {
                val value = sourceProperties["volatile"] as Boolean
                volatile(value)
            }

            // set prefetchZoomDelta
            if (sourceProperties.containsKey("prefetchZoomDelta")) {
                when (val value = sourceProperties["prefetchZoomDelta"]) {
                    is Double -> prefetchZoomDelta(value.toLong())
                    is Int -> prefetchZoomDelta(value.toLong())
                    is Long -> prefetchZoomDelta(value)
                }
            }

            // set minimumTileUpdateInterval
            if (sourceProperties.containsKey("minimumTileUpdateInterval")) {
                when (val value = sourceProperties["minimumTileUpdateInterval"]) {
                    is Double -> minimumTileUpdateInterval(value)
                    is Int -> minimumTileUpdateInterval(value.toDouble())
                    is Long -> minimumTileUpdateInterval(value.toDouble())
                }
            }

            // set maxOverScaleFactorForParentTiles
            if (sourceProperties.containsKey("maxOverScaleFactorForParentTiles")) {
                when (val value = sourceProperties["maxOverScaleFactorForParentTiles"]) {
                    is Double -> maxOverscaleFactorForParentTiles(value.toLong())
                    is Int -> maxOverscaleFactorForParentTiles(value.toLong())
                    is Long -> maxOverscaleFactorForParentTiles(value)
                }
            }

            // set tileRequestsDelay
            if (sourceProperties.containsKey("tileRequestsDelay")) {
                when (val value = sourceProperties["tileRequestsDelay"]) {
                    is Double -> tileRequestsDelay(value)
                    is Int -> tileRequestsDelay(value.toDouble())
                    is Long -> tileRequestsDelay(value.toDouble())
                }
            }

            // set tileNetworkRequestsDelay
            if (sourceProperties.containsKey("tileNetworkRequestsDelay")) {
                when (val value = sourceProperties["tileNetworkRequestsDelay"]) {
                    is Double -> tileNetworkRequestsDelay(value)
                    is Int -> tileNetworkRequestsDelay(value.toDouble())
                    is Long -> tileNetworkRequestsDelay(value.toDouble())
                }
            }
        }
    }
}