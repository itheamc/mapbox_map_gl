package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.ScreenBox

/**
 * ScreenBoxHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/18
 *
 * ScreenBoxHelper to deal with screen box related data
 */
object ScreenBoxHelper {

    /**
     * Method to convert arguments to ScreenBox object
     * params:
     * {args} - > Map<*, *> data
     */
    fun fromArgs(args: Map<*, *>): ScreenBox? {

        val min =
            if (args.containsKey("min") && args["min"] is Map<*, *>) args["min"] as Map<*, *> else null

        val max =
            if (args.containsKey("max") && args["max"] is Map<*, *>) args["max"] as Map<*, *> else null

        if (min == null || max == null) return null

        val coordinateMin = ScreenCoordinateHelper.fromArgs(min)
        val coordinateMax = ScreenCoordinateHelper.fromArgs(max)

        if (coordinateMin == null || coordinateMax == null) return null

        return ScreenBox(coordinateMin, coordinateMax)
    }
}