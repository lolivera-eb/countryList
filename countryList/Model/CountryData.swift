//
//  CountryData.swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import Foundation



struct CountryData:Codable {
    let name: String
    let borders: [String]
    let capital: String
    let flag: String
    let languages: [Language]
}

struct Language: Codable {
    let name, nativeName: String
}

