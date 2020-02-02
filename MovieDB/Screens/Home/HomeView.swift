//
//  HomeView.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: LayoutableView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        collectionView.register(TVShowCell.self)
        collectionView.backgroundColor = .mainColor
        return collectionView
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.alpha = 0.0
        button.setTitle("Refresh", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 68, green: 143, blue: 227)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    func setupViews() {

        add(collectionView, refreshButton)
    
    }
    
    func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        refreshButton.snp.makeConstraints {
            $0.top.equalTo(safeArea.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(32)
        }
    }
}
