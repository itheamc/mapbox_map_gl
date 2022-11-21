package com.itheamc.mapbox_map_gl.helper.annotation_helper

import android.util.Log
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.itheamc.mapbox_map_gl.helper.PointHelper
import com.mapbox.maps.extension.style.layers.properties.generated.LineJoin
import com.mapbox.maps.plugin.annotation.generated.PolylineAnnotationOptions

/**
 * PolylineAnnotationOptionsHelper.kt
 *
 * Created by Amit Chaudhary, 2022/11/21
 */
internal object PolylineAnnotationOptionsHelper {
    private const val TAG = "PolylineAnnotationOpt"

    /**
     * Method to create PolylineAnnotationOptions object from the args
     */
    fun fromArgs(args: Map<*, *>): PolylineAnnotationOptions {

        if (args.isEmpty()) return PolylineAnnotationOptions()

        return PolylineAnnotationOptions().apply {

            if (args.containsKey("points")) {
                when (val points = args["points"]) {
                    is List<*> -> {
                        val listOfPoints =
                            points.mapNotNull { v -> if (v is Map<*, *>) PointHelper.fromArgs(v) else null }
                        withPoints(listOfPoints)
                    }
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid list of points coordinate value!!"
                    )
                }
            }

            if (args.containsKey("lineColor")) {
                when (val color = args["lineColor"]) {
                    is String -> withLineColor(color)
                    is Int -> withLineColor(color)
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line color value!!"
                    )
                }
            }

            if (args.containsKey("lineOpacity")) {
                when (val opacity = args["lineOpacity"]) {
                    is Double -> withLineOpacity(opacity)
                    is Long -> withLineOpacity(opacity.toDouble())
                    is Int -> withLineOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line opacity value!!"
                    )
                }
            }

            if (args.containsKey("lineBlur")) {
                when (val blur = args["lineBlur"]) {
                    is Double -> withLineBlur(blur)
                    is Long -> withLineBlur(blur.toDouble())
                    is Int -> withLineBlur(blur.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line blur value!!"
                    )
                }
            }

            if (args.containsKey("lineWidth")) {
                when (val width = args["lineWidth"]) {
                    is Double -> withLineWidth(width)
                    is Long -> withLineWidth(width.toDouble())
                    is Int -> withLineWidth(width.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line width value!!"
                    )
                }
            }

            if (args.containsKey("lineOffset")) {
                when (val offset = args["lineOffset"]) {
                    is Double -> withLineOffset(offset)
                    is Long -> withLineOffset(offset.toDouble())
                    is Int -> withLineOffset(offset.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line offset value!!"
                    )
                }
            }

            if (args.containsKey("lineGapWidth")) {
                when (val gapWidth = args["lineGapWidth"]) {
                    is Double -> withLineGapWidth(gapWidth)
                    is Long -> withLineGapWidth(gapWidth.toDouble())
                    is Int -> withLineGapWidth(gapWidth.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line gap width value!!"
                    )
                }
            }

            if (args.containsKey("lineJoin")) {
                when (val join = args["lineJoin"]) {
                    is String -> withLineJoin(LineJoin.valueOf(join.uppercase()))
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line join value!!"
                    )
                }
            }

            if (args.containsKey("linePattern")) {
                when (val pattern = args["linePattern"]) {
                    is String -> withLinePattern(pattern)
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line pattern value!!"
                    )
                }
            }

            if (args.containsKey("lineSortKey")) {
                when (val sortKey = args["lineSortKey"]) {
                    is Double -> withLineSortKey(sortKey)
                    is Long -> withLineSortKey(sortKey.toDouble())
                    is Int -> withLineSortKey(sortKey.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid line sort key value!!"
                    )
                }
            }

            if (args.containsKey("draggable")) {
                when (val drag = args["draggable"]) {
                    is Boolean -> withDraggable(drag)
                    else -> Log.d(
                        TAG, "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid draggable value!!"
                    )
                }
            }

            if (args.containsKey("data")) {
                when (val data = args["data"]) {
                    is String -> withData(Gson().fromJson(data, JsonElement::class.java))
                    else -> Log.d(
                        TAG, "[PolylineAnnotationOptionsHelper.fromArgs]: Invalid data value!!"
                    )
                }
            }
        }
    }
}