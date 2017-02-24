//
//  Forecast.swift
//  WeatherApp
//
//  Created by Luis  Costa on 17/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _type: String!
    private var _minTemp: Double!
    private var _maxTemp: Double!
    
    
    var date: String {
        get{return _date == nil ? "" : _date}
        set{_date = newValue}
    }
    
    var type: String {
        get {return _type == nil ? "" : _type}
        set {_type = newValue}
    }
    
    var minTemp: Double {
        get { return _minTemp == nil ? 0.0 : _minTemp}
        set {_minTemp = newValue}
    }
    
    var maxTemp: Double {
        get {return _maxTemp == nil ? 0.0 : _maxTemp}
        set {_maxTemp = newValue}
    }
}
