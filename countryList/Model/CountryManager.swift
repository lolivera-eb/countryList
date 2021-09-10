//
//  CountryManager.swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import Foundation

protocol CountryManagerDelegate: AnyObject{
    func didUpdateCountries(_ countryManager: CountryManager, _ country: CountryModel)
    func didFailWithError(error: Error)
    func didUpdateCountrylist(_ countryManager: CountryManager, countries: [CountryModel])
    func didUpdateList(bool: Bool)
}


struct CountryManager {
    
    weak var delegate: CountryManagerDelegate?
    
    
    func getListCountry(_ name: String){
        if name == "all"{
        let urlString = URLFirstList
            performRequestList(with: urlString)
            
        }
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let country = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCountries(self, country)
                    }
                }
            }
            task.resume()
        }
    }
    
    func performRequestList(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let countries = self.parseJSONCountryModel(safeData) {
                     self.delegate?.didUpdateCountrylist(self , countries: countries)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSONCountryModel(_ countryData: Data)-> [CountryModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CountryData].self, from: countryData)
            var countries = [CountryModel]()
            for country in decodedData{
            let name = country.name
            let borders = country.borders
            let capital = country.capital
            let flag = country.flag
            let alpha3Code = country.alpha3Code
            let namelanguages = country.languages[0].name
            let nativeNamelanguages = country.languages[0].nativeName
            let region = country.region
            countries.append(CountryModel(name: name, borders: borders, capital: capital, alpha3Code: alpha3Code, flag: flag, namelanguages: namelanguages, nativeNamelanguages: nativeNamelanguages, region: region))
            }
            return countries
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func parseJSON(_ countryData: Data) -> CountryModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CountryData.self, from: countryData)
            
            let name = decodedData.name
            let borders = decodedData.borders
            let capital = decodedData.capital
            let flag = decodedData.flag
            let alpha3Code = decodedData.alpha3Code
            let namelanguages = decodedData.languages[0].name
            let nativeNamelanguages = decodedData.languages[0].nativeName
            let region = decodedData.region
            let country = CountryModel(name: name, borders: borders, capital: capital, alpha3Code: alpha3Code, flag: flag, namelanguages: namelanguages, nativeNamelanguages: nativeNamelanguages, region:region )
            
            return country
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func getBorders(_ boarder: [String]){
        for alpha3Code in boarder {
            let urlString = "\(URLapi)\(alpha3Code)"
            performRequest(with: urlString)
        }
        self.delegate?.didUpdateList(bool: true)
    }
    
        
    }

