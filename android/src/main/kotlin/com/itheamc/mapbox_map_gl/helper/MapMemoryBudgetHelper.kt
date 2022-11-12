package com.itheamc.mapbox_map_gl.helper

import com.mapbox.maps.MapMemoryBudget
import com.mapbox.maps.MapMemoryBudgetInMegabytes
import com.mapbox.maps.MapMemoryBudgetInTiles

/**
 * MapMemoryBudgetHelper.kt
 *
 * Created by Amit Chaudhary, 2022/11/12
 *
 * MapMemoryBudgetHelper to deal with map memory budget related data
 */
internal object MapMemoryBudgetHelper {

    /**
     * Method to convert arguments to MapMemoryBudget object
     * params:
     * {args} - > Map<*, *> data
     */
    fun fromArgs(args: Map<*, *>?): MapMemoryBudget? {

        return args?.let {
            val budgetIn = it["budgetIn"] as String
            val budget = when (val b = it["budget"]) {
                is Double -> b.toLong()
                is Int -> b.toLong()
                else -> b as Long
            }

            if (budgetIn == "mega_bytes") {
                MapMemoryBudget.valueOf(MapMemoryBudgetInMegabytes(budget))
            } else {
                MapMemoryBudget.valueOf(MapMemoryBudgetInTiles(budget))
            }
        }
    }
}