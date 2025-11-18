//  Country.swift
//  WorldExplorer
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import Foundation

struct Country: Codable, Identifiable {
    let id = UUID().uuidString
    var name: Name
    var flag: String
    
    enum CodingKeys: CodingKey {
        case name, flag
    }
}

struct Name: Codable {
    var common: String
}
