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

    internal var itemNrDisplay: String {
        Helper.sliceItemNr(itemNr ?? "")
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

    private func containsString(_ filter: String) -> Bool {
        let simpleValuesContain =
            (titleWrapped.lowercased().contains(filter.lowercased())) ||
            (priceString.lowercased().contains(filter.lowercased())) ||
            (itemNrWrapped.lowercased().contains(filter.lowercased())) ||
            (descWrapped.lowercased().contains(filter.lowercased())) ||
            (colorWrapped.lowercased().contains(filter.lowercased()))

        if simpleValuesContain { return true }
        for tag in tags.toTagSet() {
            if tag.valueWrapped.lowercased().contains(filter.lowercased()) {
                return true
            }
        }
        return false
    }

    func matchesSomeInStringList(_ list: [String]) -> Bool {
        for filter in list {
            if containsString(filter) {
                return true
            }
        }
        return false
    }

    func matchesAllInStringList(_ list: [String]) -> Bool {
        var result: [Bool] = []
        for filter in list {
            result.append(containsString(filter))
        }
        if result.contains(false) { return false }
        return true
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
