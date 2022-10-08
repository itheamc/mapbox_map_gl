package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.Style

/**
 * StyleHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/7
 *
 * StyleHelper to deal with style related data
 */
internal object StyleHelper {

    fun fromArgs(mapStyle: String?): String {
        return when (mapStyle) {
            streets -> Style.MAPBOX_STREETS
            outdoors -> Style.OUTDOORS
            light -> Style.LIGHT
            dark -> Style.DARK
            satellite -> Style.SATELLITE
            satelliteStreets -> Style.SATELLITE_STREETS
            trafficDay -> Style.TRAFFIC_DAY
            trafficNight -> Style.TRAFFIC_NIGHT
            else -> Style.LIGHT
        }
    }

    private const val streets = "streets"
    private const val outdoors = "outdoors"
    private const val light = "light"
    private const val dark = "dark"
    private const val satellite = "satellite"
    private const val satelliteStreets = "satelliteStreets"
    private const val trafficDay = "trafficDay"
    private const val trafficNight = "trafficNight"
}