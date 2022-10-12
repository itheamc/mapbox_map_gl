package com.itheamc.mapbox_map_gl.helper.layer_helper

import android.util.Log
import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.CircleLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.CirclePitchAlignment
import com.mapbox.maps.extension.style.layers.properties.generated.CirclePitchScale
import com.mapbox.maps.extension.style.layers.properties.generated.CircleTranslateAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*


/**
 * CircleLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/4
 */
internal object CircleLayerHelper {

    private const val TAG = "CircleLayerHelper"

    /**
     * Method to set properties got from the flutter side to CircleLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): CircleLayerDsl.() -> Unit {
        return {
            // circleColor
            if (args.containsKey("circleColor")) {
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
            if (args.containsKey("circleColorTransition")) {
                val transition = args["circleColorTransition"] as Map<*, *>
                circleColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleRadius
            if (args.containsKey("circleRadius")) {
                when (val radius = args["circleRadius"]) {
                    is String -> if (radius.contains("[") && radius.contains("]")) {
                        circleRadius(Expression.fromRaw(radius))
                    }
                    is Double -> circleRadius(radius)
                    is Int -> circleRadius(radius.toDouble())
                    is Long -> circleRadius(radius.toDouble())
                }
            }
            // circleRadiusTransition
            if (args.containsKey("circleRadiusTransition")) {
                val transition = args["circleRadiusTransition"] as Map<*, *>
                circleRadiusTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleBlur
            if (args.containsKey("circleBlur")) {
                when (val blur = args["circleBlur"]) {
                    is String -> if (blur.contains("[") && blur.contains("]")) {
                        circleBlur(Expression.fromRaw(blur))
                    }
                    is Double -> circleBlur(blur)
                    is Int -> circleBlur(blur.toDouble())
                    is Long -> circleBlur(blur.toDouble())
                }
            }
            // circleBlurTransition
            if (args.containsKey("circleBlurTransition")) {
                val transition = args["circleBlurTransition"] as Map<*, *>
                circleBlurTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleOpacity
            if (args.containsKey("circleOpacity")) {
                when (val opacity = args["circleOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        circleOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> circleOpacity(opacity)
                    is Int -> circleOpacity(opacity.toDouble())
                    is Long -> circleOpacity(opacity.toDouble())
                }
            }
            // circleOpacityTransition
            if (args.containsKey("circleOpacityTransition")) {
                val transition = args["circleOpacityTransition"] as Map<*, *>
                circleOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleStrokeColor
            if (args.containsKey("circleStrokeColor")) {
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
            if (args.containsKey("circleStrokeColorTransition")) {
                val transition = args["circleStrokeColorTransition"] as Map<*, *>
                circleStrokeColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleStrokeWidth
            if (args.containsKey("circleStrokeWidth")) {
                when (val strokeWidth = args["circleStrokeWidth"]) {
                    is String -> if (strokeWidth.contains("[") && strokeWidth.contains("]")) {
                        circleStrokeWidth(Expression.fromRaw(strokeWidth))
                    }
                    is Double -> circleStrokeWidth(strokeWidth)
                    is Int -> circleStrokeWidth(strokeWidth.toDouble())
                    is Long -> circleStrokeWidth(strokeWidth.toDouble())
                }
            }
            // circleStrokeWidthTransition
            if (args.containsKey("circleStrokeWidthTransition")) {
                val transition = args["circleStrokeWidthTransition"] as Map<*, *>
                circleStrokeWidthTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleStrokeOpacity
            if (args.containsKey("circleStrokeOpacity")) {
                when (val opacity = args["circleStrokeOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        circleStrokeOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> circleStrokeOpacity(opacity)
                    is Int -> circleStrokeOpacity(opacity.toDouble())
                    is Long -> circleStrokeOpacity(opacity.toDouble())
                }
            }
            // circleStrokeOpacityTransition
            if (args.containsKey("circleStrokeOpacityTransition")) {
                val transition = args["circleStrokeOpacityTransition"] as Map<*, *>
                circleStrokeOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circlePitchScale
            if (args.containsKey("circlePitchScale")) {
                val pitchScale = args["circlePitchScale"] as String

                if (pitchScale.contains("[") && pitchScale.contains("]")) {
                    circlePitchScale(Expression.fromRaw(pitchScale))
                } else {
                    circlePitchScale(CirclePitchScale.valueOf(pitchScale))
                }
            }

            // circlePitchAlignment
            if (args.containsKey("circlePitchAlignment")) {
                val pitchAlignment = args["circlePitchAlignment"] as String

                if (pitchAlignment.contains("[") && pitchAlignment.contains("]")) {
                    circlePitchAlignment(Expression.fromRaw(pitchAlignment))
                } else {
                    circlePitchAlignment(
                        CirclePitchAlignment.valueOf(
                            pitchAlignment.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // circleSortKey
            if (args.containsKey("circleSortKey")) {
                when (val sortKey = args["circleSortKey"]) {
                    is String -> if (sortKey.contains("[") && sortKey.contains("]")) {
                        circleSortKey(Expression.fromRaw(sortKey))
                    }
                    is Double -> circleSortKey(sortKey)
                    is Int -> circleSortKey(sortKey.toDouble())
                    is Long -> circleSortKey(sortKey.toDouble())
                }
            }

            // circleTranslate
            if (args.containsKey("circleTranslate")) {
                when (val translate = args["circleTranslate"]) {
                    is String -> if (translate.contains("[") && translate.contains("]")) {
                        try {
                            circleTranslate(Expression.fromRaw(translate))
                        } catch (e: Exception) {
                            Log.d(TAG, "circleTranslate: ${e.message}")
                        }
                    }
                    is List<*> -> if (translate.first() is Double) circleTranslate(
                        translate.map { it as Double }
                    ) else circleTranslate(translate.map { (it as Int).toDouble() })
                }
            }

            // circleTranslateTransition
            if (args.containsKey("circleTranslateTransition")) {
                val transition = args["circleTranslateTransition"] as Map<*, *>
                circleTranslateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // circleTranslateAnchor
            if (args.containsKey("circleTranslateAnchor")) {
                val translateAnchor = args["circleTranslateAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    circleTranslateAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    circleTranslateAnchor(
                        CircleTranslateAnchor.valueOf(
                            translateAnchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // sourceLayer
            if (args.containsKey("sourceLayer") && args["sourceLayer"] is String) {
                val sourceLayer = args["sourceLayer"] as String
                sourceLayer(sourceLayer)
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