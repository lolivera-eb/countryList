//
//  ViewController.swift
//  countryList
//
//  Created by lolivera on 03/09/2021.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableCountry: UITableView!
    
    var countryManager = CountryManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCountry.dataSource = self
        tableCountry.delegate = self
        tableCountry.separatorStyle = .none
        tableCountry.showsVerticalScrollIndicator = false
        
        countryManager.delegate = self
        
    }
    
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Country"
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Countries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCountry.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? MyTableViewCell
        
        cell?.countryLabel.text = Countries[indexPath.row].name
        cell?.countryImage.image = UIImage(named: Countries[indexPath.row].name)
        cell?.accessoryType = .disclosureIndicator
        
        cell?.countryView.layer.cornerRadius = (cell?.countryView.frame.height)! / 3
        cell?.countryImage.layer.cornerRadius = (cell?.countryImage.frame.height)! / 2
        
        return cell!
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countryManager.fetchCountry(countryName:Countries[indexPath.row].alpha3Code )
        
    }
}


// MARK: - UITableViewDataSource
extension ViewController: CountryManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCountry(_ countryManager: CountryManager, country: CountryModel) {
        
    }
    
}
