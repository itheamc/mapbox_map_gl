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
object VectorSourceHelper {

    /**
     * Method to set properties got from the flutter side to VectorSource block
     */
    fun blockFromArgs(args: Map<*, *>): VectorSource.Builder.() -> Unit {

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
            if (args.containsKey("bounds") && args["bounds"] is List<*>) {
                val value = args["bounds"] as List<*>
                if (value.size == 4) {
                    val list = value.map { it as Double }
                    bounds(list)
                }
            }

            // set scheme
            if (args.containsKey("scheme") && args["scheme"] is String) {
                val value = args["scheme"] as String
                scheme(Scheme.valueOf(value.uppercase(Locale.ENGLISH)))
            }

            // set minZoom
            if (args.containsKey("minZoom") && args["minZoom"] is Int) {
                val value = args["minZoom"] as Int
                minzoom(value.toLong())
            }

            // set maxZoom
            if (args.containsKey("maxZoom") && args["maxZoom"] is Int) {
                val value = args["maxZoom"] as Int
                maxzoom(value.toLong())
            }

            // set attribution
            if (args.containsKey("attribution") && args["attribution"] is String) {
                val value = args["attribution"] as String
                attribution(value)
            }

            // set promoteId
            if (args.containsKey("promoteId") && args["promoteId"] is Map<*, *>) {
                val value = args["promoteId"] as Map<*, *>

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
            if (args.containsKey("volatile") && args["volatile"] is Boolean) {
                val value = args["volatile"] as Boolean
                volatile(value)
            }

            // set prefetchZoomDelta
            if (args.containsKey("prefetchZoomDelta") && args["prefetchZoomDelta"] is Int) {
                val value = args["prefetchZoomDelta"] as Int
                prefetchZoomDelta(value.toLong())
            }

            // set minimumTileUpdateInterval
            if (args.containsKey("minimumTileUpdateInterval") && args["minimumTileUpdateInterval"] is Double) {
                val value = args["minimumTileUpdateInterval"] as Double
                minimumTileUpdateInterval(value)
            }

            // set maxOverScaleFactorForParentTiles
            if (args.containsKey("maxOverScaleFactorForParentTiles") && args["maxOverScaleFactorForParentTiles"] is Int) {
                val value = args["maxOverScaleFactorForParentTiles"] as Int
                maxOverscaleFactorForParentTiles(value.toLong())
            }

            // set tileRequestsDelay
            if (args.containsKey("tileRequestsDelay") && args["tileRequestsDelay"] is Double) {
                val value = args["tileRequestsDelay"] as Double
                tileRequestsDelay(value)
            }

            // set tileNetworkRequestsDelay
            if (args.containsKey("tileNetworkRequestsDelay") && args["tileNetworkRequestsDelay"] is Double) {
                val value = args["tileNetworkRequestsDelay"] as Double
                tileNetworkRequestsDelay(value)
            }
        }
    }
}