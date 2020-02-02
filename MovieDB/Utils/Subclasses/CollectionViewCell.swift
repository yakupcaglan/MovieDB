//
//  CollectionViewCell.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class CollectionViewCell<T>: UICollectionViewCell {
    
    var item: T? {
        didSet {
            updateLayoutItem(item: item)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
    
    func setupLayout() {}
    
    func updateLayoutItem(item: T?) {}
}
