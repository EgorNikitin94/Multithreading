//
//  FavoritPost+CoreDataProperties.swift
//  Navigation
//
//  Created by Егор Никитин on 16.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoritPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritPost> {
        return NSFetchRequest<FavoritPost>(entityName: "FavoritPost")
    }

    @NSManaged public var author: String?
    @NSManaged public var desc: String?
    @NSManaged public var image: Data?
    @NSManaged public var likes: String?
    @NSManaged public var views: String?

}
