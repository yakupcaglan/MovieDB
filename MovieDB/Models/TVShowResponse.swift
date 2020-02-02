//
//  APIResults.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

struct TVShowsResponse: Decodable {
    let page: Int
    let results: [TVShowData]
}

struct TVShowData: Decodable {
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    let id: Int
    let name: String
    var voteAverage: Double
    
    private let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, id
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}
