//
//  DVMCityDetailsViewController.swift
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class DVMCityDetailsViewController: UIViewController {

    // MARK: - Properties
    var city: String?
    var state: String?
    var country: String?
    
    // MARK: - Outlets
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var stateNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempNameLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = city, let state = state, let country = country else { return }
        DVMCityAirQualityController.fetchData(forCity: city, state: state, country: country) { (cityInfo) in
            if let cityAirQualityDetails = cityInfo {
                self.updateViews(using: cityAirQualityDetails)
            }
        }
    }
    
    // MARK: - Custom Methods
    func updateViews(using cityDetails: DVMCityAirQuality) {
        DispatchQueue.main.async {
            self.countryNameLabel.text = cityDetails.country
            self.stateNameLabel.text = cityDetails.state
            self.cityNameLabel.text = cityDetails.city
            self.tempNameLabel.text = "\(cityDetails.weather.temperature)"
            self.humidityLabel.text = "\(cityDetails.weather.humidity)"
            self.windspeedLabel.text = "\(cityDetails.weather.windSpeed)"
            self.aqiLabel.text = "\(cityDetails.pollution.airQualityIndex)"
        }
    }
}
