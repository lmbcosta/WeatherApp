//
//  Constants.swift
//  WeatherApp
//
//  Created by Luis  Costa on 15/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import Foundation

let URL_BASE_MAIN = "http://api.openweathermap.org/data/2.5/weather?"
let URL_BASE_DAYS = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LAT = "lat="
let LAT_VALUE = "\(Location.shredInstance.latitude!.rounded())"
let LONG_VALUE = "\(Location.shredInstance.longitude!.rounded())"
let LONG = "&lon="
let API_KEY = "&appid=6305efe859a3861d4261de75c02756fe"

let NUM_DAYS = "&cnt=8"
// Type alias create a kind of type
typealias DownloadComplete = () -> ()
// String to URL's used
let STRING_URL_MAIN = "\(URL_BASE_MAIN)\(LAT)\(LAT_VALUE)\(LONG)\(LONG_VALUE)\(API_KEY)"
let STRING_URL_DAYS = "\(URL_BASE_DAYS)\(LAT)\(LAT_VALUE)\(LONG)\(LONG_VALUE)\(NUM_DAYS)\(API_KEY)"

// Convert ro Celcius
let CELCIUS_CONVERTER: Double = 273.13
let FORECAST_DAYS = 7




