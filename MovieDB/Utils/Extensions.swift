//
//  Extensions.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation
import SnapKit

extension UIView {
    func add(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    var safeArea: ConstraintBasicAttributesDSL {
        #if swift(>=3.2)
        if #available(iOS 11, *) {
            return self.safeAreaLayoutGuide.snp
        }
        return self.snp
        #else
        return self.snp
        #endif
    }
}

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let mainColor = UIColor.rgb(red: 236, green: 240, blue: 241)
    
    static let imdbColor = UIColor.rgb(red: 238, green: 198, blue: 72)

}
