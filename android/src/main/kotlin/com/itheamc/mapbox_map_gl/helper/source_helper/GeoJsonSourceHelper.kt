package com.itheamc.mapbox_map_gl.helper.source_helper

import android.util.Log
import com.mapbox.geojson.Feature
import com.mapbox.geojson.FeatureCollection
import com.mapbox.maps.extension.style.sources.generated.GeoJsonSource
import com.mapbox.maps.extension.style.types.PromoteId

/**
 * GeoJsonSourceHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/6
 */
internal object GeoJsonSourceHelper {

    private const val TAG = "GeoJsonSourceHelper"

    /**
     * Method to set properties got from the flutter side to GeoJson.Builder block
     */
    fun blockFromArgs(args: Map<*, *>): GeoJsonSource.Builder.() -> Unit {

        val sourceProperties = args["sourceProperties"] as Map<*, *>

        return {
            // url
            if (args.containsKey("url")) {
                url(args["url"] as String)
            }

            // data
            if (!args.containsKey("url") && args.containsKey("data")) {
                data(args["data"] as String)
            }

            // maxZoom
            if (sourceProperties.containsKey("maxZoom")) {
                when (val max = sourceProperties["maxZoom"]) {
                    is Double -> maxzoom(max.toLong())
                    is Int -> maxzoom(max.toLong())
                    is Long -> maxzoom(max)
                }
            }

            // attribution
            if (sourceProperties.containsKey("attribution")) {
                val attr = sourceProperties["attribution"] as String
                attribution(attr)
            }

            // buffer
            if (sourceProperties.containsKey("buffer")) {
                when (val bfr = sourceProperties["buffer"]) {
                    is Double -> buffer(bfr.toLong())
                    is Int -> buffer(bfr.toLong())
                    is Long -> buffer(bfr)
                }
            }

            // tolerance
            if (sourceProperties.containsKey("tolerance")) {
                when (val tol = sourceProperties["tolerance"]) {
                    is Double -> tolerance(tol)
                    is Int -> tolerance(tol.toDouble())
                    is Long -> tolerance(tol.toDouble())
                }
            }

            // cluster
            if (sourceProperties.containsKey("cluster")) {
                val clu = sourceProperties["cluster"] as Boolean
                cluster(clu)
            }

            // clusterRadius
            if (sourceProperties.containsKey("clusterRadius")) {
                when (val radius = sourceProperties["clusterRadius"]) {
                    is Double -> clusterRadius(radius.toLong())
                    is Int -> clusterRadius(radius.toLong())
                    is Long -> clusterRadius(radius)
                }
            }

            // clusterMaxZoom
            if (sourceProperties.containsKey("clusterMaxZoom")) {
                when (val cMaxZoom = sourceProperties["clusterMaxZoom"]) {
                    is Double -> clusterMaxZoom(cMaxZoom.toLong())
                    is Int -> clusterMaxZoom(cMaxZoom.toLong())
                    is Long -> clusterMaxZoom(cMaxZoom)
                }
            }

            // clusterProperties
            if (sourceProperties.containsKey("clusterProperties")) {
                try {
                    val properties = sourceProperties["clusterProperties"] as HashMap<*, *>
                    val hashMap = HashMap<String, Any>()

                    properties.forEach { entry ->
                        hashMap[entry.key as String] = entry.value
                    }

                    clusterProperties(hashMap)
                } catch (e: Exception) {
                    Log.i(TAG, "blockFromArgs: - clusterProperties --> ${e.message}")
                }
            }

            // lineMetrics
            if (sourceProperties.containsKey("lineMetrics")) {
                val metric = sourceProperties["lineMetrics"] as Boolean
                lineMetrics(metric)
            }

            // generateId
            if (sourceProperties.containsKey("generateId")) {
                val shouldGenerate = sourceProperties["generateId"] as Boolean
                generateId(shouldGenerate)
            }

            // promoteId
            if (sourceProperties.containsKey("promoteId")) {
                val promoted = sourceProperties["promoteId"] as Map<*, *>
                promoteId(
                    PromoteId(
                        propertyName = promoted["propertyName"] as String,
                        sourceId = (if (promoted.containsKey("sourceId")) promoted["sourceId"] else null) as String?
                    )
                )
            }

            // prefetchZoomDelta
            if (sourceProperties.containsKey("prefetchZoomDelta")) {
                when (val zoomDelta = sourceProperties["prefetchZoomDelta"]) {
                    is Double -> prefetchZoomDelta(zoomDelta.toLong())
                    is Int -> prefetchZoomDelta(zoomDelta.toLong())
                    is Long -> prefetchZoomDelta(zoomDelta)
                }
            }

            // feature
            if (sourceProperties.containsKey("feature")) {
                try {
                    val f = sourceProperties["feature"] as String
                    feature(Feature.fromJson(f))
                } catch (e: Exception) {
                    Log.i(TAG, "blockFromArgs: - feature --> ${e.message}")
                }
            }

            // featureCollection
            if (sourceProperties.containsKey("featureCollection")) {
                try {
                    val collection = sourceProperties["featureCollection"] as String
                    featureCollection(FeatureCollection.fromJson(collection))
                } catch (e: Exception) {
                    Log.i(TAG, "blockFromArgs: - feature --> ${e.message}")
                }
            }

        }

    }
}