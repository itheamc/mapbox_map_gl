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

        return PointAnnotationOptions().apply {

            if (args.containsKey("point")) {
                when (val pointArgs = args["point"]) {
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

            if (args.containsKey("iconImage")) {
                val byteArray =
                    if (args["iconImage"] != null) args["iconImage"] as ByteArray else null

                byteArray?.let { byteArr ->
                    try {
                        val bitmap = BitmapFactory.decodeByteArray(byteArr, 0, byteArr.size)
                        withIconImage(bitmap)
                    } catch (e: Exception) {
                        Log.e(TAG, "PointAnnotationOptionsHelper.withIconImage: ${e.message}", e)
                    }
                }
            }

            if (args.containsKey("iconColor")) {
                when (val color = args["iconColor"]) {
                    is String -> withIconColor(color)
                    is Int -> withIconColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon color value!!"
                    )
                }
            }

            if (args.containsKey("iconOpacity")) {
                when (val opacity = args["iconOpacity"]) {
                    is Double -> withIconOpacity(opacity)
                    is Long -> withIconOpacity(opacity.toDouble())
                    is Int -> withIconOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon opacity value!!"
                    )
                }
            }

            if (args.containsKey("iconSize")) {
                when (val size = args["iconSize"]) {
                    is Double -> withIconSize(size)
                    is Long -> withIconSize(size.toDouble())
                    is Int -> withIconSize(size.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon size value!!"
                    )
                }
            }

            if (args.containsKey("iconRotate")) {
                when (val rotate = args["iconRotate"]) {
                    is Double -> withIconRotate(rotate)
                    is Long -> withIconRotate(rotate.toDouble())
                    is Int -> withIconRotate(rotate.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon rotate value!!"
                    )
                }
            }

            if (args.containsKey("iconAnchor")) {
                when (val anchor = args["iconAnchor"]) {
                    is String -> withIconAnchor(IconAnchor.valueOf(anchor.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon anchor value!!"
                    )
                }
            }

            if (args.containsKey("iconOffset")) {
                when (val offset = args["iconOffset"]) {
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

            if (args.containsKey("iconHaloColor")) {
                when (val color = args["iconHaloColor"]) {
                    is String -> withIconHaloColor(color)
                    is Int -> withIconHaloColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon halo color value!!"
                    )
                }
            }

            if (args.containsKey("iconHaloBlur")) {
                when (val blur = args["iconHaloBlur"]) {
                    is Double -> withIconHaloBlur(blur)
                    is Long -> withIconHaloBlur(blur.toDouble())
                    is Int -> withIconHaloBlur(blur.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon halo blur value!!"
                    )
                }
            }

            if (args.containsKey("iconHaloWidth")) {
                when (val haloWidth = args["iconHaloWidth"]) {
                    is Double -> withIconHaloWidth(haloWidth)
                    is Long -> withIconHaloWidth(haloWidth.toDouble())
                    is Int -> withIconHaloWidth(haloWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid icon halo width value!!"
                    )
                }
            }

            if (args.containsKey("textField")) {
                when (val field = args["textField"]) {
                    is String -> withTextField(field)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text field value!!"
                    )
                }
            }

            if (args.containsKey("textColor")) {
                when (val color = args["textColor"]) {
                    is String -> withTextColor(color)
                    is Int -> withTextColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text color value!!"
                    )
                }
            }

            if (args.containsKey("textOpacity")) {
                when (val opacity = args["textOpacity"]) {
                    is Double -> withTextOpacity(opacity)
                    is Long -> withTextOpacity(opacity.toDouble())
                    is Int -> withTextOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text opacity value!!"
                    )
                }
            }

            if (args.containsKey("textSize")) {
                when (val size = args["textSize"]) {
                    is Double -> withTextSize(size)
                    is Int -> withTextSize(size.toDouble())
                    is Long -> withTextSize(size.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text size value!!"
                    )
                }
            }

            if (args.containsKey("textRotate")) {
                when (val rotate = args["textRotate"]) {
                    is Double -> withTextRotate(rotate)
                    is Int -> withTextRotate(rotate.toDouble())
                    is Long -> withTextRotate(rotate.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text rotate value!!"
                    )
                }
            }

            if (args.containsKey("textLetterSpacing")) {
                when (val spacing = args["textLetterSpacing"]) {
                    is Double -> withTextLetterSpacing(spacing)
                    is Int -> withTextLetterSpacing(spacing.toDouble())
                    is Long -> withTextLetterSpacing(spacing.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text letter spacing value!!"
                    )

                }
            }

            if (args.containsKey("textLineHeight")) {
                when (val lineHeight = args["textLineHeight"]) {
                    is Double -> withTextLineHeight(lineHeight)
                    is Int -> withTextLineHeight(lineHeight.toDouble())
                    is Long -> withTextLineHeight(lineHeight.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text line height value!!"
                    )

                }
            }

            if (args.containsKey("textOffset")) {
                when (val offset = args["textOffset"]) {
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

            if (args.containsKey("textHaloColor")) {
                when (val color = args["textHaloColor"]) {
                    is String -> withTextHaloColor(color)
                    is Int -> withTextHaloColor(color)
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text halo color value!!"
                    )
                }
            }

            if (args.containsKey("textHaloBlur")) {
                when (val blur = args["textHaloBlur"]) {
                    is Double -> withTextHaloBlur(blur)
                    is Long -> withTextHaloBlur(blur.toDouble())
                    is Int -> withTextHaloBlur(blur.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text halo blur value!!"
                    )
                }
            }

            if (args.containsKey("textHaloWidth")) {
                when (val haloWidth = args["textHaloWidth"]) {
                    is Double -> withTextHaloWidth(haloWidth)
                    is Long -> withTextHaloWidth(haloWidth.toDouble())
                    is Int -> withTextHaloWidth(haloWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text halo width value!!"
                    )
                }
            }

            if (args.containsKey("textMaxWidth")) {
                when (val maxWidth = args["textMaxWidth"]) {
                    is Double -> withTextMaxWidth(maxWidth)
                    is Long -> withTextMaxWidth(maxWidth.toDouble())
                    is Int -> withTextMaxWidth(maxWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text max width value!!"
                    )
                }
            }

            if (args.containsKey("textRadialOffset")) {
                when (val offset = args["textRadialOffset"]) {
                    is Double -> withTextRadialOffset(offset)
                    is Long -> withTextRadialOffset(offset.toDouble())
                    is Int -> withTextRadialOffset(offset.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text radical offset value!!"
                    )
                }
            }

            if (args.containsKey("symbolSortKey")) {
                when (val sortKey = args["symbolSortKey"]) {
                    is Double -> withSymbolSortKey(sortKey)
                    is Long -> withSymbolSortKey(sortKey.toDouble())
                    is Int -> withSymbolSortKey(sortKey.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid symbol sort key value!!"
                    )
                }
            }

            if (args.containsKey("textAnchor")) {
                when (val anchor = args["textAnchor"]) {
                    is String -> withTextAnchor(TextAnchor.valueOf(anchor.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text anchor value!!"
                    )
                }
            }

            if (args.containsKey("textJustify")) {
                when (val justify = args["textJustify"]) {
                    is String -> withTextJustify(TextJustify.valueOf(justify.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text justify value!!"
                    )
                }
            }

            if (args.containsKey("textTransform")) {
                when (val transform = args["textTransform"]) {
                    is String -> withTextTransform(TextTransform.valueOf(transform.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PointAnnotationOptionsHelper.fromArgs]: Invalid text transform value!!"
                    )
                }
            }

            if (args.containsKey("draggable")) {
                when (val drag = args["draggable"]) {
                    is Boolean -> withDraggable(drag)
                    else -> Log.d(
                        TAG, "[PointAnnotationOptionsHelper.fromArgs]: Invalid draggable value!!"
                    )
                }
            }

            if (args.containsKey("data")) {
                when (val data = args["data"]) {
                    is String -> withData(Gson().fromJson(data, JsonElement::class.java))
                    else -> Log.d(
                        TAG, "[PointAnnotationOptionsHelper.fromArgs]: Invalid data value!!"
                    )
                }
            }
        }
    }
}