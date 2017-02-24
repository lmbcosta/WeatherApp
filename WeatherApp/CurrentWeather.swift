//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Luis  Costa on 15/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

// Class to save all the current weather data

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentWeather: Int!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let format = DateFormatter()
        format.dateStyle = .long
        format.timeStyle = .none
        
        let currentDate = format.string(from: Date())
        _date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentWeather: Int {
        if _currentWeather == nil {
            _currentWeather = 0
        }
        return _currentWeather
    }
    
    // Function to Download Weather contents
    func downloadWeatherData(completed: @escaping DownloadComplete) {
        // Making a request using Alomofire
        let currentWeatherURL = URL(string: STRING_URL_MAIN)
        if let url = currentWeatherURL {
            Alamofire.request(url).responseJSON { response in
                // Pass JSON to Dictionary
                if let json = response.result.value {
                    // create a dictionary
                    if let dict = json as? [String:Any] {
                        // Get city name
                        if let name = dict["name"] as? String {
                            self._cityName = name.capitalized
                        }
                        
                        // Get weather type
                        if let weather = dict["weather"] as? [Dictionary<String, Any>] {
                            if let main = weather[0]["main"] as? String {
                                self._weatherType = main.capitalized
                            }
                        }
                        
                        // Get the current Temperature
                        if let main = dict["main"] as? [String: Any] {
                            // Get current temp
                            if let kelvinTemp = main["temp"] as? Double {
                                let currentTemp = kelvinTemp - CELCIUS_CONVERTER
                                self._currentWeather = Int(currentTemp.rounded())
                            }
                        }
                    }
                }
                completed()
            }
            
        }
    }
}








