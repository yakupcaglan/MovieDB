//
//  MovieDetailLabel.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

final class MovieDetailLabel: UILabel {
    
    required init() {
        
        super.init(frame: .zero)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.85
    
        textColor = .white
                    
        UIFont(name: "HelveticaNeue-Medium", size: 16)
   
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
