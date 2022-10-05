package com.itheamc.mapbox_map_gl.utils

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.CircleLayerDsl
import com.mapbox.maps.extension.style.types.StyleTransition

object LayerUtils {

    fun processCircleLayerArguments(args: Map<*, *>): CircleLayerDsl.() -> Unit {
        return {
            // circleColor
            if (args.containsKey("circleColor") && args["circleColor"] != null) {
                when (val color = args["circleColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        circleColor(Expression.fromRaw(color))
                    } else {
                        circleColor(color)
                    }
                    is Int -> circleColor(color)
                }
            }
            // circleColorTransition
            if (args.containsKey("circleColorTransition") && args["circleColorTransition"] != null) {
                val transition = args["circleColorTransition"] as Map<*, *>
                circleColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleRadius
            if (args.containsKey("circleRadius") && args["circleRadius"] != null) {
                when (val radius = args["circleRadius"]) {
                    is String -> if (radius.contains("[") && radius.contains("]")) {
                        circleRadius(Expression.fromRaw(radius))
                    }
                    is Double -> circleRadius(radius)
                }
            }
            // circleRadiusTransition
            if (args.containsKey("circleRadiusTransition") && args["circleRadiusTransition"] != null) {
                val transition = args["circleRadiusTransition"] as Map<*, *>
                circleRadiusTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleBlur
            if (args.containsKey("circleBlur") && args["circleBlur"] != null) {
                when (val blur = args["circleBlur"]) {
                    is String -> if (blur.contains("[") && blur.contains("]")) {
                        circleBlur(Expression.fromRaw(blur))
                    }
                    is Double -> circleBlur(blur)
                }
            }
            // circleBlurTransition
            if (args.containsKey("circleBlurTransition") && args["circleBlurTransition"] != null) {
                val transition = args["circleBlurTransition"] as Map<*, *>
                circleBlurTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleOpacity
            if (args.containsKey("circleOpacity") && args["circleOpacity"] != null) {
                when (val opacity = args["circleOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        circleOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> circleOpacity(opacity)
                }
            }
            // circleOpacityTransition
            if (args.containsKey("circleOpacityTransition") && args["circleOpacityTransition"] != null) {
                val transition = args["circleOpacityTransition"] as Map<*, *>
                circleOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleStrokeColor
            if (args.containsKey("circleStrokeColor") && args["circleStrokeColor"] != null) {
                when (val color = args["circleStrokeColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        circleStrokeColor(Expression.fromRaw(color))
                    } else {
                        circleStrokeColor(color)
                    }
                    is Int -> circleStrokeColor(color)
                }
            }

            // circleStrokeColorTransition
            if (args.containsKey("circleStrokeColorTransition") && args["circleStrokeColorTransition"] != null) {
                val transition = args["circleStrokeColorTransition"] as Map<*, *>
                circleStrokeColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleStrokeWidth
            if (args.containsKey("circleStrokeWidth") && args["circleStrokeWidth"] != null) {
                when (val strokeWidth = args["circleStrokeWidth"]) {
                    is String -> if (strokeWidth.contains("[") && strokeWidth.contains("]")) {
                        circleStrokeWidth(Expression.fromRaw(strokeWidth))
                    }
                    is Double -> circleStrokeWidth(strokeWidth)
                }
            }
            // circleStrokeWidthTransition
            if (args.containsKey("circleStrokeWidthTransition") && args["circleStrokeWidthTransition"] != null) {
                val transition = args["circleStrokeWidthTransition"] as Map<*, *>
                circleStrokeWidthTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }
        }
    }
}