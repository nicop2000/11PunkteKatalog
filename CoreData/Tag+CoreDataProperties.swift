//
//  Tag+CoreDataProperties.swift
//  KatalogWK
//
//  Created by Nico Petersen on 11.11.22.
//
//

import CoreData
import Foundation

public extension Tag {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged var value: String?
    @NSManaged var angel: NSSet?

    internal var valueWrapped: String {
        value ?? ""
    }
}

// MARK: Generated accessors for angel

public extension Tag {
    @objc(addAngelObject:)
    @NSManaged func addToAngel(_ value: Angel)

    @objc(removeAngelObject:)
    @NSManaged func removeFromAngel(_ value: Angel)

    @objc(addAngel:)
    @NSManaged func addToAngel(_ values: NSSet)

    @objc(removeAngel:)
    @NSManaged func removeFromAngel(_ values: NSSet)
}

extension Tag: Identifiable {}
