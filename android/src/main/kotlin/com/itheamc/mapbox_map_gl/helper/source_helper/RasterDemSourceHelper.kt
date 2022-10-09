package com.itheamc.mapbox_map_gl.helper.source_helper

import com.itheamc.mapbox_map_gl.helper.TileSetHelper
import com.mapbox.maps.extension.style.sources.generated.Encoding
import com.mapbox.maps.extension.style.sources.generated.RasterDemSource
import java.util.*

/**
 * RasterDemSourceHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object RasterDemSourceHelper {

    /**
     * Method to set properties got from the flutter side to RasterDemSource.Builder block
     */
    fun blockFromArgs(args: Map<*, *>): RasterDemSource.Builder.() -> Unit {

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

            // set tiles
            if (args.containsKey("tileSet") && args["tileSet"] is Map<*, *>) {
                val value = args["tileSet"] as Map<*, *>
                val tileJson = value["tileJson"] as String
                val tileList = value["tiles"] as List<*>
                tileSet(
                    tilejson = tileJson,
                    tiles = tileList.map { it.toString() },
                    block = TileSetHelper.rasterDemBuilderBlockFromArgs(if (value.containsKey("properties")) value["properties"] as Map<*, *> else null)
                )
            }

            // set bounds
            if (sourceProperties.containsKey("bounds") && sourceProperties["bounds"] is List<*>) {
                val value = sourceProperties["bounds"] as List<*>
                if (value.size == 4) {
                    val list = value.map { it as Double }
                    bounds(list)
                }
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

            // set tileSize
            if (sourceProperties.containsKey("tileSize")) {
                when (val value = sourceProperties["tileSize"]) {
                    is Double -> tileSize(value.toLong())
                    is Int -> tileSize(value.toLong())
                    is Long -> tileSize(value)
                }
            }

            // set scheme
            if (sourceProperties.containsKey("encoding") && sourceProperties["encoding"] is String) {
                val value = sourceProperties["encoding"] as String
                encoding(Encoding.valueOf(value.uppercase(Locale.ENGLISH)))
            }

            // set attribution
            if (sourceProperties.containsKey("attribution") && sourceProperties["attribution"] is String) {
                val value = sourceProperties["attribution"] as String
                attribution(value)
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