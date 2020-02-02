//
//  TVShowCell.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit
import SDWebImage


final class TVShowCell: CollectionViewCell<TVShowData> {
    
    
    override func updateLayoutItem(item: TVShowData?) {
        guard let item = item else { return }
        
        titleLabel.text = item.name
        voteAverageLabel.text = "\(item.voteAverage)"
        
        if let url = item.posterURL {
            imageView.sd_setImage(with: url)
        }
        
        indicatorView.stopAnimating()
        
    }
    
    private var hasFavorited: Bool = false
    
    private lazy var favoriTVShows = [FavoritedTVShow]()
    
    private lazy var titleLabel = MovieLabel(style: .title)
    
    private lazy var voteAverageLabel = MovieLabel(style: .body)
        
    private lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        return view
    }()
    
    lazy var starButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "star"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indocatorV = UIActivityIndicatorView(style: .large)
        indocatorV.color = .white
        indocatorV.hidesWhenStopped = true
        indocatorV.startAnimating()
        return indocatorV
    }()
    
    override func setupViews() {
        backgroundColor = .white
        
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        imageView.addSubview(dimView)
        
//        starButton.addTarget(self, action: #selector(toggleFav), for: .touchUpInside)

        add(imageView, starButton, voteAverageLabel, titleLabel, indicatorView)
    }
    

    override func setupLayout() {
        
        starButton.snp.makeConstraints {
            $0.trailing.equalTo(-12)
            $0.top.equalTo(20)
            $0.width.height.equalTo(40)
        }
        
        dimView.snp.makeConstraints { 
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        voteAverageLabel.snp.makeConstraints {
            $0.bottom.equalTo(titleLabel.snp.top).offset(-16)
            $0.leading.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
            $0.bottom.equalTo(-16)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
