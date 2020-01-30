//
//  DVMCitiesListViewControllerViewController.swift
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class DVMCitiesListViewControllerViewController: UIViewController {
    
    // MARK: - Properties
    var country: String?
    var state: String?
    var cities: [String] = [] {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.citiesTableView.delegate = self
        self.citiesTableView.dataSource = self
        guard let country = country, let state = state else { return }
        
        DVMCityAirQualityController.fetchSupportedCities(inState: state, country: country) { (cities) in
            if let returnedCities = cities {
                self.cities = returnedCities
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCityDetailVC" {
            guard let indexPath = citiesTableView.indexPathForSelectedRow,
                let country = country,
                let state = state,
                let destinationVC = segue.destination as? DVMCityDetailsViewController
                else { return }
            
            let citySelected = cities[indexPath.row]
            destinationVC.city = citySelected
            destinationVC.state = state
            destinationVC.country = country
        }
    }
    
    // MARK: - Custom Methods
    func updateViews() {
        DispatchQueue.main.async {
            self.citiesTableView.reloadData()
        }
    }

}

extension DVMCitiesListViewControllerViewController: UITableViewDelegate {
}

extension DVMCitiesListViewControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    
}
