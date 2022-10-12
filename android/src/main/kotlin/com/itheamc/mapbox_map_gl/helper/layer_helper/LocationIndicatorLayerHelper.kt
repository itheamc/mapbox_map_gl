package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.LocationIndicatorLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition

/**
 * LocationIndicatorLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object LocationIndicatorLayerHelper {

    /**
     * Method to set properties got from the flutter side to LocationIndicatorLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): LocationIndicatorLayerDsl.() -> Unit {

        return {

            // bearingImage
            if (args.containsKey("bearingImage") && args["bearingImage"] is String) {
                val img = args["bearingImage"] as String

                if (img.contains("[") && img.contains("]")) {
                    bearingImage(Expression.fromRaw(img))
                } else {
                    bearingImage(img)
                }
            }

            // shadowImage
            if (args.containsKey("shadowImage") && args["shadowImage"] is String) {
                val img = args["shadowImage"] as String

                if (img.contains("[") && img.contains("]")) {
                    shadowImage(Expression.fromRaw(img))
                } else {
                    shadowImage(img)
                }
            }

            // topImage
            if (args.containsKey("topImage") && args["topImage"] is String) {
                val img = args["topImage"] as String

                if (img.contains("[") && img.contains("]")) {
                    topImage(Expression.fromRaw(img))
                } else {
                    topImage(img)
                }
            }

            // accuracyRadius
            if (args.containsKey("accuracyRadius")) {
                when (val value = args["accuracyRadius"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        accuracyRadius(Expression.fromRaw(value))
                    }
                    is Double -> accuracyRadius(value)
                    is Int -> accuracyRadius(value.toDouble())
                    is Long -> accuracyRadius(value.toDouble())
                }
            }

            // accuracyRadiusTransition
            if (args.containsKey("accuracyRadiusTransition")) {
                val transition = args["accuracyRadiusTransition"] as Map<*, *>
                accuracyRadiusTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // accuracyRadiusBorderColor
            if (args.containsKey("accuracyRadiusBorderColor")) {
                when (val color = args["accuracyRadiusBorderColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        accuracyRadiusBorderColor(Expression.fromRaw(color))
                    } else {
                        accuracyRadiusBorderColor(color)
                    }
                    is Int -> accuracyRadiusBorderColor(color)
                }
            }

            // accuracyRadiusBorderColorTransition
            if (args.containsKey("accuracyRadiusBorderColorTransition")) {
                val transition = args["accuracyRadiusBorderColorTransition"] as Map<*, *>
                accuracyRadiusBorderColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // accuracyRadiusColor
            if (args.containsKey("accuracyRadiusColor")) {
                when (val color = args["accuracyRadiusColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        accuracyRadiusColor(Expression.fromRaw(color))
                    } else {
                        accuracyRadiusColor(color)
                    }
                    is Int -> accuracyRadiusColor(color)
                }
            }

            // accuracyRadiusColorTransition
            if (args.containsKey("accuracyRadiusColorTransition")) {
                val transition = args["accuracyRadiusColorTransition"] as Map<*, *>
                accuracyRadiusColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // bearing
            if (args.containsKey("bearing")) {
                when (val value = args["bearing"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        bearing(Expression.fromRaw(value))
                    }
                    is Double -> bearing(value)
                    is Int -> bearing(value.toDouble())
                    is Long -> bearing(value.toDouble())
                }
            }

            // bearingTransition
            if (args.containsKey("bearingTransition")) {
                val transition = args["bearingTransition"] as Map<*, *>
                bearingTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // bearingImageSize
            if (args.containsKey("bearingImageSize")) {
                when (val value = args["bearingImageSize"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        bearingImageSize(Expression.fromRaw(value))
                    }
                    is Double -> bearingImageSize(value)
                    is Int -> bearingImageSize(value.toDouble())
                    is Long -> bearingImageSize(value.toDouble())
                }
            }

            // bearingImageSizeTransition
            if (args.containsKey("bearingImageSizeTransition")) {
                val transition = args["bearingImageSizeTransition"] as Map<*, *>
                bearingImageSizeTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // emphasisCircleColor
            if (args.containsKey("emphasisCircleColor")) {
                when (val color = args["emphasisCircleColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        emphasisCircleColor(Expression.fromRaw(color))
                    } else {
                        emphasisCircleColor(color)
                    }
                    is Int -> emphasisCircleColor(color)
                }
            }

            // emphasisCircleColorTransition
            if (args.containsKey("emphasisCircleColorTransition")) {
                val transition = args["emphasisCircleColorTransition"] as Map<*, *>
                emphasisCircleColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // emphasisCircleRadius
            if (args.containsKey("emphasisCircleRadius")) {
                when (val value = args["emphasisCircleRadius"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        emphasisCircleRadius(Expression.fromRaw(value))
                    }
                    is Double -> emphasisCircleRadius(value)
                    is Int -> emphasisCircleRadius(value.toDouble())
                    is Long -> emphasisCircleRadius(value.toDouble())
                }
            }

            // emphasisCircleRadiusTransition
            if (args.containsKey("emphasisCircleRadiusTransition")) {
                val transition = args["emphasisCircleRadiusTransition"] as Map<*, *>
                emphasisCircleRadiusTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // imagePitchDisplacement
            if (args.containsKey("imagePitchDisplacement")) {
                when (val value = args["imagePitchDisplacement"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        imagePitchDisplacement(Expression.fromRaw(value))
                    }
                    is Double -> imagePitchDisplacement(value)
                    is Int -> imagePitchDisplacement(value.toDouble())
                    is Long -> imagePitchDisplacement(value.toDouble())
                }
            }

            // location
            if (args.containsKey("location")) {
                when (val value = args["location"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        location(Expression.fromRaw(value))
                    }
                    is List<*> -> if (value.size == 3) {
                        if (value.first() is Double) location(
                            value.map { it as Double }
                        ) else location(value.map { (it as Int).toDouble() })
                    }
                }
            }

            // locationTransition
            if (args.containsKey("locationTransition")) {
                val transition = args["locationTransition"] as Map<*, *>
                locationTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // perspectiveCompensation
            if (args.containsKey("perspectiveCompensation")) {
                when (val value = args["perspectiveCompensation"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        perspectiveCompensation(Expression.fromRaw(value))
                    }
                    is Double -> perspectiveCompensation(value)
                    is Int -> perspectiveCompensation(value.toDouble())
                    is Long -> perspectiveCompensation(value.toDouble())
                }
            }

            // shadowImageSize
            if (args.containsKey("shadowImageSize")) {
                when (val value = args["shadowImageSize"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        shadowImageSize(Expression.fromRaw(value))
                    }
                    is Double -> shadowImageSize(value)
                    is Int -> shadowImageSize(value.toDouble())
                    is Long -> shadowImageSize(value.toDouble())
                }
            }

            // shadowImageSizeTransition
            if (args.containsKey("shadowImageSizeTransition")) {
                val transition = args["shadowImageSizeTransition"] as Map<*, *>
                shadowImageSizeTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // topImageSize
            if (args.containsKey("topImageSize")) {
                when (val value = args["topImageSize"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        topImageSize(Expression.fromRaw(value))
                    }
                    is Double -> topImageSize(value)
                    is Int -> topImageSize(value.toDouble())
                    is Long -> topImageSize(value.toDouble())
                }
            }

            // topImageSizeTransition
            if (args.containsKey("topImageSizeTransition")) {
                val transition = args["topImageSizeTransition"] as Map<*, *>
                topImageSizeTransition(
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