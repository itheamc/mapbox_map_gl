package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.extension.style.sources.TileSet
import com.mapbox.maps.extension.style.sources.generated.Encoding
import com.mapbox.maps.extension.style.sources.generated.Scheme
import java.util.*

/**
 * TileSetHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/5
 */
object TileSetHelper {

    /**
     * Method to set properties got from the flutter side to TileSet.Builder block
     */
    fun blockFromArgs(args: Map<*, *>): TileSet.Builder.() -> Unit {
        return {
            // set name
            if (args.containsKey("name") && args["name"] is String) {
                val value = args["name"] as String
                name(value)
            }

            // set description
            if (args.containsKey("description") && args["description"] is String) {
                val value = args["description"] as String
                description(value)
            }

            // set version
            if (args.containsKey("version") && args["version"] is String) {
                val value = args["version"] as String
                version(value)
            }

            // set attribution
            if (args.containsKey("attribution") && args["attribution"] is String) {
                val value = args["attribution"] as String
                attribution(value)
            }

            // set template
            if (args.containsKey("template") && args["template"] is String) {
                val value = args["template"] as String
                template(value)
            }

            // set legend
            if (args.containsKey("legend") && args["legend"] is String) {
                val value = args["legend"] as String
                legend(value)
            }

            // set scheme
            if (args.containsKey("scheme") && args["scheme"] is String) {
                val value = args["scheme"] as String
                scheme(Scheme.valueOf(value.uppercase(Locale.ENGLISH)))
            }

            // set grids
            if (args.containsKey("grids") && args["grids"] is List<*>) {
                val value = args["grids"] as List<*>
                grids(value.map { if (it is String) it else it.toString() })
            }

            // set data
            if (args.containsKey("data") && args["data"] is List<*>) {
                val value = args["data"] as List<*>
                data(value.map { if (it is String) it else it.toString() })
            }

            // set minZoom
            if (args.containsKey("minZoom") && args["minZoom"] is Int) {
                val value = args["minZoom"] as Int
                minZoom(value)
            }

            // set maxZoom
            if (args.containsKey("maxZoom") && args["maxZoom"] is Int) {
                val value = args["maxZoom"] as Int
                maxZoom(value)
            }

            // set bounds
            if (args.containsKey("bounds") && args["bounds"] is List<*>) {
                val value = args["bounds"] as List<*>
                if (value.size == 4) {
                    val list = value.map { it as Double }
                    bounds(list)
                }
            }

            // set center
            if (args.containsKey("center") && args["center"] is List<*>) {
                val value = args["center"] as List<*>
                if (value.size == 2) {
                    val list = value.map { it as Double }
                    center(list)
                }
            }
        }
    }


    /**
     * Method to set properties got from the flutter side to TileSet.RasterDemBuilder block
     */
    fun rasterDemBuilderBlockFromArgs(args: Map<*, *>): TileSet.RasterDemBuilder.() -> Unit {
        return {
            // set name
            if (args.containsKey("name") && args["name"] is String) {
                val value = args["name"] as String
                name(value)
            }

            // set description
            if (args.containsKey("description") && args["description"] is String) {
                val value = args["description"] as String
                description(value)
            }

            // set version
            if (args.containsKey("version") && args["version"] is String) {
                val value = args["version"] as String
                version(value)
            }

            // set attribution
            if (args.containsKey("attribution") && args["attribution"] is String) {
                val value = args["attribution"] as String
                attribution(value)
            }

            // set template
            if (args.containsKey("template") && args["template"] is String) {
                val value = args["template"] as String
                template(value)
            }

            // set legend
            if (args.containsKey("legend") && args["legend"] is String) {
                val value = args["legend"] as String
                legend(value)
            }

            // set scheme
            if (args.containsKey("scheme") && args["scheme"] is String) {
                val value = args["scheme"] as String
                scheme(Scheme.valueOf(value.uppercase(Locale.ENGLISH)))
            }

            // set grids
            if (args.containsKey("grids") && args["grids"] is List<*>) {
                val value = args["grids"] as List<*>
                grids(value.map { if (it is String) it else it.toString() })
            }

            // set data
            if (args.containsKey("data") && args["data"] is List<*>) {
                val value = args["data"] as List<*>
                data(value.map { if (it is String) it else it.toString() })
            }

            // set minZoom
            if (args.containsKey("minZoom") && args["minZoom"] is Int) {
                val value = args["minZoom"] as Int
                minZoom(value)
            }

            // set maxZoom
            if (args.containsKey("maxZoom") && args["maxZoom"] is Int) {
                val value = args["maxZoom"] as Int
                maxZoom(value)
            }

            // set bounds
            if (args.containsKey("bounds") && args["bounds"] is List<*>) {
                val value = args["bounds"] as List<*>
                if (value.size == 4) {
                    val list = value.map { it as Double }
                    bounds(list)
                }
            }

            // set center
            if (args.containsKey("center") && args["center"] is List<*>) {
                val value = args["center"] as List<*>
                if (value.size == 2) {
                    val list = value.map { it as Double }
                    center(list)
                }
            }

            // set encoding
            if (args.containsKey("encoding") && args["encoding"] is String) {
                val value = args["encoding"] as String
                encoding(Encoding.valueOf(value.uppercase(Locale.ENGLISH)))
            }
        }
    }
}