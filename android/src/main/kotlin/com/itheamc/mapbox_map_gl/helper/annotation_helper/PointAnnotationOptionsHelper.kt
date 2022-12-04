package com.itheamc.mapbox_map_gl.helper.annotation_helper

import android.graphics.BitmapFactory
import android.util.Log
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.itheamc.mapbox_map_gl.helper.PointHelper
import com.mapbox.maps.extension.style.layers.properties.generated.IconAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.TextAnchor
import com.mapbox.maps.extension.style.layers.properties.generated.TextJustify
import com.mapbox.maps.extension.style.layers.properties.generated.TextTransform
import com.mapbox.maps.plugin.annotation.generated.PointAnnotationOptions

/**
 * PointAnnotationOptionsHelper.kt
 *
 * Created by Amit Chaudhary, 2022/11/21
 */
internal object PointAnnotationOptionsHelper {
    private const val TAG = "PointAnnotationOptions"

    /**
     * Method to create PointAnnotationOptions object from the args
     */
    fun fromArgs(args: Map<*, *>): PointAnnotationOptions {

        if (args.isEmpty()) return PointAnnotationOptions()

        val iconArgs = args["iconImage"]
        val optionsArgs = args["annotationOptions"] as Map<*, *>

        return PointAnnotationOptions().apply {

            if (optionsArgs.containsKey("point")) {
                when (val pointArgs = optionsArgs["point"]) {
                    is Map<*, *> -> {
                        val point = PointHelper.fromArgs(pointArgs)
                        point?.let {
                            withPoint(it)
                        }
                    }
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid point coordinate value!!"
                    )
                }
            }

            if (iconArgs != null) {
                when (iconArgs) {
                    is String -> withIconImage(iconArgs)
                    is ByteArray -> {
                        try {
                            val bitmap = BitmapFactory.decodeByteArray(iconArgs, 0, iconArgs.size)
                            withIconImage(bitmap)
                        } catch (e: Exception) {
                            Log.e(
                                TAG,
                                "PointAnnotationOptionsHelper.withIconImage: ${e.message}",
                                e
                            )
                        }
                    }
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid point coordinate value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconColor")) {
                when (val color = optionsArgs["iconColor"]) {
                    is String -> withIconColor(color)
                    is Int -> withIconColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon color value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconOpacity")) {
                when (val opacity = optionsArgs["iconOpacity"]) {
                    is Double -> withIconOpacity(opacity)
                    is Long -> withIconOpacity(opacity.toDouble())
                    is Int -> withIconOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon opacity value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconSize")) {
                when (val size = optionsArgs["iconSize"]) {
                    is Double -> withIconSize(size)
                    is Long -> withIconSize(size.toDouble())
                    is Int -> withIconSize(size.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon size value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconRotate")) {
                when (val rotate = optionsArgs["iconRotate"]) {
                    is Double -> withIconRotate(rotate)
                    is Long -> withIconRotate(rotate.toDouble())
                    is Int -> withIconRotate(rotate.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon rotate value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconAnchor")) {
                when (val anchor = optionsArgs["iconAnchor"]) {
                    is String -> withIconAnchor(IconAnchor.valueOf(anchor.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon anchor value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconOffset")) {
                when (val offset = optionsArgs["iconOffset"]) {
                    is List<*> -> if (offset.size == 2) {
                        if (offset.first() is Double) withIconOffset(
                            offset.map { it as Double }
                        ) else if (offset.first() is Long) withIconOffset(offset.map { (it as Long).toDouble() })
                        else withIconOffset(offset.map { (it as Int).toDouble() })
                    }
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon offset value!!"
                    )

                }
            }

            if (optionsArgs.containsKey("iconHaloColor")) {
                when (val color = optionsArgs["iconHaloColor"]) {
                    is String -> withIconHaloColor(color)
                    is Int -> withIconHaloColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon halo color value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconHaloBlur")) {
                when (val blur = optionsArgs["iconHaloBlur"]) {
                    is Double -> withIconHaloBlur(blur)
                    is Long -> withIconHaloBlur(blur.toDouble())
                    is Int -> withIconHaloBlur(blur.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon halo blur value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("iconHaloWidth")) {
                when (val haloWidth = optionsArgs["iconHaloWidth"]) {
                    is Double -> withIconHaloWidth(haloWidth)
                    is Long -> withIconHaloWidth(haloWidth.toDouble())
                    is Int -> withIconHaloWidth(haloWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon halo width value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textField")) {
                when (val field = optionsArgs["textField"]) {
                    is String -> withTextField(field)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text field value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textColor")) {
                when (val color = optionsArgs["textColor"]) {
                    is String -> withTextColor(color)
                    is Int -> withTextColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text color value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textOpacity")) {
                when (val opacity = optionsArgs["textOpacity"]) {
                    is Double -> withTextOpacity(opacity)
                    is Long -> withTextOpacity(opacity.toDouble())
                    is Int -> withTextOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text opacity value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textSize")) {
                when (val size = optionsArgs["textSize"]) {
                    is Double -> withTextSize(size)
                    is Int -> withTextSize(size.toDouble())
                    is Long -> withTextSize(size.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text size value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textRotate")) {
                when (val rotate = optionsArgs["textRotate"]) {
                    is Double -> withTextRotate(rotate)
                    is Int -> withTextRotate(rotate.toDouble())
                    is Long -> withTextRotate(rotate.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text rotate value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textLetterSpacing")) {
                when (val spacing = optionsArgs["textLetterSpacing"]) {
                    is Double -> withTextLetterSpacing(spacing)
                    is Int -> withTextLetterSpacing(spacing.toDouble())
                    is Long -> withTextLetterSpacing(spacing.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text letter spacing value!!"
                    )

                }
            }

            if (optionsArgs.containsKey("textLineHeight")) {
                when (val lineHeight = optionsArgs["textLineHeight"]) {
                    is Double -> withTextLineHeight(lineHeight)
                    is Int -> withTextLineHeight(lineHeight.toDouble())
                    is Long -> withTextLineHeight(lineHeight.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text line height value!!"
                    )

                }
            }

            if (optionsArgs.containsKey("textOffset")) {
                when (val offset = optionsArgs["textOffset"]) {
                    is List<*> -> if (offset.size == 2) {
                        if (offset.first() is Double) withTextOffset(
                            offset.map { it as Double }
                        ) else if (offset.first() is Long) withTextOffset(offset.map { (it as Long).toDouble() })
                        else withTextOffset(offset.map { (it as Int).toDouble() })
                    }
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text offset value!!"
                    )

                }
            }

            if (optionsArgs.containsKey("textHaloColor")) {
                when (val color = optionsArgs["textHaloColor"]) {
                    is String -> withTextHaloColor(color)
                    is Int -> withTextHaloColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text halo color value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textHaloBlur")) {
                when (val blur = optionsArgs["textHaloBlur"]) {
                    is Double -> withTextHaloBlur(blur)
                    is Long -> withTextHaloBlur(blur.toDouble())
                    is Int -> withTextHaloBlur(blur.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text halo blur value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textHaloWidth")) {
                when (val haloWidth = optionsArgs["textHaloWidth"]) {
                    is Double -> withTextHaloWidth(haloWidth)
                    is Long -> withTextHaloWidth(haloWidth.toDouble())
                    is Int -> withTextHaloWidth(haloWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text halo width value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textMaxWidth")) {
                when (val maxWidth = optionsArgs["textMaxWidth"]) {
                    is Double -> withTextMaxWidth(maxWidth)
                    is Long -> withTextMaxWidth(maxWidth.toDouble())
                    is Int -> withTextMaxWidth(maxWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text max width value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textRadialOffset")) {
                when (val offset = optionsArgs["textRadialOffset"]) {
                    is Double -> withTextRadialOffset(offset)
                    is Long -> withTextRadialOffset(offset.toDouble())
                    is Int -> withTextRadialOffset(offset.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text radical offset value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("symbolSortKey")) {
                when (val sortKey = optionsArgs["symbolSortKey"]) {
                    is Double -> withSymbolSortKey(sortKey)
                    is Long -> withSymbolSortKey(sortKey.toDouble())
                    is Int -> withSymbolSortKey(sortKey.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid symbol sort key value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textAnchor")) {
                when (val anchor = optionsArgs["textAnchor"]) {
                    is String -> withTextAnchor(TextAnchor.valueOf(anchor.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text anchor value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textJustify")) {
                when (val justify = optionsArgs["textJustify"]) {
                    is String -> withTextJustify(TextJustify.valueOf(justify.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text justify value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("textTransform")) {
                when (val transform = optionsArgs["textTransform"]) {
                    is String -> withTextTransform(TextTransform.valueOf(transform.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text transform value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("draggable")) {
                when (val drag = optionsArgs["draggable"]) {
                    is Boolean -> withDraggable(drag)
                    else -> Log.d(
                        TAG, "[PointAnnotationOptionsHelper.fromArgs]: Invalid draggable value!!"
                    )
                }
            }

            if (optionsArgs.containsKey("data")) {
                when (val data = optionsArgs["data"]) {
                    is String -> withData(Gson().fromJson(data, JsonElement::class.java))
                    else -> Log.d(
                        TAG, "[PointAnnotationOptionsHelper.fromArgs]: Invalid data value!!"
                    )
                }
            }
        }
    }
}