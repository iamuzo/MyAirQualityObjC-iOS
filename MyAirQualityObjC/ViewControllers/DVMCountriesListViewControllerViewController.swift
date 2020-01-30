//
//  DVMCountriesListViewControllerViewController.swift
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class DVMCountriesListViewControllerViewController: UIViewController {

    // MARK: - Properties
    var countries: [String] = [] {
        didSet {
            updateViews()
        }
    }
    // MARK: - Outlets
    @IBOutlet weak var countriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        DVMCityAirQualityController.fetchSupportedCountries { (countries) in
            
            if let returnedCountries = countries {
                DispatchQueue.main.async {
                    self.countries = returnedCountries
                }
            }
        }
    }
    
    // MARK: - Actions
    
    // MARK:- Custom Methods
    func updateViews() {
        DispatchQueue.main.async {
            self.countriesTableView.reloadData()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStatesVC" {
            guard let indexPath = countriesTableView.indexPathForSelectedRow,
                let destionationVC = segue.destination as? DVMStatesListViewControllerViewController else { return }
            
            let selectedCountry = countries[indexPath.row]
            destionationVC.country = selectedCountry
        }
    }

}

extension DVMCountriesListViewControllerViewController: UITableViewDelegate {
}

extension DVMCountriesListViewControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = country
        cell.detailTextLabel?.text = country
        
        return cell
    }

}
