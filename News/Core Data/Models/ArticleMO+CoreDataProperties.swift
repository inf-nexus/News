//
//  ArticleMO+CoreDataProperties.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//
//

import Foundation
import CoreData


extension ArticleMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleMO> {
        return NSFetchRequest<ArticleMO>(entityName: "ArticleMO")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: Date?
    @NSManaged public var source: SourceMO?

}
