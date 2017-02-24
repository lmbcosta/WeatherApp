//
//  Location.swift
//  WeatherApp
//
//  Created by Luis  Costa on 20/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import Foundation
import CoreLocation


// Creating a sigleton class 
// that we use to reate a unique location
class Location {
    
    static let shredInstance = Location()
    // Private Constructor
    private init() {}
    
    // Attributes
    var latitude: Double!
    var longitude: Double!
}
