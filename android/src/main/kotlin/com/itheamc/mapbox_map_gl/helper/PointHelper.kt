package com.itheamc.mapbox_map_gl.helper

import com.mapbox.geojson.Point

/**
 * PointHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/5
 *
 * PointHelper to deal with point related data
 */
internal object PointHelper {

    /**
     * Method to convert arguments to Point object
     * params:
     * {args} - > Map<*, *> data
     */
    fun fromArgs(args: Map<*, *>?): Point? {

        args?.let {
            val coordinates = it["coordinates"] as List<*>
            val bbox = it["bbox"] as Map<*, *>?

            return Point.fromLngLat(
                (coordinates).first() as Double,
                (coordinates).last() as Double,
                BoundingBoxHelper.fromArgs(bbox)
            )
        }

        return null
    }
}