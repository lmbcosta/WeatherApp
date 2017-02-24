//
//  MainVC.swift
//  WeatherApp
//
//  Created by Luis  Costa on 14/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import UIKit
import Alamofire
// Framework to get device location
import CoreLocation

// Implementing protocol to work with CoreLocation
class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var listForecast = [Forecast]()
    var currentWeather: CurrentWeather!
    var nextDay: Int!
    // The locationManager
    let locationManager = CLLocationManager()
    // Our current location
    var location: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Delegate location manager
        locationManager.delegate = self
        // Some locationManager attributes
        // How accurate we want our location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Only request location when user is using the app
        locationManager.requestWhenInUseAuthorization()
        // Tracks different gps changes in the device
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        // Update currentDay
        nextDay = Calendar.current.component(.weekday, from: Date())
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthorization()
    }

    
    // Function to handle the authorization location status
    func locationAuthorization() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            // If we have authorization
            locationManager.requestWhenInUseAuthorization()
            locationAuthorization()
        } else {
            // Get out location
            location = locationManager.location
            
            // Passing the location(lat/long) to the singleton location class
            // This allow us to access to the location anywere
            Location.shredInstance.latitude = location.coordinate.latitude
            Location.shredInstance.longitude = location.coordinate.longitude
            currentWeather.downloadWeatherData {
                self.getForecastData {
                    // Update weekdays
                    for forcast in self.listForecast {
                        forcast.date = daysOfTheWeek(day: self.nextDay % 7)
                        self.nextDay = self.nextDay + 1
                    }
                    self.updateMainView()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // TableView methods to implement
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var result = UITableViewCell()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as? ForecastCell {
            // Get the correct forecast to pass to the ForecastCell cell
            let forecast = listForecast[indexPath.row]
            cell.updateCell(foreCast: forecast)
            result = cell
            
            // TODO: Missing dealing with date week days
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 8 days of forecast
        return listForecast.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func updateMainView() {
        self.dateLabel.text = currentWeather.date
        print(currentWeather.date)
        self.tempLabel.text = "\(currentWeather.currentWeather)ºC"
        print(String(currentWeather.currentWeather))
        self.cityLabel.text = currentWeather.cityName
        self.typeLabel.text = currentWeather.weatherType
        self.thumb.image = UIImage(named: currentWeather.weatherType)
    }
    
    // Function to get forecastData
    func getForecastData(completed: @escaping DownloadComplete) {
        // Prepare URL
        if let urlForecast = URL(string: STRING_URL_DAYS) {
            
            // Alamofire request
            Alamofire.request(urlForecast).responseJSON { response in
                // Every request has a result and every result has a valure
                
                //get JSON
                if let json = response.result.value {
                    // testing json data
                    print(json)
                    
                    if let dict = json as? [String: Any] {
                        if let list = dict["list"] as? [[String:Any]] {
                            
                            // Get forecast for all 8 days
                            // Starting from tomorow
                            // Increment the current day
                            for i in 0...FORECAST_DAYS {
                                if i != 0 {
                                    // Create a new forecast
                                    let forecast = Forecast()
                                    let elem = list[i]
                                    if let temp = elem["temp"] as? [String: Any] {
                                        // Get min Temp
                                        if let min = temp["min"] as? Double {
                                            let celciusValue = min - CELCIUS_CONVERTER
                                            // Update forecast
                                            forecast.minTemp = celciusValue.rounded()
                                        }
                                        
                                        // Get max Temp
                                        if let max = temp["max"] as? Double {
                                            let celciusValue = max - CELCIUS_CONVERTER
                                            // Update forecast
                                            forecast.maxTemp = celciusValue.rounded()
                                        }
                                    }
                                    
                                    // Get type of weather
                                    if let weather = elem["weather"] as? [[String: Any]] {
                                        if let main = weather[0]["main"] as? String {
                                            // Update forecast
                                            forecast.type = main
                                        }
                                    }
                                    // add forecast for the updated forecastlist
                                    self.listForecast.append(forecast)
                                }
                            }
                        }
                    }
                }
                completed()
            }
        }
    }
}












