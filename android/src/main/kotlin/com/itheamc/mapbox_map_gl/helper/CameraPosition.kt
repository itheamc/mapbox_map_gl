package com.itheamc.mapbox_map_gl.helper

import com.mapbox.geojson.Point
import com.mapbox.maps.ScreenCoordinate
import com.mapbox.maps.plugin.animation.MapAnimationOptions

/**
 * CameraPosition.kt
 *
 * Created by Amit Chaudhary, 2022/10/3
 */
class CameraPosition internal constructor(
    val center: Point,
    val zoom: Double = 13.0,
    val bearing: Double? = null,
    val pitch: Double? = null,
    val anchor: ScreenCoordinate? = null,
    val animationOptions: MapAnimationOptions? =
        MapAnimationOptions
            .mapAnimationOptions {
                startDelay(300L)
                duration(1000L)
            }
) {

    companion object {
        fun fromMap(map: Map<*, *>): CameraPosition {
            val center = map["center"] as Map<*, *>

            val zoom = if (map["zoom"] != null) map["zoom"] as Double else 14.0
            val bearing = if (map["bearing"] != null) map["bearing"] as Double else 0.0
            val pitch = if (map["pitch"] != null) map["pitch"] as Double else 0.0
            val anchor = if (map["anchor"] != null) map["anchor"] as Map<*, *> else null
            val animationOptions =
                if (map["animationOptions"] != null) map["animationOptions"] as Map<*, *> else null

            return CameraPosition(
                center = PointHelper.fromArgs(center)!!,
                zoom = zoom,
                bearing = bearing,
                pitch = pitch,
                anchor = if (anchor != null) ScreenCoordinate(
                    anchor["x"] as Double,
                    anchor["y"] as Double
                ) else null,
                animationOptions = if (animationOptions != null)
                    MapAnimationOptions.mapAnimationOptions {
                        startDelay((animationOptions["startDelay"] as Int).toLong())
                        duration((animationOptions["duration"] as Int * 1.0).toLong())
                    } else null

            )
        }
    }
}