//
//  TVShow.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

struct TVShowDetail: Decodable {
    
    var posterURL: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    
    let name: String
    let originalLanguage: String
    let overview: String
    let date: String
    let numberOfSeasons: Int
    let status: String
    let type: String
    var voteAverage: Float
    
    private let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, status, type, overview
        case date = "last_air_date"
        case voteAverage = "vote_average"
        case originalLanguage = "original_language"
        case numberOfSeasons = "number_of_seasons"
        case posterPath = "poster_path"
    }
}
