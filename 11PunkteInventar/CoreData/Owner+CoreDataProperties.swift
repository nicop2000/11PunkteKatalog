//
//  Owner+CoreDataProperties.swift
//  KatalogWK
//
//  Created by Nico Petersen on 09.11.22.
//
//

import CoreData
import Foundation

public extension Owner {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: "Owner")
    }

    @NSManaged var name: String?
    @NSManaged var id: String?
    @NSManaged var angels: NSSet?

    internal var nameWrapped: String {
        name ?? ""
    }

    internal var idWrapped: String {
        id ?? ""
    }
}

extension Owner: Identifiable {}
