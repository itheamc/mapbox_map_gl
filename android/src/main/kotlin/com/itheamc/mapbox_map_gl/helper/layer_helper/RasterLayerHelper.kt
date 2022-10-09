package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.RasterLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.RasterResampling
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*

/**
 * RasterLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object RasterLayerHelper {

    /**
     * Method to set properties got from the flutter side to RasterLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): RasterLayerDsl.() -> Unit {
        return {

            // rasterBrightnessMax
            if (args.containsKey("rasterBrightnessMax")) {
                when (val brightness = args["rasterBrightnessMax"]) {
                    is String -> if (brightness.contains("[") && brightness.contains("]")) {
                        rasterBrightnessMax(Expression.fromRaw(brightness))
                    }
                    is Double -> rasterBrightnessMax(brightness)
                    is Int -> rasterBrightnessMax(brightness.toDouble())
                    is Long -> rasterBrightnessMax(brightness.toDouble())
                }
            }
            // rasterBrightnessMaxTransition
            if (args.containsKey("rasterBrightnessMaxTransition")) {
                val transition = args["rasterBrightnessMaxTransition"] as Map<*, *>
                rasterBrightnessMaxTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // rasterBrightnessMin
            if (args.containsKey("rasterBrightnessMin")) {
                when (val brightness = args["rasterBrightnessMin"]) {
                    is String -> if (brightness.contains("[") && brightness.contains("]")) {
                        rasterBrightnessMin(Expression.fromRaw(brightness))
                    }
                    is Double -> rasterBrightnessMin(brightness)
                    is Int -> rasterBrightnessMin(brightness.toDouble())
                    is Long -> rasterBrightnessMin(brightness.toDouble())
                }
            }
            // rasterBrightnessMinTransition
            if (args.containsKey("rasterBrightnessMinTransition")) {
                val transition = args["rasterBrightnessMinTransition"] as Map<*, *>
                rasterBrightnessMinTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // rasterContrast
            if (args.containsKey("rasterContrast")) {
                when (val contrast = args["rasterContrast"]) {
                    is String -> if (contrast.contains("[") && contrast.contains("]")) {
                        rasterContrast(Expression.fromRaw(contrast))
                    }
                    is Double -> rasterContrast(contrast)
                    is Int -> rasterContrast(contrast.toDouble())
                    is Long -> rasterContrast(contrast.toDouble())
                }
            }

            // rasterContrastTransition
            if (args.containsKey("rasterContrastTransition")) {
                val transition = args["rasterContrastTransition"] as Map<*, *>
                rasterContrastTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // rasterFadeDuration
            if (args.containsKey("rasterFadeDuration")) {
                when (val fadeDuration = args["rasterFadeDuration"]) {
                    is String -> if (fadeDuration.contains("[") && fadeDuration.contains("]")) {
                        rasterFadeDuration(Expression.fromRaw(fadeDuration))
                    }
                    is Double -> rasterFadeDuration(fadeDuration)
                    is Int -> rasterFadeDuration(fadeDuration.toDouble())
                    is Long -> rasterFadeDuration(fadeDuration.toDouble())
                }
            }

            // rasterHueRotate
            if (args.containsKey("rasterHueRotate")) {
                when (val hueRotate = args["rasterHueRotate"]) {
                    is String -> if (hueRotate.contains("[") && hueRotate.contains("]")) {
                        rasterHueRotate(Expression.fromRaw(hueRotate))
                    }
                    is Double -> rasterHueRotate(hueRotate)
                    is Int -> rasterHueRotate(hueRotate.toDouble())
                    is Long -> rasterHueRotate(hueRotate.toDouble())
                }
            }

            // rasterHueRotateTransition
            if (args.containsKey("rasterHueRotateTransition")) {
                val transition = args["rasterHueRotateTransition"] as Map<*, *>
                rasterHueRotateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // rasterOpacity
            if (args.containsKey("rasterOpacity")) {
                when (val opacity = args["rasterOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        rasterOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> rasterOpacity(opacity)
                    is Int -> rasterOpacity(opacity.toDouble())
                    is Long -> rasterOpacity(opacity.toDouble())
                }
            }

            // rasterOpacityTransition
            if (args.containsKey("rasterOpacityTransition")) {
                val transition = args["rasterOpacityTransition"] as Map<*, *>
                rasterOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // rasterResampling
            if (args.containsKey("rasterResampling")) {
                val resampling = args["rasterResampling"] as String

                if (resampling.contains("[") && resampling.contains("]")) {
                    rasterResampling(Expression.fromRaw(resampling))
                } else {
                    rasterResampling(
                        RasterResampling.valueOf(
                            resampling.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // rasterSaturation
            if (args.containsKey("rasterSaturation")) {
                when (val saturation = args["rasterSaturation"]) {
                    is String -> if (saturation.contains("[") && saturation.contains("]")) {
                        rasterSaturation(Expression.fromRaw(saturation))
                    }
                    is Double -> rasterSaturation(saturation)
                    is Int -> rasterSaturation(saturation.toDouble())
                    is Long -> rasterSaturation(saturation.toDouble())
                }
            }

            // rasterSaturationTransition
            if (args.containsKey("rasterSaturationTransition")) {
                val transition = args["rasterSaturationTransition"] as Map<*, *>
                rasterOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
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
            if (args.containsKey("visibility")) {
                val visible = args["visibility"] as Boolean
                visibility(if (visible) Visibility.VISIBLE else Visibility.NONE)
            }
        }
    }
}