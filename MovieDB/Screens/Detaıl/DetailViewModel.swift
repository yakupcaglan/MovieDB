//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

protocol DetailViewModelProtocol: class {
    var delegate: DetailViewModelDelegate? { get }
    
    func loadTVShowData()
}

protocol DetailViewModelDelegate: class {
    
    func tvShowDetailDidLoad(_ data: TVShowDetail)
}

class DetailViewModel: DetailViewModelProtocol {
    
    weak var delegate: DetailViewModelDelegate?

    
    private var tvShowDetail: TVShowDetail? {
        didSet {
            if let tvShowDetail = tvShowDetail {
                delegate?.tvShowDetailDidLoad(tvShowDetail)
            }
        }
    }
    private let id: Int
    private let networkService: NetworkService
    
    public required init (id: Int, networkService: NetworkService ) {
        self.id = id
        self.networkService = networkService
    }
    
    func loadTVShowData() {
        
        networkService.getShowDetils(id) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.tvShowDetail = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
