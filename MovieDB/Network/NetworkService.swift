//
//  Service.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import Moya

public enum APIError: Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
}

protocol NetworkServiceProtocol: class {
    static func createRequestParameters() -> [String : Any]
    
    func getTvShows(_ page: Int, complation: @escaping (Result<TVShowsResponse, APIError>) -> Void)
    func getShowDetils(_ id: Int, complation: @escaping (Result<TVShowDetail, APIError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    #if DEBUG
    private let provider = MoyaProvider<TVShowAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    #else
    private let provider = MoyaProvider<TVShowAPI>()
    #endif
         
    func getTvShows(_ page: Int, complation: @escaping (Result<TVShowsResponse, APIError>) -> Void) {
        provider.request(.getPopulerTVShows(page: page), dataType: TVShowsResponse.self) { (result) in
            switch result {
            case .success(let result):
                complation(.success(result))
            case .failure(let error):
                complation(.failure(APIError.networkError(error)))
            }
        }
    }
    
    func getShowDetils(_ id: Int, complation: @escaping (Result<TVShowDetail, APIError>) -> Void) {
        provider.request(.getTVShowDetail(id: id), dataType: TVShowDetail.self) { (result) in
            switch result {
            case .success(let result):
                complation(.success(result))
            case .failure(let error):
                complation(.failure(APIError.networkError(error)))
            }
            
        }
    }
    
    static func createRequestParameters() -> [String : Any] {
        var parameters = [String: Any]()
        
        parameters["api_key"] = "e700d5f428fd2d7f826f5570aa5c4048"
        
        return parameters
    }
}
