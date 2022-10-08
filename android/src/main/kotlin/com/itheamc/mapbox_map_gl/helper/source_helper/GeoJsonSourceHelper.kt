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
                val max = sourceProperties["maxZoom"] as Int
                maxzoom(max.toLong())
            }

            // attribution
            if (sourceProperties.containsKey("attribution")) {
                val attr = sourceProperties["attribution"] as String
                attribution(attr)
            }

            // buffer
            if (sourceProperties.containsKey("buffer")) {
                val bfr = sourceProperties["buffer"] as Int
                buffer(bfr.toLong())
            }

            // tolerance
            if (sourceProperties.containsKey("tolerance")) {
                val tol = sourceProperties["tolerance"] as Double
                tolerance(tol)
            }

            // cluster
            if (sourceProperties.containsKey("cluster")) {
                val clu = sourceProperties["cluster"] as Boolean
                cluster(clu)
            }

            // clusterRadius
            if (sourceProperties.containsKey("clusterRadius")) {
                val radius = sourceProperties["clusterRadius"] as Int
                clusterRadius(radius.toLong())
            }

            // clusterMaxZoom
            if (sourceProperties.containsKey("clusterMaxZoom")) {
                val cMaxZoom = sourceProperties["clusterMaxZoom"] as Int
                clusterMaxZoom(cMaxZoom.toLong())
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
                val zoomDelta = sourceProperties["prefetchZoomDelta"] as Int
                prefetchZoomDelta(zoomDelta.toLong())
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

//             geometry
//            if (sourceProperties.containsKey("geometry")) {
//                try {
//                    val g = sourceProperties["geometry"] as String
//                    geometry()
//                } catch (e: Exception) {
//                    Log.i(TAG, "blockFromArgs: - feature --> ${e.message}")
//                }
//            }

        }

    }
}