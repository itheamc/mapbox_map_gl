package com.itheamc.mapbox_map_gl.helper.annotation_helper

import android.util.Log
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.itheamc.mapbox_map_gl.helper.PointHelper
import com.mapbox.maps.plugin.annotation.generated.CircleAnnotationOptions

/**
 * CircleAnnotationOptionsHelper.kt
 *
 * Created by Amit Chaudhary, 2022/11/21
 */
internal object CircleAnnotationOptionsHelper {
    private const val TAG = "CircleAnnotationOptions"

    /**
     * Method to create CircleAnnotationOptions object from the args
     */
    fun fromArgs(args: Map<*, *>): CircleAnnotationOptions {

        if (args.isEmpty()) return CircleAnnotationOptions()

        return CircleAnnotationOptions().apply {

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
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid point coordinate value!!"
                    )
                }
            }

            if (args.containsKey("circleColor")) {
                when (val color = args["circleColor"]) {
                    is String -> withCircleColor(color)
                    is Int -> withCircleColor(color)
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle color value!!"
                    )
                }
            }

            if (args.containsKey("circleRadius")) {
                when (val radius = args["circleRadius"]) {
                    is Double -> withCircleRadius(radius)
                    is Long -> withCircleRadius(radius.toDouble())
                    is Int -> withCircleRadius(radius.toDouble())
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle radius value!!"
                    )
                }
            }

            if (args.containsKey("circleBlur")) {
                when (val blur = args["circleBlur"]) {
                    is Double -> withCircleBlur(blur)
                    is Long -> withCircleBlur(blur.toDouble())
                    is Int -> withCircleBlur(blur.toDouble())
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle blur value!!"
                    )
                }
            }

            if (args.containsKey("circleOpacity")) {
                when (val opacity = args["circleOpacity"]) {
                    is Double -> withCircleOpacity(opacity)
                    is Long -> withCircleOpacity(opacity.toDouble())
                    is Int -> withCircleOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle opacity value!!"
                    )
                }
            }

            if (args.containsKey("circleStrokeColor")) {
                when (val color = args["circleStrokeColor"]) {
                    is String -> withCircleStrokeColor(color)
                    is Int -> withCircleStrokeColor(color)
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle stroke color value!!"
                    )
                }
            }

            if (args.containsKey("circleStrokeOpacity")) {
                when (val opacity = args["circleStrokeOpacity"]) {
                    is Double -> withCircleStrokeOpacity(opacity)
                    is Long -> withCircleStrokeOpacity(opacity.toDouble())
                    is Int -> withCircleStrokeOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle stroke opacity value!!"
                    )
                }
            }

            if (args.containsKey("circleStrokeWidth")) {
                when (val width = args["circleStrokeWidth"]) {
                    is Double -> withCircleStrokeWidth(width)
                    is Long -> withCircleStrokeWidth(width.toDouble())
                    is Int -> withCircleStrokeWidth(width.toDouble())
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle stroke width value!!"
                    )
                }
            }

            if (args.containsKey("circleSortKey")) {
                when (val sortKey = args["circleSortKey"]) {
                    is Double -> withCircleSortKey(sortKey)
                    is Long -> withCircleSortKey(sortKey.toDouble())
                    is Int -> withCircleSortKey(sortKey.toDouble())
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid circle sort key value!!"
                    )
                }
            }

            if (args.containsKey("draggable")) {
                when (val drag = args["draggable"]) {
                    is Boolean -> withDraggable(drag)
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid draggable value!!"
                    )
                }
            }

            if (args.containsKey("data")) {
                when (val data = args["data"]) {
                    is String -> withData(Gson().fromJson(data, JsonElement::class.java))
                    else -> Log.d(
                        TAG,
                        "[CircleAnnotationOptionsHelper.fromArgs]: Invalid data value!!"
                    )
                }
            }
        }
    }
}