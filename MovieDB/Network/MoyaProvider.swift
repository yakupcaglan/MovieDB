//
//  MoyaProvider.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Moya

extension MoyaProvider {
    @discardableResult func request<T: Decodable>(_ target: Target, dataType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) -> Cancellable {
        self.request(target) { (result) in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(dataType, from: response.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}
