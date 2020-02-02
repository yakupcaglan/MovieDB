//
//  DetailViewController.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class DetailViewController: LayoutingViewController {
    
    typealias ViewType = DetailView
    
    private let viewModel: DetailViewModel
    
    public required init (viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = ViewType.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TV Show Detail"
        viewModel.delegate = self
        
        viewModel.loadTVShowData()
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func tvShowDetailDidLoad(_ data: TVShowDetail) {
        layoutableView.updateTVShowDetail(data)
    }
}
