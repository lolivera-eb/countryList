//
//  CollectionViewController.swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import UIKit

class CollectionViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var countryManager = CountryManager()
    
    var borders = [CountryListModel]()
    
    var countryCopy = Countries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        
        countryManager.delegate = self
        searchTextField.delegate = self
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type country"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let country = searchTextField.text {
            for countryFor in Countries{
                if country == countryFor.name{
                    print(countryFor.alpha3Code)
                    countryManager.fetchCountry(countryName: countryFor.alpha3Code)
                }
            }
        }
        
        searchTextField.text = ""
        
    }
}



extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryCopy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! CountryCell
        
        cell.countryImageView.image = UIImage(named: countryCopy[indexPath.row].name)
        cell.layer.cornerRadius = cell.frame.height / 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        countryManager.fetchCountry(countryName:countryCopy[indexPath.row].alpha3Code)
    }
    
}




// MARK: - CollectionViewController
extension CollectionViewController: CountryManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCountry(_ countryManager: CountryManager, country: CountryModel) {
        DispatchQueue.main.async {
            let newCountry = countryManager.getBorders(country.borders)
            self.labelTop.text = country.name
            self.imageTop.image =  UIImage(named: country.name)
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.countryCopy = newCountry
                self.countryCollectionView.reloadData()
            }
        }
    }
    
}

