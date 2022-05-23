//
//  FavoriteMovie+CoreDataProperties.swift
//  Kitabisa Assessment App
//
//  Created by Aldino Grasepta on 13/04/22.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var movieId: Int32

}

extension FavoriteMovie : Identifiable {

}
