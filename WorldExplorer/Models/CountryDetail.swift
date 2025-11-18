//  CountryDetail.swift
//  WorldExplorer
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import Foundation

struct CountryDetail: Codable {
    var subregion: String = ""
    var capital: [String] = []
    var flags = Flags()
    var coatOfArms = CoatOfArms()
    
    struct Flags: Codable {
        var png = ""
    }
    
    struct CoatOfArms: Codable {
        var png: String? = ""
    }
}
