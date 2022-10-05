package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.CircleLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.CirclePitchAlignment
import com.mapbox.maps.extension.style.layers.properties.generated.CirclePitchScale
import com.mapbox.maps.extension.style.layers.properties.generated.CircleTranslateAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition

object CircleLayerUtils {

    fun processLayerArguments(args: Map<*, *>): CircleLayerDsl.() -> Unit {
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
                    circlePitchAlignment(CirclePitchAlignment.valueOf(pitchAlignment))
                }
            }

            // circleSortKey
            if (args.containsKey("circleSortKey")) {
                when (val sortKey = args["circleSortKey"]) {
                    is String -> if (sortKey.contains("[") && sortKey.contains("]")) {
                        circleSortKey(Expression.fromRaw(sortKey))
                    }
                    is Double -> circleSortKey(sortKey)
                }
            }

            // circleTranslate
            if (args.containsKey("circleTranslate")) {
                when (val circleTranslate = args["circleTranslate"]) {
                    is String -> if (circleTranslate.contains("[") && circleTranslate.contains("]")) {
                        circleTranslate(Expression.fromRaw(circleTranslate))
                    }
                    is List<*> -> if (circleTranslate.first() is Double) circleTranslate(
                        circleTranslate.map { it as Double }
                    )
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
                    circleTranslateAnchor(CircleTranslateAnchor.valueOf(translateAnchor))
                }
            }

            // sourceLayer
            if (args.containsKey("sourceLayer")) {
                val sourceLayer = args["sourceLayer"] as String
                sourceLayer(sourceLayer)
            }

            // filter
            if (args.containsKey("filter")) {
                val filter = args["filter"] as String
                if (filter.contains("[") && filter.contains("]")) {
                    filter(Expression.fromRaw(filter))
                }
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