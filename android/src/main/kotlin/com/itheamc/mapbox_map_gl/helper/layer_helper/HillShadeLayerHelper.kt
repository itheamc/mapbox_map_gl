package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.HillshadeLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.HillshadeIlluminationAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.Visibility
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*

/**
 * HillShadeLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object HillShadeLayerHelper {

    /**
     * Method to set properties got from the flutter side to HillshadeLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): HillshadeLayerDsl.() -> Unit {

        return {

            // hillShadeAccentColor
            if (args.containsKey("hillShadeAccentColor")) {
                when (val color = args["hillShadeAccentColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        hillshadeAccentColor(Expression.fromRaw(color))
                    } else {
                        hillshadeAccentColor(color)
                    }
                    is Int -> hillshadeAccentColor(color)
                }
            }

            // hillShadeAccentColorTransition
            if (args.containsKey("hillShadeAccentColorTransition")) {
                val transition = args["hillShadeAccentColorTransition"] as Map<*, *>
                hillshadeAccentColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // hillShadeExaggeration
            if (args.containsKey("hillShadeExaggeration")) {
                when (val value = args["hillShadeExaggeration"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        hillshadeExaggeration(Expression.fromRaw(value))
                    }
                    is Double -> hillshadeExaggeration(value)
                    is Int -> hillshadeExaggeration(value.toDouble())
                    is Long -> hillshadeExaggeration(value.toDouble())
                }
            }

            // hillShadeExaggerationTransition
            if (args.containsKey("hillShadeExaggerationTransition")) {
                val transition = args["hillShadeExaggerationTransition"] as Map<*, *>
                hillshadeExaggerationTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // hillShadeHighlightColor
            if (args.containsKey("hillShadeHighlightColor")) {
                when (val color = args["hillShadeHighlightColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        hillshadeHighlightColor(Expression.fromRaw(color))
                    } else {
                        hillshadeHighlightColor(color)
                    }
                    is Int -> hillshadeHighlightColor(color)
                }
            }

            // hillShadeHighlightColorTransition
            if (args.containsKey("hillShadeHighlightColorTransition")) {
                val transition = args["hillShadeHighlightColorTransition"] as Map<*, *>
                hillshadeHighlightColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // hillShadeIlluminationAnchor
            if (args.containsKey("hillShadeIlluminationAnchor")) {
                val translateAnchor = args["hillShadeIlluminationAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    hillshadeIlluminationAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    hillshadeIlluminationAnchor(
                        HillshadeIlluminationAnchor.valueOf(
                            translateAnchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // hillShadeIlluminationDirection
            if (args.containsKey("hillShadeIlluminationDirection")) {
                when (val value = args["hillShadeIlluminationDirection"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        hillshadeIlluminationDirection(Expression.fromRaw(value))
                    }
                    is Double -> hillshadeIlluminationDirection(value)
                    is Int -> hillshadeIlluminationDirection(value.toDouble())
                    is Long -> hillshadeIlluminationDirection(value.toDouble())
                }
            }

            // hillShadeShadowColor
            if (args.containsKey("hillShadeShadowColor")) {
                when (val color = args["hillShadeShadowColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        hillshadeShadowColor(Expression.fromRaw(color))
                    } else {
                        hillshadeShadowColor(color)
                    }
                    is Int -> hillshadeShadowColor(color)
                }
            }

            // hillShadeShadowColorTransition
            if (args.containsKey("hillShadeShadowColorTransition")) {
                val transition = args["hillShadeShadowColorTransition"] as Map<*, *>
                hillshadeShadowColorTransition(
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
            if (args.containsKey("visibility") && args["visibility"] is Boolean) {
                val visible = args["visibility"] as Boolean
                visibility(if (visible) Visibility.VISIBLE else Visibility.NONE)
            }
        }
    }
}