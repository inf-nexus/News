//
//  SourceMO+CoreDataProperties.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//
//

import Foundation
import CoreData


extension SourceMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceMO> {
        return NSFetchRequest<SourceMO>(entityName: "SourceMO")
    }

    @NSManaged public var name: String?
    @NSManaged public var article: ArticleMO?

}
