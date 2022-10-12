package com.itheamc.mapbox_map_gl.helper.source_helper

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log

/**
 * StyleImageHelper.kt
 *
 * Created by Amit Chaudhary, 2022/10/8
 */
internal object StyleImageHelper {

    private const val TAG = "StyleImageHelper"

    /**
     * Method to set properties got from the flutter side to HeatmapLayerDsl block
     */
    fun bitmapFromArgs(args: Map<*, *>): Bitmap? {

        val byteArray =
            if (args.containsKey("byteArray") && args["byteArray"] != null) args["byteArray"] as ByteArray else null

        return byteArray?.let { byteArr ->
            try {
                BitmapFactory.decodeByteArray(byteArr, 0, byteArr.size)
            } catch (e: Exception) {
                Log.e(TAG, "StyleImageHelper.bitmapFromArgs: ${e.message}", e)
                null
            }
        }
    }
}