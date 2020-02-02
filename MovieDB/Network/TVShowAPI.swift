//
//  TVShowAPI.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Moya

public enum TVShowAPI {
    case getPopulerTVShows(page: Int)
    case getTVShowDetail(id: Int)
}

extension TVShowAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }

    public var path: String {
        switch self {
        case .getPopulerTVShows:
            return "tv/popular"
        case .getTVShowDetail(let id):
            return "tv/\(id)"
        }
    }

    public var method: Method {
        switch self {
        case .getPopulerTVShows:
            return .get
        case .getTVShowDetail:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        var parameters = NetworkService.createRequestParameters()
        
        switch self {
        case .getPopulerTVShows(let page):
            parameters["page"] = page
        case .getTVShowDetail(let id):
            parameters["id"] = id
        }
    
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    public var headers: [String : String]? {
        return nil
    }
    
    
}
