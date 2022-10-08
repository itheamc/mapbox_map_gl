package com.itheamc.mapbox_map_gl.helper

import com.mapbox.geojson.BoundingBox

/**
 * BoundingBoxHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/5
 *
 * BoundingBoxHelper to deal with bounding box related data
 */
internal object BoundingBoxHelper {

    /**
     * Method to convert arguments to BoundingBox object
     * params:
     * {args} - > Map<*, *> data
     */
    fun fromArgs(args: Map<*, *>?): BoundingBox? {

        args?.let {
            val southwest = it["southwest"] as Map<*, *>
            val northeast = it["northeast"] as Map<*, *>

            return PointHelper.fromArgs(southwest)?.let { it1 ->
                PointHelper.fromArgs(northeast)?.let { it2 ->
                    BoundingBox.fromPoints(
                        it1,
                        it2
                    )
                }
            }
        }

        return null
    }
}