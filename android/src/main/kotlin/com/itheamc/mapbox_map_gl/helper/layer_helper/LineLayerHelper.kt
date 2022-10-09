package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.LineLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.LineCap
import com.mapbox.maps.extension.style.layers.properties.generated.LineJoin
import com.mapbox.maps.extension.style.layers.properties.generated.LineTranslateAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*

/**
 * LineLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object LineLayerHelper {

    /**
     * Method to set properties got from the flutter side to LineLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): LineLayerDsl.() -> Unit {
        return {
            // lineColor
            if (args.containsKey("lineColor")) {
                when (val color = args["lineColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        lineColor(Expression.fromRaw(color))
                    } else {
                        lineColor(color)
                    }
                    is Int -> lineColor(color)
                }
            }
            // lineColorTransition
            if (args.containsKey("lineColorTransition")) {
                val transition = args["lineColorTransition"] as Map<*, *>
                lineColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineWidth
            if (args.containsKey("lineWidth")) {
                when (val width = args["lineWidth"]) {
                    is String -> if (width.contains("[") && width.contains("]")) {
                        lineWidth(Expression.fromRaw(width))
                    }
                    is Double -> lineWidth(width)
                    is Int -> lineWidth(width.toDouble())
                    is Long -> lineWidth(width.toDouble())
                }
            }
            // lineWidthTransition
            if (args.containsKey("lineWidthTransition")) {
                val transition = args["lineWidthTransition"] as Map<*, *>
                lineWidthTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineBlur
            if (args.containsKey("lineBlur")) {
                when (val blur = args["lineBlur"]) {
                    is String -> if (blur.contains("[") && blur.contains("]")) {
                        lineBlur(Expression.fromRaw(blur))
                    }
                    is Double -> lineBlur(blur)
                    is Int -> lineBlur(blur.toDouble())
                    is Long -> lineBlur(blur.toDouble())
                }
            }
            // lineBlurTransition
            if (args.containsKey("lineBlurTransition")) {
                val transition = args["lineBlurTransition"] as Map<*, *>
                lineBlurTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineOpacity
            if (args.containsKey("lineOpacity")) {
                when (val opacity = args["lineOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        lineOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> lineOpacity(opacity)
                    is Int -> lineOpacity(opacity.toDouble())
                    is Long -> lineOpacity(opacity.toDouble())
                }
            }
            // lineOpacityTransition
            if (args.containsKey("lineOpacityTransition")) {
                val transition = args["lineOpacityTransition"] as Map<*, *>
                lineOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineDashArray
            if (args.containsKey("lineDashArray")) {
                when (val dashArray = args["lineDashArray"]) {
                    is String -> if (dashArray.contains("[") && dashArray.contains("]")) {
                        lineDasharray(Expression.fromRaw(dashArray))
                    }
                    is List<*> -> if (dashArray.first() is Double) lineDasharray(
                        dashArray.map { it as Double }
                    ) else lineDasharray(dashArray.map { (it as Int).toDouble() })
                }
            }

            // lineDashArrayTransition
            if (args.containsKey("lineDashArrayTransition")) {
                val transition = args["lineDashArrayTransition"] as Map<*, *>
                lineDasharrayTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineGapWidth
            if (args.containsKey("lineGapWidth")) {
                when (val gapWidth = args["lineGapWidth"]) {
                    is String -> if (gapWidth.contains("[") && gapWidth.contains("]")) {
                        lineGapWidth(Expression.fromRaw(gapWidth))
                    }
                    is Double -> lineGapWidth(gapWidth)
                    is Int -> lineGapWidth(gapWidth.toDouble())
                    is Long -> lineGapWidth(gapWidth.toDouble())
                }
            }

            // lineGapWidthTransition
            if (args.containsKey("lineGapWidthTransition")) {
                val transition = args["lineGapWidthTransition"] as Map<*, *>
                lineGapWidthTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineGradient
            if (args.containsKey("lineGradient")) {
                val gradient = args["lineGradient"] as String
                if (gradient.contains("[") && gradient.contains("]")) {
                    lineGradient(Expression.fromRaw(gradient))
                }
            }

            // lineMiterLimit
            if (args.containsKey("lineMiterLimit")) {
                when (val miterLimit = args["lineMiterLimit"]) {
                    is String -> if (miterLimit.contains("[") && miterLimit.contains("]")) {
                        lineMiterLimit(Expression.fromRaw(miterLimit))
                    }
                    is Double -> lineMiterLimit(miterLimit)
                    is Int -> lineMiterLimit(miterLimit.toDouble())
                    is Long -> lineMiterLimit(miterLimit.toDouble())
                }
            }

            // lineOffset
            if (args.containsKey("lineOffset")) {
                when (val offset = args["lineOffset"]) {
                    is String -> if (offset.contains("[") && offset.contains("]")) {
                        lineOffset(Expression.fromRaw(offset))
                    }
                    is Double -> lineOffset(offset)
                    is Int -> lineOffset(offset.toDouble())
                    is Long -> lineOffset(offset.toDouble())
                }
            }

            // lineOffsetTransition
            if (args.containsKey("lineOffsetTransition")) {
                val transition = args["lineOffsetTransition"] as Map<*, *>
                lineOffsetTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // linePattern
            if (args.containsKey("linePattern")) {
                val pattern = args["linePattern"] as String

                if (pattern.contains("[") && pattern.contains("]")) {
                    linePattern(Expression.fromRaw(pattern))
                } else {
                    linePattern(pattern)
                }
            }

            // linePatternTransition
            if (args.containsKey("linePatternTransition")) {
                val transition = args["linePatternTransition"] as Map<*, *>
                linePatternTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineRoundLimit
            if (args.containsKey("lineRoundLimit")) {
                when (val roundLimit = args["lineRoundLimit"]) {
                    is String -> if (roundLimit.contains("[") && roundLimit.contains("]")) {
                        lineRoundLimit(Expression.fromRaw(roundLimit))
                    }
                    is Double -> lineRoundLimit(roundLimit)
                    is Int -> lineRoundLimit(roundLimit.toDouble())
                    is Long -> lineRoundLimit(roundLimit.toDouble())
                }
            }

            // lineSortKey
            if (args.containsKey("lineSortKey")) {
                when (val sortKey = args["lineSortKey"]) {
                    is String -> if (sortKey.contains("[") && sortKey.contains("]")) {
                        lineSortKey(Expression.fromRaw(sortKey))
                    }
                    is Double -> lineSortKey(sortKey)
                    is Int -> lineSortKey(sortKey.toDouble())
                    is Long -> lineSortKey(sortKey.toDouble())
                }
            }

            // lineTranslate
            if (args.containsKey("lineTranslate")) {
                when (val translate = args["lineTranslate"]) {
                    is String -> if (translate.contains("[") && translate.contains("]")) {
                        lineTranslate(Expression.fromRaw(translate))
                    }
                    is List<*> -> if (translate.first() is Double) lineTranslate(
                        translate.map { it as Double }
                    ) else lineTranslate(translate.map { (it as Int).toDouble() })
                }
            }

            // lineTranslateTransition
            if (args.containsKey("lineTranslateTransition")) {
                val transition = args["lineTranslateTransition"] as Map<*, *>
                lineTranslateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // lineTranslateAnchor
            if (args.containsKey("lineTranslateAnchor")) {
                val translateAnchor = args["lineTranslateAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    lineTranslateAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    lineTranslateAnchor(
                        LineTranslateAnchor.valueOf(
                            translateAnchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // lineTrimOffset
            if (args.containsKey("lineTrimOffset")) {
                when (val trimOffset = args["lineTrimOffset"]) {
                    is String -> if (trimOffset.contains("[") && trimOffset.contains("]")) {
                        lineTrimOffset(Expression.fromRaw(trimOffset))
                    }
                    is List<*> -> if (trimOffset.first() is Double) lineTrimOffset(
                        trimOffset.map { it as Double }
                    ) else lineTrimOffset(trimOffset.map { (it as Int).toDouble() })
                }
            }

            // lineCap
            if (args.containsKey("lineCap")) {
                val cap = args["lineCap"] as String

                if (cap.contains("[") && cap.contains("]")) {
                    lineCap(Expression.fromRaw(cap))
                } else {
                    lineCap(
                        LineCap.valueOf(
                            cap.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // lineJoin
            if (args.containsKey("lineJoin")) {
                val translateAnchor = args["lineJoin"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    lineJoin(Expression.fromRaw(translateAnchor))
                } else {
                    lineJoin(
                        LineJoin.valueOf(
                            translateAnchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
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
                when (val zoom = args["maxZoom"]) {
                    is Double -> maxZoom(zoom)
                    is Int -> maxZoom(zoom.toDouble())
                    is Long -> maxZoom(zoom.toDouble())
                }
            }

            // minZoom
            if (args.containsKey("minZoom")) {
                when (val zoom = args["minZoom"]) {
                    is Double -> minZoom(zoom)
                    is Int -> minZoom(zoom.toDouble())
                    is Long -> minZoom(zoom.toDouble())
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