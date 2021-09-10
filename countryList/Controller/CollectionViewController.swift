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
    
    let searchController = UISearchController()
    var nameCountry:String!
    
    var countryManager = CountryManager()
    
    var borders = [CountryModel]()
    
    var countries = [CountryModel]()
    
    var filterContries = [CountryModel]()
    
    let mycellWidth = UIScreen.main.bounds.width


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSerachController()
        
        self.imageTop.image = UIImage(named: nameCountry ?? " ")
        self.labelTop.text = nameCountry
        
        countryCollectionView?.delegate = self
        countryCollectionView?.dataSource = self
        
        countryManager.delegate = self
        
        countryManager.getListCountry(nameCountry ?? "all")
        
        countries = Countries
        
        countryCollectionView!.register(UINib(nibName: "CountryCellCustom", bundle: nil), forCellWithReuseIdentifier: "myCell")
        
        
    }
    
    func initSerachController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Africa", "Americas", "Asia", "Europe", "Oceania"]
        searchController.searchBar.delegate = self
    }
    
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchController.isActive){
            return filterContries.count
        }
        return countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CountryCellCustom
        if(searchController.isActive){
            cell.myImagenCell.image = UIImage(named: filterContries[indexPath.row].name)
            cell.myLabelTop.text = filterContries[indexPath.row].name
            cell.mylabel.text = filterContries[indexPath.row].capital
            
            return cell
        }
        cell.myImagenCell.image = UIImage(named: countries[indexPath.row].name)
        cell.myLabelTop.text = countries[indexPath.row].name
        cell.mylabel.text = countries[indexPath.row].region
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(searchController.isActive){
            countryManager.getBorders(filterContries[indexPath.row].borders)
            self.nameCountry = filterContries[indexPath.row].name
            Countries.removeAll()
            return
        }
        countryManager.getBorders(countries[indexPath.row].borders)
        self.nameCountry = countries[indexPath.row].name
        Countries.removeAll()
    }
    
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mycellWidth, height: mycellWidth)
    }
}




// MARK: - CountryManagerDelegate
extension CollectionViewController: CountryManagerDelegate{
    func didUpdateList(bool: Bool) {
        DispatchQueue.main.async {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "vc") as! CollectionViewController
            vc.nameCountry = self.nameCountry
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func didUpdateCountrylist(_ countryManager: CountryManager, countries: [CountryModel]) {
        DispatchQueue.main.async{
            self.countries = countries
            self.countryCollectionView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCountries(_ countryManager: CountryManager, _ country: CountryModel) {
        Countries.append(country)
    }
    
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate

extension CollectionViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForBoxTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForBoxTextAndScopeButton(searchText: String, scopeButton: String = "All"){
            self.filterContries = self.countries.filter{
            country in
            let scopeMatch = (scopeButton == "All" || country.region.lowercased().contains(scopeButton.lowercased()))
                if(self.searchController.searchBar.text != ""){
                let searchTextMatch = country.name.lowercased().contains(searchText.lowercased())

                return scopeMatch && searchTextMatch
            }else{
    
                return scopeMatch
            }
        }
        self.countryCollectionView.reloadData()
    }
}
