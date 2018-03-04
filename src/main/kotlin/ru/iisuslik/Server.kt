package ru.iisuslik

import spark.Spark.*

fun main(args: Array<String>) {
    var i: Int = 0
    get("/") { req, res ->
        "LOL!!!!" + (i++)
    }
}