//
//  CategoryImage+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by isEmpty on 21.12.2020.
//
//

import Foundation
import CoreData


extension CategoryImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryImage> {
        return NSFetchRequest<CategoryImage>(entityName: "CategoryImage")
    }

    @NSManaged public var name: String
    @NSManaged public var category: Set<Category>?

}

// MARK: Generated accessors for category
extension CategoryImage {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}

extension CategoryImage : Identifiable {

}
