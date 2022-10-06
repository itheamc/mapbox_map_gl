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
object RasterLayerHelper {

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
                }
            }

            // rasterHueRotate
            if (args.containsKey("rasterHueRotate")) {
                when (val hueRotate = args["rasterHueRotate"]) {
                    is String -> if (hueRotate.contains("[") && hueRotate.contains("]")) {
                        rasterHueRotate(Expression.fromRaw(hueRotate))
                    }
                    is Double -> rasterHueRotate(hueRotate)
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
            if (args.containsKey("sourceLayer")) {
                val sourceLayer = args["sourceLayer"] as String
                sourceLayer(sourceLayer)
            }

            // maxZoom
            if (args.containsKey("maxZoom")) {
                val max = args["maxZoom"] as Double
                maxZoom(max)
            }

            // minZoom
            if (args.containsKey("minZoom")) {
                val min = args["minZoom"] as Double
                minZoom(min)
            }

            // visibility
            if (args.containsKey("visibility")) {
                val visible = args["visibility"] as Boolean
                visibility(if (visible) Visibility.VISIBLE else Visibility.NONE)
            }
        }
    }
}