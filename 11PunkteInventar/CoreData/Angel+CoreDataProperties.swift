//
//  Angel+CoreDataProperties.swift
//  KatalogWK
//
//  Created by Nico Petersen on 11.11.22.
//
//

import CoreData
import Foundation

public extension Angel {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Angel> {
        return NSFetchRequest<Angel>(entityName: "Angel")
    }

    @NSManaged var discontinued: Bool
    @NSManaged var image: Data?
    @NSManaged var itemNr: String?
    @NSManaged var price: Float
    @NSManaged var title: String?
    @NSManaged var color: String?
    @NSManaged var desc: String?
    @NSManaged var tags: NSSet?

    internal var titleWrapped: String {
        title ?? ""
    }

    internal var itemNrWrapped: String {
        itemNr ?? ""
    }

    internal var descWrapped: String {
        desc ?? ""
    }

    internal var colorWrapped: String {
        color ?? ""
    }

    internal var priceString: String {
        return "\(price)"
    }
}

// MARK: Generated accessors for tags

public extension Angel {
    @objc(addTagsObject:)
    @NSManaged func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged func removeFromTags(_ values: NSSet)
}

extension Angel: Identifiable {}
