package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.BackgroundLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition

/**
 * BackgroundLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object BackgroundLayerHelper {

    /**
     * Method to set properties got from the flutter side to BackgroundLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): BackgroundLayerDsl.() -> Unit {

        return {

            // backgroundColor
            if (args.containsKey("backgroundColor")) {
                when (val color = args["backgroundColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        backgroundColor(Expression.fromRaw(color))
                    } else {
                        backgroundColor(color)
                    }
                    is Int -> backgroundColor(color)
                }
            }

            // backgroundColorTransition
            if (args.containsKey("backgroundColorTransition")) {
                val transition = args["backgroundColorTransition"] as Map<*, *>
                backgroundColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // backgroundOpacity
            if (args.containsKey("backgroundOpacity")) {
                when (val brightness = args["backgroundOpacity"]) {
                    is String -> if (brightness.contains("[") && brightness.contains("]")) {
                        backgroundOpacity(Expression.fromRaw(brightness))
                    }
                    is Double -> backgroundOpacity(brightness)
                    is Int -> backgroundOpacity(brightness.toDouble())
                    is Long -> backgroundOpacity(brightness.toDouble())
                }
            }
            // backgroundOpacityTransition
            if (args.containsKey("backgroundOpacityTransition")) {
                val transition = args["backgroundOpacityTransition"] as Map<*, *>
                backgroundOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // backgroundPattern
            if (args.containsKey("backgroundPattern") && args["backgroundPattern"] is String) {
                val pattern = args["backgroundPattern"] as String

                if (pattern.contains("[") && pattern.contains("]")) {
                    backgroundPattern(Expression.fromRaw(pattern))
                } else {
                    backgroundPattern(pattern)
                }
            }

            // backgroundPatternTransition
            if (args.containsKey("backgroundPatternTransition")) {
                val transition = args["backgroundPatternTransition"] as Map<*, *>
                backgroundPatternTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
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
