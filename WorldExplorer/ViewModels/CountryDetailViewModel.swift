//  CountryDetailViewModel.swift
//  WorldExplorer
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import Foundation

@MainActor
@Observable

class CountryDetailViewModel {
    var countryDetail = CountryDetail()
    var countryName = "Germany"
    var urlString = "https://restcountries.com/v3.1/name/south%20africa"
    
    func getData() async {
        urlString = "https://restcountries.com/v3.1/name/\(countryName)"
        print("🕸️ We are accessing the url \(urlString)")
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a url from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let countryDetail = try? JSONDecoder().decode([CountryDetail].self, from: data) else {
                print("😡 JSON ERROR: Could not decode JSON from \(urlString)")
                return
            }
            self.countryDetail = countryDetail.first ?? CountryDetail()
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
}
