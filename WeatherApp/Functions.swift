//
//  Functions.swift
//  WeatherApp
//
//  Created by Luis  Costa on 19/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import Foundation

// This function return a week day as a string name
func daysOfTheWeek(day: Int) -> String {
    var result: String!
    
    switch day {
    case 0:
        result = "Sunday"
        
    case 1:
        result = "Monday"
        
    case 2:
        result = "Tuesday"
        
    case 3:
        result = "Wednesday"
        
    case 4:
        result = "Thursday"
        
    case 5:
        result = "Friday"
        
    case 6:
        result = "Saturday"
    default:
        result = ""
    }
    
    return result
}
