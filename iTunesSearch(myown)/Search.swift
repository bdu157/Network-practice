//
//  Search.swift
//  iTunesSearch(myown)
//
//  Created by Dongwoo Pae on 6/8/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    var results: [Search]
}

struct Search: Codable {
    var title: String?
    var creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

