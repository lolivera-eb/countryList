//
//  CountryManager.swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import Foundation

protocol CountryManagerDelegate{
    func didUpdateCountry(_ countryManager: CountryManager, country: CountryModel)
    func didFailWithError(error: Error)
}


struct CountryManager {
    
    var delegate: CountryManagerDelegate?
    
    func fetchCountry(countryName: String){
        let urlString = "\(URLapi)\(countryName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let country = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCountry(self , country: country)
                    }
                }
            }
            task.resume()
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
            let namelanguages = decodedData.languages[0].name
            let nativeNamelanguages = decodedData.languages[0].nativeName
            
            let country = CountryModel(name: name, borders: borders, capital: capital, flag: flag, namelanguages: namelanguages, nativeNamelanguages: nativeNamelanguages)
            
            return country
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func getBorders(_ boarder: [String])->[CountryListModel]{
        var newcountry:[CountryListModel] = []
        for i in Countries {
            if boarder.contains(i.alpha3Code){
                newcountry.append(CountryListModel(name: i.name, alpha3Code: i.alpha3Code))
            }
        }
        return newcountry
    }
}

