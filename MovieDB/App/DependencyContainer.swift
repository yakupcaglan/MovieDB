//
//  DependencyContainer.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

final class DependencyContainer {
    
    private let networkService: NetworkService
    private let coreDataManager: CoreDataManager
    
    public required init(networkService: NetworkService = .init(), coreDataManager: CoreDataManager = .init()) {
        self.networkService = networkService
        self.coreDataManager = coreDataManager
    }
    
}

extension DependencyContainer: ViewControllerFactory {
    
    func makeHomeViewController() -> HomeViewController {
        let viewModel = HomeViewModel(networkService: networkService, coreDataManager: coreDataManager)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
    
    func makeDetailViewController(tvShowID: Int) -> DetailViewController {
        let viewModel = DetailViewModel(id: tvShowID, networkService: self.networkService)
        let viewController = DetailViewController(viewModel: viewModel)
        return viewController
    }
    
}
