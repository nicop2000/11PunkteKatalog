//
//  AngelOwner+CoreDataProperties.swift
//  KatalogWK
//
//  Created by Nico Petersen on 10.11.22.
//
//

import CoreData
import Foundation

public extension AngelOwner {
    @nonobjc class func fetchRequest() -> NSFetchRequest<AngelOwner> {
        return NSFetchRequest<AngelOwner>(entityName: "AngelOwner")
    }

    @NSManaged var itemNr: String?
    @NSManaged var ownerId: String?
    @NSManaged var count: Int16

    internal var itemNrWrapped: String {
        itemNr ?? ""
    }

    internal var ownerIdWrapped: String {
        ownerId ?? ""
    }
}

extension AngelOwner: Identifiable {}
