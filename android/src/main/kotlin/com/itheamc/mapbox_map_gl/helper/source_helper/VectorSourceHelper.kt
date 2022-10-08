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
                val value = sourceProperties["url"] as String
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
            if (sourceProperties.containsKey("minZoom") && sourceProperties["minZoom"] is Int) {
                val value = sourceProperties["minZoom"] as Int
                minzoom(value.toLong())
            }

            // set maxZoom
            if (sourceProperties.containsKey("maxZoom") && sourceProperties["maxZoom"] is Int) {
                val value = sourceProperties["maxZoom"] as Int
                maxzoom(value.toLong())
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
            if (sourceProperties.containsKey("prefetchZoomDelta") && sourceProperties["prefetchZoomDelta"] is Int) {
                val value = sourceProperties["prefetchZoomDelta"] as Int
                prefetchZoomDelta(value.toLong())
            }

            // set minimumTileUpdateInterval
            if (sourceProperties.containsKey("minimumTileUpdateInterval") && sourceProperties["minimumTileUpdateInterval"] is Double) {
                val value = sourceProperties["minimumTileUpdateInterval"] as Double
                minimumTileUpdateInterval(value)
            }

            // set maxOverScaleFactorForParentTiles
            if (sourceProperties.containsKey("maxOverScaleFactorForParentTiles") && sourceProperties["maxOverScaleFactorForParentTiles"] is Int) {
                val value = sourceProperties["maxOverScaleFactorForParentTiles"] as Int
                maxOverscaleFactorForParentTiles(value.toLong())
            }

            // set tileRequestsDelay
            if (sourceProperties.containsKey("tileRequestsDelay") && sourceProperties["tileRequestsDelay"] is Double) {
                val value = sourceProperties["tileRequestsDelay"] as Double
                tileRequestsDelay(value)
            }

            // set tileNetworkRequestsDelay
            if (sourceProperties.containsKey("tileNetworkRequestsDelay") && sourceProperties["tileNetworkRequestsDelay"] is Double) {
                val value = sourceProperties["tileNetworkRequestsDelay"] as Double
                tileNetworkRequestsDelay(value)
            }
        }
    }
}