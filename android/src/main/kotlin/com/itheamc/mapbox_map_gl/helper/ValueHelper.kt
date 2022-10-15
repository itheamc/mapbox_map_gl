package com.itheamc.mapbox_map_gl.helper

import com.mapbox.bindgen.Value

internal object ValueHelper {

    /**
     * Method to convert String, Long, Int, Double, Boolean, List etc to value
     */
    fun toValue(v: Any?): Value {

        return when (v) {
            is String -> Value.valueOf(v)
            is Long -> Value.valueOf(v)
            is Int -> Value.valueOf(v.toLong())
            is Double -> Value.valueOf(v)
            is Boolean -> Value.valueOf(v)
            is List<*> -> Value.valueOf(v.map { toValue(it) })
            is Map<*, *> -> {
                val hashMap = hashMapOf<String, Value>()
                v.forEach {
                    hashMap[it.key as String] = toValue(it.value)
                }
                Value.valueOf(hashMap)
            }
            else -> Value.nullValue()
        }
    }
}