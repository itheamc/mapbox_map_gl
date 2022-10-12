package com.itheamc.mapbox_map_gl.helper.layer_helper

import android.util.Log
import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.SkyLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.SkyType
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition

/**
 * SkyLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object SkyLayerHelper {

    private const val TAG = "SkyLayerHelper"

    /**
     * Method to set properties got from the flutter side to SkyLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): SkyLayerDsl.() -> Unit {

        return {

            // skyAtmosphereColor
            if (args.containsKey("skyAtmosphereColor")) {
                when (val color = args["skyAtmosphereColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        skyAtmosphereColor(Expression.fromRaw(color))
                    } else {
                        skyAtmosphereColor(color)
                    }
                    is Int -> skyAtmosphereColor(color)
                }
            }

            // skyAtmosphereHaloColor
            if (args.containsKey("skyAtmosphereHaloColor")) {
                when (val color = args["skyAtmosphereHaloColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        skyAtmosphereHaloColor(Expression.fromRaw(color))
                    } else {
                        skyAtmosphereHaloColor(color)
                    }
                    is Int -> skyAtmosphereHaloColor(color)
                }
            }

            // skyAtmosphereSun
            if (args.containsKey("skyAtmosphereSun")) {
                when (val atmosphereSun = args["skyAtmosphereSun"]) {
                    is String -> if (atmosphereSun.contains("[") && atmosphereSun.contains("]")) {
                        try {
                            skyAtmosphereSun(Expression.fromRaw(atmosphereSun))
                        } catch (e: Exception) {
                            Log.d(TAG, "skyAtmosphereSun: ${e.message}")
                        }
                    }
                    is List<*> -> skyAtmosphereSun(
                        atmosphereSun.map {
                            when (it) {
                                is Double -> it
                                is Int -> it.toDouble()
                                is Long -> it.toDouble()
                                else -> 0.0
                            }
                        }
                    )
                }
            }

            // skyAtmosphereSunIntensity
            if (args.containsKey("skyAtmosphereSunIntensity")) {
                when (val intensity = args["skyAtmosphereSunIntensity"]) {
                    is String -> if (intensity.contains("[") && intensity.contains("]")) {
                        skyAtmosphereSunIntensity(Expression.fromRaw(intensity))
                    }
                    is Double -> skyAtmosphereSunIntensity(intensity)
                    is Int -> skyAtmosphereSunIntensity(intensity.toDouble())
                    is Long -> skyAtmosphereSunIntensity(intensity.toDouble())
                }
            }

            // skyGradient
            if (args.containsKey("skyGradient")) {
                val gradient = args["skyGradient"] as String
                if (gradient.contains("[") && gradient.contains("]")) {
                    skyGradient(Expression.fromRaw(gradient))
                }
            }

            // skyGradientCenter
            if (args.containsKey("skyGradientCenter")) {
                when (val gradientCenter = args["skyGradientCenter"]) {
                    is String -> if (gradientCenter.contains("[") && gradientCenter.contains("]")) {
                        try {
                            skyGradientCenter(Expression.fromRaw(gradientCenter))
                        } catch (e: Exception) {
                            Log.d(TAG, "skyGradientCenter: ${e.message}")
                        }
                    }
                    is List<*> -> if (gradientCenter.size == 2) {
                        skyGradientCenter(
                            gradientCenter.map {
                                when (it) {
                                    is Double -> it
                                    is Int -> it.toDouble()
                                    is Long -> it.toDouble()
                                    else -> 0.0
                                }
                            }
                        )
                    }
                }
            }

            // skyGradientRadius
            if (args.containsKey("skyGradientRadius")) {
                when (val radius = args["skyGradientRadius"]) {
                    is String -> if (radius.contains("[") && radius.contains("]")) {
                        skyGradientRadius(Expression.fromRaw(radius))
                    }
                    is Double -> skyGradientRadius(radius)
                    is Int -> skyGradientRadius(radius.toDouble())
                    is Long -> skyGradientRadius(radius.toDouble())
                }
            }

            // skyOpacity
            if (args.containsKey("skyOpacity")) {
                when (val opacity = args["skyOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        skyOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> skyOpacity(opacity)
                    is Int -> skyOpacity(opacity.toDouble())
                    is Long -> skyOpacity(opacity.toDouble())
                }
            }

            // skyOpacityTransition
            if (args.containsKey("skyOpacityTransition")) {
                val transition = args["skyOpacityTransition"] as Map<*, *>
                skyOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // skyType
            if (args.containsKey("skyType")) {
                val pitchScale = args["skyType"] as String

                if (pitchScale.contains("[") && pitchScale.contains("]")) {
                    skyType(Expression.fromRaw(pitchScale))
                } else {
                    skyType(SkyType.valueOf(pitchScale))
                }
            }


            // filter
            if (args.containsKey("filter") && args["filter"] is String) {
                val filter = args["filter"] as String
                if (filter.contains("[") && filter.contains("]")) {
                    filter(Expression.fromRaw(filter))
                }
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