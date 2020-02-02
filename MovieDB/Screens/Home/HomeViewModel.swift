//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

protocol HomeViewModelProtocol: class {
    var delegate: HomeViewModelDelegate? { get }
    
    var numberOfItems: Int { get }
    
    var isRefreshing: Bool { get }

    func item(by index: Int) -> TVShowData?
    
    func fetchPopulerTVShows()
    
    func checkNewPopulerTvShows() -> Int
    
    func updateTVShows(newTVShows: [TVShowData]) -> Int
    
    func addFavorite(at index: Int, hasFavorited: Bool)
    
    func removeFavorite(at index: Int )
    
    func favoriteStatus(at index: Int, _ hasFavorited: Bool)
}

protocol HomeViewModelDelegate: class {
    
    func itemsDidLoad()
    
    func refreshStateDidChange()
}

final class HomeViewModel: HomeViewModelProtocol {
  
    
    weak var delegate: HomeViewModelDelegate?

    private let networkService: NetworkService
    private let coredataManager: CoreDataManager


    private var tvShows: [TVShowData] = [] {
        didSet {
            delegate?.itemsDidLoad()
        }
    }
    
    private var newTvShows = [TVShowData]()
    
    private var favoritedTVShows = [FavoritedTVShow] ()

    
    public required init(networkService: NetworkService, coreDataManager: CoreDataManager) {
        self.networkService = networkService
        self.coredataManager = coreDataManager
    }
    
    func item(by index: Int) -> TVShowData? {
        let items = tvShows
        guard items.indices.contains(index) else { return nil }
        let sortedItems = items.sorted { $0.voteAverage > $1.voteAverage}
        return sortedItems[index]
    }
    
    var numberOfItems: Int {
        return tvShows.count
    }
    
    var isRefreshing: Bool = false {
        didSet {
            if isRefreshing {
                delegate?.refreshStateDidChange()
            }
        }
    }
    
    func addFavorite(at index: Int, hasFavorited: Bool) {
        do {
            try coredataManager.insert(type: FavoritedTVShow.self, changeOnObject: { (tvShow) in
            tvShow.setValue(tvShows[index].name, forKey: "name")
            tvShow.setValue(hasFavorited, forKey: "hasFavorited")
            favoritedTVShows.append(tvShow)
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func removeFavorite(at index: Int) {
        for tvShow in favoritedTVShows {
            do {
                try coredataManager.delete(by: tvShow.objectID)
                favoritedTVShows.removeAll {$0 == tvShow}
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    func favoriteStatus(at index: Int, _ hasFavorited: Bool) {
        if hasFavorited {
            addFavorite(at: index, hasFavorited: hasFavorited)
        } else {
            removeFavorite(at: index)
        }
    }
    
    private var currentPage: Int = 0
      
    private var nextPage: Int {
        if currentPage == 0 {
            return 1
        }
        
        return currentPage + 1
    }
    
    func updateTVShows(newTVShows: [TVShowData]) -> Int {
        var updateItems = 0
        
        for newTVShow in newTVShows {
            if var filteredTVShow = tvShows.first(where: { $0.id == newTVShow.id && $0.voteAverage == newTVShow.voteAverage }) {
                filteredTVShow.voteAverage = newTVShow.voteAverage
                updateItems += 1
            }
        }
        return updateItems
    }
    
    func checkNewPopulerTvShows() -> Int {
        var updateItem = 0
        
        networkService.getTvShows(1) {[weak self] (data) in
            guard let self = self else { return }
            switch data {
            case .success(let data):
                updateItem = self.updateTVShows(newTVShows: data.results)
            case .failure(let error):
                print(error)
            }
        }
        
        return updateItem
    }
    
    func fetchPopulerTVShows() {
        networkService.getTvShows(nextPage) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.currentPage = data.page
                self.tvShows.append(contentsOf: data.results)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}

