//
//  PersistentObject.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation
import CoreData

protocol PersistentObject {
    associatedtype ManagedObjectType: NSManagedObject
    
    var managedObject: ManagedObjectType? { get set }
    
    init(_ managedObject: ManagedObjectType)
    
    func persist(context: NSManagedObjectContext, save: Bool) -> ManagedObjectType
    
}
