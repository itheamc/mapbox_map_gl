package com.itheamc.mapbox_map_gl.helper.layer_helper

import com.mapbox.maps.extension.style.expressions.generated.Expression
import com.mapbox.maps.extension.style.layers.generated.SymbolLayerDsl
import com.mapbox.maps.extension.style.layers.properties.generated.*
import com.mapbox.maps.extension.style.types.StyleTransition
import java.util.*

/**
 * SymbolLayerHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object SymbolLayerHelper {

    /**
     * Method to set properties got from the flutter side to SymbolLayerDsl block
     */
    fun blockFromArgs(args: Map<*, *>): SymbolLayerDsl.() -> Unit {

        return {

            // iconAllowOverlap
            if (args.containsKey("iconAllowOverlap")) {
                when (val value = args["iconAllowOverlap"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        iconAllowOverlap(Expression.fromRaw(value))
                    }
                    is Boolean -> iconAllowOverlap(value)
                }
            }

            // iconAnchor
            if (args.containsKey("iconAnchor")) {
                val anchor = args["iconAnchor"] as String

                if (anchor.contains("[") && anchor.contains("]")) {
                    iconAnchor(Expression.fromRaw(anchor))
                } else {
                    iconAnchor(
                        IconAnchor.valueOf(
                            anchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // iconIgnorePlacement
            if (args.containsKey("iconIgnorePlacement")) {
                when (val value = args["iconIgnorePlacement"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        iconIgnorePlacement(Expression.fromRaw(value))
                    }
                    is Boolean -> iconIgnorePlacement(value)
                }
            }

            // iconImage
            if (args.containsKey("iconImage")) {
                val image = args["iconImage"] as String

                if (image.contains("[") && image.contains("]")) {
                    iconImage(Expression.fromRaw(image))
                } else {
                    iconImage(image)
                }
            }

            // iconKeepUpright
            if (args.containsKey("iconKeepUpright")) {
                when (val value = args["iconKeepUpright"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        iconKeepUpright(Expression.fromRaw(value))
                    }
                    is Boolean -> iconKeepUpright(value)
                }
            }

            // iconOffset
            if (args.containsKey("iconOffset")) {
                when (val offset = args["iconOffset"]) {
                    is String -> if (offset.contains("[") && offset.contains("]")) {
                        iconOffset(Expression.fromRaw(offset))
                    }
                    is List<*> -> if (offset.size == 2) {
                        if (offset.first() is Double) iconOffset(
                            offset.map { it as Double }
                        ) else iconOffset(offset.map { (it as Int).toDouble() })
                    }
                }
            }

            // iconOptional
            if (args.containsKey("iconOptional")) {
                when (val value = args["iconOptional"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        iconOptional(Expression.fromRaw(value))
                    }
                    is Boolean -> iconOptional(value)
                }
            }

            // iconPadding
            if (args.containsKey("iconPadding")) {
                when (val padding = args["iconPadding"]) {
                    is String -> if (padding.contains("[") && padding.contains("]")) {
                        iconPadding(Expression.fromRaw(padding))
                    }
                    is Double -> iconPadding(padding)
                    is Int -> iconPadding(padding.toDouble())
                    is Long -> iconPadding(padding.toDouble())
                }
            }

            // iconPitchAlignment
            if (args.containsKey("iconPitchAlignment")) {
                val alignment = args["iconPitchAlignment"] as String

                if (alignment.contains("[") && alignment.contains("]")) {
                    iconPitchAlignment(Expression.fromRaw(alignment))
                } else {
                    iconPitchAlignment(
                        IconPitchAlignment.valueOf(
                            alignment.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // iconRotate
            if (args.containsKey("iconRotate")) {
                when (val rotate = args["iconRotate"]) {
                    is String -> if (rotate.contains("[") && rotate.contains("]")) {
                        iconRotate(Expression.fromRaw(rotate))
                    }
                    is Double -> iconRotate(rotate)
                    is Int -> iconRotate(rotate.toDouble())
                    is Long -> iconRotate(rotate.toDouble())
                }
            }

            // iconRotationAlignment
            if (args.containsKey("iconRotationAlignment")) {
                val alignment = args["iconRotationAlignment"] as String

                if (alignment.contains("[") && alignment.contains("]")) {
                    iconRotationAlignment(Expression.fromRaw(alignment))
                } else {
                    iconRotationAlignment(
                        IconRotationAlignment.valueOf(
                            alignment.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // iconSize
            if (args.containsKey("iconSize")) {
                when (val size = args["iconSize"]) {
                    is String -> if (size.contains("[") && size.contains("]")) {
                        iconSize(Expression.fromRaw(size))
                    }
                    is Double -> iconSize(size)
                    is Int -> iconSize(size.toDouble())
                    is Long -> iconSize(size.toDouble())
                }
            }

            // iconTextFit
            if (args.containsKey("iconTextFit")) {
                val textFit = args["iconTextFit"] as String

                if (textFit.contains("[") && textFit.contains("]")) {
                    iconTextFit(Expression.fromRaw(textFit))
                } else {
                    iconTextFit(
                        IconTextFit.valueOf(
                            textFit.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // iconTextFitPadding
            if (args.containsKey("iconTextFitPadding")) {
                when (val padding = args["iconTextFitPadding"]) {
                    is String -> if (padding.contains("[") && padding.contains("]")) {
                        iconTextFitPadding(Expression.fromRaw(padding))
                    }
                    is List<*> -> if (padding.size == 4) {
                        if (padding.first() is Double) iconTextFitPadding(
                            padding.map { it as Double }
                        ) else iconTextFitPadding(padding.map { (it as Int).toDouble() })
                    }
                }
            }

            // symbolAvoidEdges
            if (args.containsKey("symbolAvoidEdges")) {
                when (val value = args["symbolAvoidEdges"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        symbolAvoidEdges(Expression.fromRaw(value))
                    }
                    is Boolean -> symbolAvoidEdges(value)
                }
            }

            // symbolPlacement
            if (args.containsKey("symbolPlacement")) {
                val placement = args["symbolPlacement"] as String

                if (placement.contains("[") && placement.contains("]")) {
                    symbolPlacement(Expression.fromRaw(placement))
                } else {
                    symbolPlacement(
                        SymbolPlacement.valueOf(
                            placement.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // symbolSortKey
            if (args.containsKey("symbolSortKey")) {
                when (val sortKey = args["symbolSortKey"]) {
                    is String -> if (sortKey.contains("[") && sortKey.contains("]")) {
                        symbolSortKey(Expression.fromRaw(sortKey))
                    }
                    is Double -> symbolSortKey(sortKey)
                    is Int -> symbolSortKey(sortKey.toDouble())
                    is Long -> symbolSortKey(sortKey.toDouble())
                }
            }

            // symbolSpacing
            if (args.containsKey("symbolSpacing")) {
                when (val spacing = args["symbolSpacing"]) {
                    is String -> if (spacing.contains("[") && spacing.contains("]")) {
                        symbolSpacing(Expression.fromRaw(spacing))
                    }
                    is Double -> symbolSpacing(spacing)
                    is Int -> symbolSpacing(spacing.toDouble())
                    is Long -> symbolSpacing(spacing.toDouble())
                }
            }

            // symbolZOrder
            if (args.containsKey("symbolZOrder")) {
                val zOrder = args["symbolZOrder"] as String

                if (zOrder.contains("[") && zOrder.contains("]")) {
                    symbolZOrder(Expression.fromRaw(zOrder))
                } else {
                    symbolZOrder(
                        SymbolZOrder.valueOf(
                            zOrder.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textAllowOverlap
            if (args.containsKey("textAllowOverlap")) {
                when (val value = args["textAllowOverlap"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        textAllowOverlap(Expression.fromRaw(value))
                    }
                    is Boolean -> textAllowOverlap(value)
                }
            }

            // textAnchor
            if (args.containsKey("textAnchor")) {
                val anchor = args["textAnchor"] as String

                if (anchor.contains("[") && anchor.contains("]")) {
                    textAnchor(Expression.fromRaw(anchor))
                } else {
                    textAnchor(
                        TextAnchor.valueOf(
                            anchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textField
            if (args.containsKey("textField")) {
                val value = args["textField"] as String

                if (value.contains("[") && value.contains("]")) {
                    textField(Expression.fromRaw(value))
                } else {
                    textField(value)
                }
            }

            // textFont
            if (args.containsKey("textFont")) {
                when (val font = args["textFont"]) {
                    is String -> if (font.contains("[") && font.contains("]")) {
                        textFont(Expression.fromRaw(font))
                    }
                    is List<*> -> if (font.first() is String) {
                        textFont(
                            font.map { if (it is String) it else it.toString() }
                        )
                    }
                }
            }

            // textIgnorePlacement
            if (args.containsKey("textIgnorePlacement")) {
                when (val value = args["textIgnorePlacement"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        textIgnorePlacement(Expression.fromRaw(value))
                    }
                    is Boolean -> textIgnorePlacement(value)
                }
            }

            // textJustify
            if (args.containsKey("textJustify")) {
                val justify = args["textJustify"] as String

                if (justify.contains("[") && justify.contains("]")) {
                    textJustify(Expression.fromRaw(justify))
                } else {
                    textJustify(
                        TextJustify.valueOf(
                            justify.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textKeepUpright
            if (args.containsKey("textKeepUpright")) {
                when (val value = args["textKeepUpright"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        textKeepUpright(Expression.fromRaw(value))
                    }
                    is Boolean -> textKeepUpright(value)
                }
            }

            // textLetterSpacing
            if (args.containsKey("textLetterSpacing")) {
                when (val spacing = args["textLetterSpacing"]) {
                    is String -> if (spacing.contains("[") && spacing.contains("]")) {
                        textLetterSpacing(Expression.fromRaw(spacing))
                    }
                    is Double -> textLetterSpacing(spacing)
                    is Int -> textLetterSpacing(spacing.toDouble())
                    is Long -> textLetterSpacing(spacing.toDouble())
                }
            }

            // textLineHeight
            if (args.containsKey("textLineHeight")) {
                when (val lineHeight = args["textLineHeight"]) {
                    is String -> if (lineHeight.contains("[") && lineHeight.contains("]")) {
                        textLineHeight(Expression.fromRaw(lineHeight))
                    }
                    is Double -> textLineHeight(lineHeight)
                    is Int -> textLineHeight(lineHeight.toDouble())
                    is Long -> textLineHeight(lineHeight.toDouble())
                }
            }

            // textMaxAngle
            if (args.containsKey("textMaxAngle")) {
                when (val angle = args["textMaxAngle"]) {
                    is String -> if (angle.contains("[") && angle.contains("]")) {
                        textMaxAngle(Expression.fromRaw(angle))
                    }
                    is Double -> textMaxAngle(angle)
                    is Int -> textMaxAngle(angle.toDouble())
                    is Long -> textMaxAngle(angle.toDouble())
                }
            }

            // textMaxWidth
            if (args.containsKey("textMaxWidth")) {
                when (val width = args["textMaxWidth"]) {
                    is String -> if (width.contains("[") && width.contains("]")) {
                        textMaxWidth(Expression.fromRaw(width))
                    }
                    is Double -> textMaxWidth(width)
                    is Int -> textMaxWidth(width.toDouble())
                    is Long -> textMaxWidth(width.toDouble())
                }
            }

            // textOffset
            if (args.containsKey("textOffset")) {
                when (val offset = args["textOffset"]) {
                    is String -> if (offset.contains("[") && offset.contains("]")) {
                        textOffset(Expression.fromRaw(offset))
                    }
                    is List<*> -> if (offset.size == 2) {
                        if (offset.first() is Double) textOffset(
                            offset.map { it as Double }
                        ) else textOffset(offset.map { (it as Int).toDouble() })
                    }
                }
            }

            // textOptional
            if (args.containsKey("textOptional")) {
                when (val value = args["textOptional"]) {
                    is String -> if (value.contains("[") && value.contains("]")) {
                        textOptional(Expression.fromRaw(value))
                    }
                    is Boolean -> textOptional(value)
                }
            }

            // textPadding
            if (args.containsKey("textPadding")) {
                when (val padding = args["textPadding"]) {
                    is String -> if (padding.contains("[") && padding.contains("]")) {
                        textPadding(Expression.fromRaw(padding))
                    }
                    is Double -> textPadding(padding)
                    is Int -> textPadding(padding.toDouble())
                    is Long -> textPadding(padding.toDouble())
                }
            }

            // textPitchAlignment
            if (args.containsKey("textPitchAlignment")) {
                val alignment = args["textPitchAlignment"] as String

                if (alignment.contains("[") && alignment.contains("]")) {
                    textPitchAlignment(Expression.fromRaw(alignment))
                } else {
                    textPitchAlignment(
                        TextPitchAlignment.valueOf(
                            alignment.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textRadialOffset
            if (args.containsKey("textRadialOffset")) {
                when (val offset = args["textRadialOffset"]) {
                    is String -> if (offset.contains("[") && offset.contains("]")) {
                        textRadialOffset(Expression.fromRaw(offset))
                    }
                    is Double -> textRadialOffset(offset)
                    is Int -> textRadialOffset(offset.toDouble())
                    is Long -> textRadialOffset(offset.toDouble())
                }
            }

            // textRotate
            if (args.containsKey("textRotate")) {
                when (val rotate = args["textRotate"]) {
                    is String -> if (rotate.contains("[") && rotate.contains("]")) {
                        textRotate(Expression.fromRaw(rotate))
                    }
                    is Double -> textRotate(rotate)
                    is Int -> textRotate(rotate.toDouble())
                    is Long -> textRotate(rotate.toDouble())
                }
            }

            // textRotationAlignment
            if (args.containsKey("textRotationAlignment")) {
                val alignment = args["textRotationAlignment"] as String

                if (alignment.contains("[") && alignment.contains("]")) {
                    textRotationAlignment(Expression.fromRaw(alignment))
                } else {
                    textRotationAlignment(
                        TextRotationAlignment.valueOf(
                            alignment.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textSize
            if (args.containsKey("textSize")) {
                when (val size = args["textSize"]) {
                    is String -> if (size.contains("[") && size.contains("]")) {
                        textSize(Expression.fromRaw(size))
                    }
                    is Double -> textSize(size)
                    is Int -> textSize(size.toDouble())
                    is Long -> textSize(size.toDouble())
                }
            }

            // textTransform
            if (args.containsKey("textTransform")) {
                val alignment = args["textTransform"] as String

                if (alignment.contains("[") && alignment.contains("]")) {
                    textTransform(Expression.fromRaw(alignment))
                } else {
                    textTransform(
                        TextTransform.valueOf(
                            alignment.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textVariableAnchor
            if (args.containsKey("textVariableAnchor")) {
                when (val anchor = args["textVariableAnchor"]) {
                    is String -> if (anchor.contains("[") && anchor.contains("]")) {
                        textVariableAnchor(Expression.fromRaw(anchor))
                    }
                    is List<*> -> if (anchor.first() is String) {
                        textVariableAnchor(
                            anchor.map { if (it is String) it else it.toString() }
                        )
                    }
                }
            }

            // textWritingMode
            if (args.containsKey("textWritingMode")) {
                when (val mode = args["textWritingMode"]) {
                    is String -> if (mode.contains("[") && mode.contains("]")) {
                        textWritingMode(Expression.fromRaw(mode))
                    }
                    is List<*> -> if (mode.first() is String) {
                        textWritingMode(
                            mode.map { if (it is String) it else it.toString() }
                        )
                    }
                }
            }

            // iconColor
            if (args.containsKey("iconColor")) {
                when (val color = args["iconColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        iconColor(Expression.fromRaw(color))
                    } else {
                        iconColor(color)
                    }
                    is Int -> iconColor(color)
                }
            }

            // iconColorTransition
            if (args.containsKey("iconColorTransition")) {
                val transition = args["iconColorTransition"] as Map<*, *>
                iconColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // iconHaloBlur
            if (args.containsKey("iconHaloBlur")) {
                when (val blur = args["iconHaloBlur"]) {
                    is String -> if (blur.contains("[") && blur.contains("]")) {
                        iconHaloBlur(Expression.fromRaw(blur))
                    }
                    is Double -> iconHaloBlur(blur)
                    is Int -> iconHaloBlur(blur.toDouble())
                    is Long -> iconHaloBlur(blur.toDouble())
                }
            }

            // iconHaloBlurTransition
            if (args.containsKey("iconHaloBlurTransition")) {
                val transition = args["iconHaloBlurTransition"] as Map<*, *>
                iconHaloBlurTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // iconHaloColor
            if (args.containsKey("iconHaloColor")) {
                when (val color = args["iconHaloColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        iconHaloColor(Expression.fromRaw(color))
                    } else {
                        iconHaloColor(color)
                    }
                    is Int -> iconHaloColor(color)
                }
            }

            // iconHaloColorTransition
            if (args.containsKey("iconHaloColorTransition")) {
                val transition = args["iconHaloColorTransition"] as Map<*, *>
                iconHaloColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // iconHaloWidth
            if (args.containsKey("iconHaloWidth")) {
                when (val width = args["iconHaloWidth"]) {
                    is String -> if (width.contains("[") && width.contains("]")) {
                        iconHaloWidth(Expression.fromRaw(width))
                    }
                    is Double -> iconHaloWidth(width)
                    is Int -> iconHaloWidth(width.toDouble())
                    is Long -> iconHaloWidth(width.toDouble())
                }
            }

            // iconHaloWidthTransition
            if (args.containsKey("iconHaloWidthTransition")) {
                val transition = args["iconHaloWidthTransition"] as Map<*, *>
                iconHaloWidthTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // iconOpacity
            if (args.containsKey("iconOpacity")) {
                when (val opacity = args["iconOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        iconOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> iconOpacity(opacity)
                    is Int -> iconOpacity(opacity.toDouble())
                    is Long -> iconOpacity(opacity.toDouble())
                }
            }

            // iconOpacityTransition
            if (args.containsKey("iconOpacityTransition")) {
                val transition = args["iconOpacityTransition"] as Map<*, *>
                iconOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // iconTranslate
            if (args.containsKey("iconTranslate")) {
                when (val translate = args["iconTranslate"]) {
                    is String -> if (translate.contains("[") && translate.contains("]")) {
                        iconTranslate(Expression.fromRaw(translate))
                    }
                    is List<*> -> if (translate.size == 2) {
                        if (translate.first() is Double) iconTranslate(
                            translate.map { it as Double }
                        ) else iconTranslate(translate.map { (it as Int).toDouble() })
                    }
                }
            }

            // iconTranslateTransition
            if (args.containsKey("iconTranslateTransition")) {
                val transition = args["iconTranslateTransition"] as Map<*, *>
                iconTranslateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // iconTranslateAnchor
            if (args.containsKey("iconTranslateAnchor")) {
                val translateAnchor = args["iconTranslateAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    iconTranslateAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    iconTranslateAnchor(
                        IconTranslateAnchor.valueOf(
                            translateAnchor.uppercase(
                                Locale.ENGLISH
                            ).replace("-", "_")
                        )
                    )
                }
            }

            // textColor
            if (args.containsKey("textColor")) {
                when (val color = args["textColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        textColor(Expression.fromRaw(color))
                    } else {
                        textColor(color)
                    }
                    is Int -> textColor(color)
                }
            }

            // textColorTransition
            if (args.containsKey("textColorTransition")) {
                val transition = args["textColorTransition"] as Map<*, *>
                textColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // textHaloBlur
            if (args.containsKey("textHaloBlur")) {
                when (val blur = args["textHaloBlur"]) {
                    is String -> if (blur.contains("[") && blur.contains("]")) {
                        textHaloBlur(Expression.fromRaw(blur))
                    }
                    is Double -> textHaloBlur(blur)
                    is Int -> textHaloBlur(blur.toDouble())
                    is Long -> textHaloBlur(blur.toDouble())
                }
            }

            // textHaloBlurTransition
            if (args.containsKey("textHaloBlurTransition")) {
                val transition = args["textHaloBlurTransition"] as Map<*, *>
                textHaloBlurTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // textHaloColor
            if (args.containsKey("textHaloColor")) {
                when (val color = args["textHaloColor"]) {
                    is String -> if (color.contains("[") && color.contains("]")) {
                        textHaloColor(Expression.fromRaw(color))
                    } else {
                        textHaloColor(color)
                    }
                    is Int -> textHaloColor(color)
                }
            }

            // textHaloColorTransition
            if (args.containsKey("textHaloColorTransition")) {
                val transition = args["textHaloColorTransition"] as Map<*, *>
                textHaloColorTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // textHaloWidth
            if (args.containsKey("textHaloWidth")) {
                when (val width = args["textHaloWidth"]) {
                    is String -> if (width.contains("[") && width.contains("]")) {
                        textHaloWidth(Expression.fromRaw(width))
                    }
                    is Double -> textHaloWidth(width)
                    is Int -> textHaloWidth(width.toDouble())
                    is Long -> textHaloWidth(width.toDouble())
                }
            }

            // textHaloWidthTransition
            if (args.containsKey("textHaloWidthTransition")) {
                val transition = args["textHaloWidthTransition"] as Map<*, *>
                textHaloWidthTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // textOpacity
            if (args.containsKey("textOpacity")) {
                when (val opacity = args["textOpacity"]) {
                    is String -> if (opacity.contains("[") && opacity.contains("]")) {
                        textOpacity(Expression.fromRaw(opacity))
                    }
                    is Double -> textOpacity(opacity)
                    is Int -> textOpacity(opacity.toDouble())
                    is Long -> textOpacity(opacity.toDouble())
                }
            }

            // textOpacityTransition
            if (args.containsKey("textOpacityTransition")) {
                val transition = args["textOpacityTransition"] as Map<*, *>
                textOpacityTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // textTranslate
            if (args.containsKey("textTranslate")) {
                when (val translate = args["textTranslate"]) {
                    is String -> if (translate.contains("[") && translate.contains("]")) {
                        textTranslate(Expression.fromRaw(translate))
                    }
                    is List<*> -> if (translate.size == 2) {
                        if (translate.first() is Double) textTranslate(
                            translate.map { it as Double }
                        ) else textTranslate(translate.map { (it as Int).toDouble() })
                    }
                }
            }

            // textTranslateTransition
            if (args.containsKey("textTranslateTransition")) {
                val transition = args["textTranslateTransition"] as Map<*, *>
                textTranslateTransition(
                    StyleTransition.Builder()
                        .delay((transition["delay"] as Int).toLong())
                        .duration((transition["duration"] as Int).toLong())
                        .build()
                )
            }

            // textTranslateAnchor
            if (args.containsKey("textTranslateAnchor")) {
                val translateAnchor = args["textTranslateAnchor"] as String

                if (translateAnchor.contains("[") && translateAnchor.contains("]")) {
                    textTranslateAnchor(Expression.fromRaw(translateAnchor))
                } else {
                    textTranslateAnchor(
                        TextTranslateAnchor.valueOf(
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