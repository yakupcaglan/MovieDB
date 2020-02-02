//
//  FavoritedTVShow+CoreDataProperties.swift
//  MovieDB
//
//  Created by yakup caglan on 1.02.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoritedTVShow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedTVShow> {
        return NSFetchRequest<FavoritedTVShow>(entityName: "FavoritedTVShow")
    }

    @NSManaged public var name: String?
    @NSManaged public var hasFavorited: Bool

}
