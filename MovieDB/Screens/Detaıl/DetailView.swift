//
//  DetailView.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class DetailView: LayoutableView {
    
    
    private lazy var topView = UIView()

    private lazy var bottomView = UIView()
       
    private lazy var titleLabel = MovieLabel(style: .title)
    
    private lazy var voteAverage = MovieLabel(style: .title)
    
    private lazy var numberOfSeasonLabel = MovieDetailLabel()
    
    private lazy var statusLabel = MovieDetailLabel()
        
    private lazy var subtitleLabel = MovieDetailLabel()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    
    private lazy var overviewTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        return textView
    }()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorV = UIActivityIndicatorView(style: .large)
        indicatorV.hidesWhenStopped = true
        indicatorV.color = .white
        indicatorV.startAnimating()
        return indicatorV
    }()
    
    func updateTVShowDetail(_ data: TVShowDetail) {
       
        titleLabel.text = data.name
        numberOfSeasonLabel.text = "\(data.numberOfSeasons)"
        statusLabel.text = data.status
        overviewTextView.text = data.overview
        subtitleLabel.text = "\(data.originalLanguage.uppercased()), \(data.type), \(data.date)"
        
        imageView.sd_setImage(with: data.posterURL)
        
        indicatorView.stopAnimating()
    }
    func setupViews() {
        backgroundColor = .black
        
        topView.add(imageView)
        add(topView, bottomView, indicatorView)
        bottomView.add(titleLabel, voteAverage, overviewTextView, statusLabel, subtitleLabel)
      
        bottomView.backgroundColor = .black
        
        
    }
    
    func setupLayout() {
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeArea.top)
            $0.height.equalToSuperview().multipliedBy(0.43)
            $0.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
            $0.leading.equalTo(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }
        
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(subtitleLabel)
        }
    
        overviewTextView.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom)
            $0.leading.equalTo(12)
            $0.height.equalToSuperview().multipliedBy(0.65)
            $0.trailing.equalTo(-12)
        }
        
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
