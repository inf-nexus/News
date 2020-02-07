//
//  SourceMO+CoreDataClass.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SourceMO)
public class SourceMO: NSManagedObject {
    
    static func createSourceMO(context: NSManagedObjectContext, _sourceMO: SourceMO?, source: Source) -> SourceMO {
        let sourceMO = _sourceMO ?? SourceMO(context: context)
        sourceMO.name = source.name
        
        return sourceMO
    }
    
}
