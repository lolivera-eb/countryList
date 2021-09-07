//
//  Constants .swift
//  countryList
//
//  Created by lolivera on 06/09/2021.
//

import Foundation

var Countries = [
    CountryListModel(name: "Argentina", alpha3Code: "ARG"),
    CountryListModel(name: "Bolivia (Plurinational State of)", alpha3Code: "BOL"),
    CountryListModel(name: "Brazil", alpha3Code: "BRA"),
    CountryListModel(name: "Chile", alpha3Code: "CHL"),
    CountryListModel(name: "Colombia", alpha3Code: "COL"),
    CountryListModel(name: "Ecuador", alpha3Code: "ECU"),
    CountryListModel(name: "Guyana", alpha3Code: "GUY"),
    CountryListModel(name: "Paraguay", alpha3Code: "PRY"),
    CountryListModel(name: "Peru", alpha3Code: "PER"),
    CountryListModel(name: "Uruguay", alpha3Code: "URY"),
    CountryListModel(name: "Venezuela", alpha3Code: "VEN"),
]

let URLapi = "https://restcountries.eu/rest/v2/alpha/"

let URLList = "https://restcountries.eu/rest/v2/regionalbloc/USAN"
