package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.FillExtrusionLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.FillExtrusionTranslateAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*

/**
 * FillExtrusionLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object FillExtrusionLayerHelper {

    /**
     * Method to set properties got from the flutter side to FillExtrusionLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): FillExtrusionLayerDsl.() -> Unit {

        return {

            // fillExtrusionAmbientOcclusionIntensity
            if (args.containsKey("fillExtrusionAmbientOcclusionIntensity")) {
                when (val value = args["fillExtrusionAmbientOcclusionIntensity"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        fillExtrusionAmbientOcclusionIntensity(Expression.fromRaw(value))
                    }
                    is Double -> fillExtrusionAmbientOcclusionIntensity(value)
                    is Int -> fillExtrusionAmbientOcclusionIntensity(value.toDouble())
                    is Long -> fillExtrusionAmbientOcclusionIntensity(value.toDouble())
                }
            }

            // fillExtrusionAmbientOcclusionIntensityTransition
            if (args.containsKey("fillExtrusionAmbientOcclusionIntensityTransition")) {
                val transition =
                    args["fillExtrusionAmbientOcclusionIntensityTransition"] as Map<*, *>
                fillExtrusionAmbientOcclusionIntensityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionAmbientOcclusionRadius
            if (args.containsKey("fillExtrusionAmbientOcclusionRadius")) {
                when (val value = args["fillExtrusionAmbientOcclusionRadius"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        fillExtrusionAmbientOcclusionRadius(Expression.fromRaw(value))
                    }
                    is Double -> fillExtrusionAmbientOcclusionRadius(value)
                    is Int -> fillExtrusionAmbientOcclusionRadius(value.toDouble())
                    is Long -> fillExtrusionAmbientOcclusionRadius(value.toDouble())
                }
            }

            // fillExtrusionAmbientOcclusionRadiusTransition
            if (args.containsKey("fillExtrusionAmbientOcclusionRadiusTransition")) {
                val transition = args["fillExtrusionAmbientOcclusionRadiusTransition"] as Map<*, *>
                fillExtrusionAmbientOcclusionRadiusTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionBase
            if (args.containsKey("fillExtrusionBase")) {
                when (val value = args["fillExtrusionBase"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        fillExtrusionBase(Expression.fromRaw(value))
                    }
                    is Double -> fillExtrusionBase(value)
                    is Int -> fillExtrusionBase(value.toDouble())
                    is Long -> fillExtrusionBase(value.toDouble())
                }
            }

            // fillExtrusionBaseTransition
            if (args.containsKey("fillExtrusionBaseTransition")) {
                val transition = args["fillExtrusionBaseTransition"] as Map<*, *>
                fillExtrusionBaseTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionColor
            if (args.containsKey("fillExtrusionColor")) {
                when (val color = args["fillExtrusionColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        fillExtrusionColor(Expression.fromRaw(color))
                    } else {
                        fillExtrusionColor(color)
                    }
                    is Int -> fillExtrusionColor(color)
                }
            }

            // fillExtrusionColorTransition
            if (args.containsKey("fillExtrusionColorTransition")) {
                val transition = args["fillExtrusionColorTransition"] as Map<*, *>
                fillExtrusionColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionHeight
            if (args.containsKey("fillExtrusionHeight")) {
                when (val value = args["fillExtrusionHeight"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        fillExtrusionHeight(Expression.fromRaw(value))
                    }
                    is Double -> fillExtrusionHeight(value)
                    is Int -> fillExtrusionHeight(value.toDouble())
                    is Long -> fillExtrusionHeight(value.toDouble())
                }
            }

            // fillExtrusionHeightTransition
            if (args.containsKey("fillExtrusionHeightTransition")) {
                val transition = args["fillExtrusionHeightTransition"] as Map<*, *>
                fillExtrusionHeightTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionOpacity
            if (args.containsKey("fillExtrusionOpacity")) {
                when (val value = args["fillExtrusionOpacity"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        fillExtrusionOpacity(Expression.fromRaw(value))
                    }
                    is Double -> fillExtrusionOpacity(value)
                    is Int -> fillExtrusionOpacity(value.toDouble())
                    is Long -> fillExtrusionOpacity(value.toDouble())
                }
            }

            // fillExtrusionOpacityTransition
            if (args.containsKey("fillExtrusionOpacityTransition")) {
                val transition = args["fillExtrusionOpacityTransition"] as Map<*, *>
                fillExtrusionOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionPattern
            if (args.containsKey("fillExtrusionPattern")) {
                val pattern = args["fillExtrusionPattern"] as String

                if (pattern.contains("[") && pattern.contains("]")) {
                    fillExtrusionPattern(Expression.fromRaw(pattern))
                } else {
                    fillExtrusionPattern(pattern)
                }
            }

            // fillExtrusionPatternTransition
            if (args.containsKey("fillExtrusionPatternTransition")) {
                val transition = args["fillExtrusionPatternTransition"] as Map<*, *>
                fillExtrusionPatternTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionTranslate
            if (args.containsKey("fillExtrusionTranslate")) {
                when (val translate = args["fillExtrusionTranslate"]) {
                    is String -> if (translate.contains("[") && translate.contains("]")) {
                        fillExtrusionTranslate(Expression.fromRaw(translate))
                    }
                    is List<*> -> if (translate.first() is Double) fillExtrusionTranslate(
                        translate.map { it as Double }
                    ) else fillExtrusionTranslate(translate.map { (it as Int).toDouble() })
                }
            }

            // fillExtrusionTranslateTransition
            if (args.containsKey("fillExtrusionTranslateTransition")) {
                val transition = args["fillExtrusionTranslateTransition"] as Map<*, *>
                fillExtrusionTranslateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillExtrusionTranslateAnchor
            if (args.containsKey("fillExtrusionTranslateAnchor")) {
                val translateAnchor = args["fillExtrusionTranslateAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    fillExtrusionTranslateAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    fillExtrusionTranslateAnchor(
                        FillExtrusionTranslateAnchor.valueOf(
                            translateAnchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // fillExtrusionVerticalGradient
            if (args.containsKey("fillExtrusionVerticalGradient")) {
                when (val value = args["fillExtrusionVerticalGradient"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        fillExtrusionVerticalGradient(Expression.fromRaw(value))
                    }
                    is Boolean -> fillExtrusionVerticalGradient(value)
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