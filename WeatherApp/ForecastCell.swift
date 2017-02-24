//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Luis  Costa on 18/02/17.
//  Copyright © 2017 Luis  Costa. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    //IBOutlets
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    
    // Function that allow to update the cell
    func updateCell(foreCast: Forecast) {
        dateLabel.text = foreCast.date
        typeLabel.text = foreCast.type
        maxLabel.text = "\(foreCast.maxTemp)ºC"
        minLabel.text = "\(foreCast.minTemp)ºC"
        
        // Get the image
        if let image = UIImage(named: foreCast.type) {
            thumbImage.image = image
        }
    }
}
