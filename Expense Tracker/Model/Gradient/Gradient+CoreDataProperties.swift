//
//  Gradient+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by isEmpty on 21.12.2020.
//
//

import Foundation
import CoreData


extension Gradient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gradient> {
        return NSFetchRequest<Gradient>(entityName: "Gradient")
    }

    @NSManaged public var endColor: String
    @NSManaged public var startColor: String
    @NSManaged public var category: Set<Category>?

}

// MARK: Generated accessors for category
extension Gradient {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}

extension Gradient : Identifiable {

}
