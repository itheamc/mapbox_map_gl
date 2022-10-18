package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.ScreenCoordinate

/**
 * ScreenCoordinateHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/18
 *
 * ScreenCoordinateHelper to deal with screen coordinate related data
 */
object ScreenCoordinateHelper {

    /**
     * Method to convert arguments to ScreenCoordinate object
     * params:
     * {args} - > Map<*, *> data
     */
    fun fromArgs(args: Map<*, *>): ScreenCoordinate? {

        val x = if (args.containsKey("x")) when (val v = args["x"]) {
            is Double -> v
            is Int -> v.toDouble()
            is Long -> v.toDouble()
            else -> null
        } else null

        val y = if (args.containsKey("y")) when (val v = args["y"]) {
            is Double -> v
            is Int -> v.toDouble()
            is Long -> v.toDouble()
            else -> null
        } else null

        if (x == null || y == null) return null

        return ScreenCoordinate(x, y)
    }
}