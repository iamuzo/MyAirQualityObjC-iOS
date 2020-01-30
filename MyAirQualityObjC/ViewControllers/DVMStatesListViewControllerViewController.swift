//
//  DVMStatesListViewControllerViewController.swift
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

import UIKit

class DVMStatesListViewControllerViewController: UIViewController {

    // MARK: - Properties
    var country: String?
    var states: [String] = [] {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var statesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statesTableView.delegate = self
        statesTableView.dataSource = self
        guard let receivedCountry = country else {return }
        DVMCityAirQualityController.fetchSupportedStates(inCountry: receivedCountry) { (statesInCounry) in
            if let states = statesInCounry {
                self.states = states
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCitiesVC" {
            guard let indexPath = statesTableView.indexPathForSelectedRow,
            let country = country,
                let destinationVC = segue.destination as? DVMCitiesListViewControllerViewController
                else { return}
            let stateSelected = states[indexPath.row]
            destinationVC.country = country
            destinationVC.state = stateSelected
        }
    }
    
    // MARK: - Custom Methods
    func updateViews() {
        DispatchQueue.main.async {
            self.statesTableView.reloadData()
        }
    }
}

extension DVMStatesListViewControllerViewController: UITableViewDelegate {
}

extension DVMStatesListViewControllerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statesTableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state
        return cell
    }
}
