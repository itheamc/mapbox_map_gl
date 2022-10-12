package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.HeatmapLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition

/**
 * HeatmapLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object HeatmapLayerHelper {

    /**
     * Method to set properties got from the flutter side to HeatmapLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): HeatmapLayerDsl.() -> Unit {

        return {

            // heatmapColor
            if (args.containsKey("heatmapColor") && args["heatmapColor"] is String) {

                val color = args["heatmapColor"] as String

                if (color.contains("[") && color.contains("]")) {
                    heatmapColor(Expression.fromRaw(color))
                }
            }

            // heatmapIntensity
            if (args.containsKey("heatmapIntensity")) {
                when (val value = args["heatmapIntensity"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        heatmapIntensity(Expression.fromRaw(value))
                    }
                    is Double -> heatmapIntensity(value)
                    is Int -> heatmapIntensity(value.toDouble())
                    is Long -> heatmapIntensity(value.toDouble())
                }
            }

            // heatmapIntensityTransition
            if (args.containsKey("heatmapIntensityTransition")) {
                val transition =
                    args["heatmapIntensityTransition"] as Map<*, *>
                heatmapIntensityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // heatmapOpacity
            if (args.containsKey("heatmapOpacity")) {
                when (val value = args["heatmapOpacity"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        heatmapOpacity(Expression.fromRaw(value))
                    }
                    is Double -> heatmapOpacity(value)
                    is Int -> heatmapOpacity(value.toDouble())
                    is Long -> heatmapOpacity(value.toDouble())
                }
            }

            // heatmapOpacityTransition
            if (args.containsKey("heatmapOpacityTransition")) {
                val transition =
                    args["heatmapOpacityTransition"] as Map<*, *>
                heatmapOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // heatmapRadius
            if (args.containsKey("heatmapRadius")) {
                when (val value = args["heatmapRadius"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        heatmapRadius(Expression.fromRaw(value))
                    }
                    is Double -> heatmapRadius(value)
                    is Int -> heatmapRadius(value.toDouble())
                    is Long -> heatmapRadius(value.toDouble())
                }
            }

            // heatmapRadiusTransition
            if (args.containsKey("heatmapRadiusTransition")) {
                val transition =
                    args["heatmapRadiusTransition"] as Map<*, *>
                heatmapRadiusTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // heatmapWeight
            if (args.containsKey("heatmapWeight")) {
                when (val value = args["heatmapWeight"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        heatmapWeight(Expression.fromRaw(value))
                    }
                    is Double -> heatmapWeight(value)
                    is Int -> heatmapWeight(value.toDouble())
                    is Long -> heatmapWeight(value.toDouble())
                }
            }

            // filter
            if (args.containsKey("filter") && args["filter"] is String) {
                val filter = args["filter"] as String
                if (filter.contains("[") && filter.contains("]")) {
                    filter(Expression.fromRaw(filter))
                }
            }

            // sourceLayer
            if (args.containsKey("sourceLayer") && args["sourceLayer"] is String) {
                val sourceLayer = args["sourceLayer"] as String
                sourceLayer(sourceLayer)
            }

            // maxZoom
            if (args.containsKey("maxZoom")) {
                when (val max = args["maxZoom"]) {
                    is Double -> maxZoom(max)
                    is Int -> maxZoom(max.toDouble())
                    is Long -> maxZoom(max.toDouble())
                }
            }

            // minZoom
            if (args.containsKey("minZoom")) {
                when (val min = args["minZoom"]) {
                    is Double -> minZoom(min)
                    is Int -> minZoom(min.toDouble())
                    is Long -> minZoom(min.toDouble())
                }
            }

            // visibility
            if (args.containsKey("visibility") && args["visibility"] is Boolean) {
                val visible = args["visibility"] as Boolean
                visibility(if (visible) Visibility.VISIBLE else Visibility.NONE)
            }
        }
    }
}