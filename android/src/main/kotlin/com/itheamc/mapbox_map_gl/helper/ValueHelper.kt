package com.itheamc.mapbox_map_gl.helper

import com.mapbox.bindgen.Value

internal object ValueHelper {

    /**
     * Method to convert String, Long, Int, Double, Boolean, List etc to value
     */
    fun toValue(v: Any?): Value {

        return when (v) {
            String -> Value.valueOf(v as String)
            Long -> Value.valueOf(v as Long)
            Int -> Value.valueOf((v as Int).toLong())
            Double -> Value.valueOf(v as Double)
            Boolean -> Value.valueOf(v as Boolean)
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