//  CountryViewModel.swift
//  WorldExplorer
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import Foundation

@MainActor
@Observable

class CountryViewModel {
    var countries: [Country] = []
    var region = "europe"
    var urlString = "https://restcountries.com/v3.1/region/europe"
    
    func getData() async {
        urlString = "https://restcountries.com/v3.1/region/\(region)"
        print("🕸️ We are accessing the url \(urlString)")
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a url from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let countries = try? JSONDecoder().decode([Country].self, from: data) else {
                print("😡 JSON ERROR: Could not decode JSON from \(urlString)")
                return
            }
            print("😎 JSON RETURNED: countries.count = \(countries.count)")
            self.countries = countries
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
}
