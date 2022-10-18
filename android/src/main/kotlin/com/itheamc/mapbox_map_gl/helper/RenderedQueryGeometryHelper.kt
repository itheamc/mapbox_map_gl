package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.RenderedQueryGeometry

/**
 * RenderedQueryGeometryHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/18
 *
 * RenderedQueryGeometryHelper to deal with render query geometry related data
 */
object RenderedQueryGeometryHelper {

    /**
     * Method to convert arguments to RenderedQueryGeometry object
     * params:
     * {args} - > Map<*, *> data
     */
    fun fromArgs(args: Map<*, *>?): RenderedQueryGeometry? {

        return args?.let {

            when (if (args.containsKey("type")) args["type"] as String else null) {
                "ScreenBox" -> ScreenBoxHelper.fromArgs(args["value"] as Map<*, *>)
                    ?.let { it1 -> RenderedQueryGeometry.valueOf(it1) }
                "ScreenCoordinate" -> ScreenCoordinateHelper.fromArgs(args["value"] as Map<*, *>)
                    ?.let { it1 -> RenderedQueryGeometry.valueOf(it1) }
                "ScreenCoordinates" -> {
                    val list = args["value"] as List<*>

                    val formattedList =
                        list.mapNotNull { ScreenCoordinateHelper.fromArgs(it as Map<*, *>) }

                    RenderedQueryGeometry.valueOf(formattedList)
                }
                else -> null
            }
        }
    }
}