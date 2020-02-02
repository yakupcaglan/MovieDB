//
//  MovieLabel.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

final class MovieLabel: UILabel {
    
    private let style: Style
    
    enum Style {
        case title
        case body
        
        var font: UIFont? {
            switch self {
            case .title:
                return UIFont(name: "HelveticaNeue-Bold", size: 25)
            case .body:
                return UIFont(name: "HelveticaNeue-Medium", size: 23)
            }
        }
    }
    
    required init(style: Style) {
        self.style = style
        
        super.init(frame: .zero)
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.85
        
        backgroundColor = .imdbColor
        
        font = style.font
        textColor = .black
        
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += 16
        return size
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        let updatedRect = rect.inset(by: insets)
        super.drawText(in: updatedRect)
    }
    
}


