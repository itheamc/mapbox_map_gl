package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.FillLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.*
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*

/**
 * FillLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object FillLayerHelper {

    /**
     * Method to set properties got from the flutter side to FillLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): FillLayerDsl.() -> Unit {
        return {
            // fillColor
            if (args.containsKey("fillColor")) {
                when (val color = args["fillColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        fillColor(Expression.fromRaw(color))
                    } else {
                        fillColor(color)
                    }
                    is Int -> fillColor(color)
                }
            }
            // fillColorTransition
            if (args.containsKey("fillColorTransition")) {
                val transition = args["fillColorTransition"] as Map<*, *>
                fillColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillAntialias
            if (args.containsKey("fillAntialias")) {
                when (val antiAlias = args["fillAntialias"]) {
                    is String -> if (antiAlias.contains("[") && antiAlias.contains("]")) {
                        fillAntialias(Expression.fromRaw(antiAlias))
                    }
                    is Boolean -> fillAntialias(antiAlias)
                }
            }

            // fillOpacity
            if (args.containsKey("fillOpacity")) {
                when (val opacity = args["fillOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        fillOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> fillOpacity(opacity)
                }
            }
            // fillOpacityTransition
            if (args.containsKey("fillOpacityTransition")) {
                val transition = args["fillOpacityTransition"] as Map<*, *>
                fillOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillOutlineColor
            if (args.containsKey("fillOutlineColor")) {
                when (val color = args["fillOutlineColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        fillOutlineColor(Expression.fromRaw(color))
                    } else {
                        fillOutlineColor(color)
                    }
                    is Int -> fillOutlineColor(color)
                }
            }
            // fillOutlineColorTransition
            if (args.containsKey("fillOutlineColorTransition")) {
                val transition = args["fillOutlineColorTransition"] as Map<*, *>
                fillOutlineColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillPattern
            if (args.containsKey("fillPattern")) {
                val pattern = args["fillPattern"] as String

                if (pattern.contains("[") && pattern.contains("]")) {
                    fillPattern(Expression.fromRaw(pattern))
                } else {
                    fillPattern(pattern)
                }
            }

            // fillPatternTransition
            if (args.containsKey("fillPatternTransition")) {
                val transition = args["fillPatternTransition"] as Map<*, *>
                fillPatternTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }


            // fillSortKey
            if (args.containsKey("fillSortKey")) {
                when (val sortKey = args["fillSortKey"]) {
                    is String -> if (sortKey.contains("[") && sortKey.contains("]")) {
                        fillSortKey(Expression.fromRaw(sortKey))
                    }
                    is Double -> fillSortKey(sortKey)
                }
            }

            // fillTranslate
            if (args.containsKey("fillTranslate")) {
                when (val translate = args["fillTranslate"]) {
                    is String -> if (translate.contains("[") && translate.contains("]")) {
                        fillTranslate(Expression.fromRaw(translate))
                    }
                    is List<*> -> if (translate.first() is Double) fillTranslate(
                        translate.map { it as Double }
                    ) else fillTranslate(translate.map { (it as Int).toDouble() })
                }
            }

            // fillTranslateTransition
            if (args.containsKey("fillTranslateTransition")) {
                val transition = args["fillTranslateTransition"] as Map<*, *>
                fillTranslateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // fillTranslateAnchor
            if (args.containsKey("fillTranslateAnchor")) {
                val translateAnchor = args["fillTranslateAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    fillTranslateAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    fillTranslateAnchor(
                        FillTranslateAnchor.valueOf(
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