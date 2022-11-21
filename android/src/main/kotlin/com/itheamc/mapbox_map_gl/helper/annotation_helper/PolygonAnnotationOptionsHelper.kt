package com.itheamc.mapbox_map_gl.helper.annotation_helper

import android.util.Log
import com.google.gson.Gson
import com.google.gson.JsonElement
import com.itheamc.mapbox_map_gl.helper.PointHelper
import com.mapbox.geojson.Point
import com.mapbox.maps.plugin.annotation.generated.PolygonAnnotationOptions

/**
 * PolygonAnnotationOptionsHelper.kt
 *
 * Created by Amit Chaudhary, 2022/11/21
 */
internal object PolygonAnnotationOptionsHelper {
    private const val TAG = "PolygonAnnotationOption"

    /**
     * Method to create PolygonAnnotationOptions object from the args
     */
    fun fromArgs(args: Map<*, *>): PolygonAnnotationOptions {

        if (args.isEmpty()) return PolygonAnnotationOptions()

        return PolygonAnnotationOptions().apply {

            if (args.containsKey("points")) {
                when (val points = args["points"]) {
                    is List<*> -> {
                        val listOfRawList = points.filterIsInstance<List<*>>()

                        val listOfList = arrayListOf<List<Point>>()

                        listOfRawList.forEach {
                            val temp =
                                it.mapNotNull { v -> if (v is Map<*, *>) PointHelper.fromArgs(v) else null }
                            listOfList.add(temp)
                        }

                        withPoints(listOfList)
                    }
                    else -> Log.d(
                        TAG,
                        "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid list of points coordinate value!!"
                    )
                }
            }

            if (args.containsKey("fillColor")) {
                when (val color = args["fillColor"]) {
                    is String -> withFillColor(color)
                    is Int -> withFillColor(color)
                    else -> Log.d(
                        TAG,
                        "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid fill color value!!"
                    )
                }
            }

            if (args.containsKey("fillOpacity")) {
                when (val opacity = args["fillOpacity"]) {
                    is Double -> withFillOpacity(opacity)
                    is Long -> withFillOpacity(opacity.toDouble())
                    is Int -> withFillOpacity(opacity.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid fill opacity value!!"
                    )
                }
            }

            if (args.containsKey("fillOutlineColor")) {
                when (val color = args["fillOutlineColor"]) {
                    is String -> withFillOutlineColor(color)
                    is Int -> withFillOutlineColor(color)
                    else -> Log.d(
                        TAG,
                        "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid fill outline color value!!"
                    )
                }
            }

            if (args.containsKey("fillPattern")) {
                when (val pattern = args["fillPattern"]) {
                    is String -> withFillPattern(pattern)
                    else -> Log.d(
                        TAG,
                        "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid fill pattern value!!"
                    )
                }
            }

            if (args.containsKey("fillSortKey")) {
                when (val sortKey = args["fillSortKey"]) {
                    is Double -> withFillSortKey(sortKey)
                    is Long -> withFillSortKey(sortKey.toDouble())
                    is Int -> withFillSortKey(sortKey.toDouble())
                    else -> Log.d(
                        TAG,
                        "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid fill sort key value!!"
                    )
                }
            }

            if (args.containsKey("draggable")) {
                when (val drag = args["draggable"]) {
                    is Boolean -> withDraggable(drag)
                    else -> Log.d(
                        TAG, "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid draggable value!!"
                    )
                }
            }

            if (args.containsKey("data")) {
                when (val data = args["data"]) {
                    is String -> withData(Gson().fromJson(data, JsonElement::class.java))
                    else -> Log.d(
                        TAG, "[PolygonAnnotationOptionsHelper.fromArgs]: Invalid data value!!"
                    )
                }
            }
        }
    }
}