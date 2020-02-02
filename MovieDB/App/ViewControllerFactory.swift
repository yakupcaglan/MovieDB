//
//  ViewControllerFactory.swift
//  MovieDB
//
//  Created by yakup caglan on 30.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import Foundation

protocol ViewControllerFactory: class {
    func makeHomeViewController() -> HomeViewController
    
    func makeDetailViewController(tvShowID: Int) -> DetailViewController
}
