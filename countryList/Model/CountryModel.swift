//
//  CountryModel.swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import Foundation


struct CountryModel {
    let name: String
    let borders: [String]
    let capital: String
    let alpha3Code: String
    let flag: String
    let namelanguages: String
    let nativeNamelanguages: String
    let region: String
}


struct CountryListModel {
    let name: String
    let alpha3Code: String
}
