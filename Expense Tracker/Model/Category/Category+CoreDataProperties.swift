//
//  Category+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by isEmpty on 15.12.2020.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String
    @NSManaged public var categoryImage: CategoryImage
    @NSManaged public var gradient: Gradient
    @NSManaged public var transactions: NSSet?

    @discardableResult
    class func create(in context: NSManagedObjectContext, name: String, categoryImage: CategoryImage, gradient: Gradient) -> Category {
        let category = Category(context: context)
        category.name = name
        category.categoryImage = categoryImage
        category.gradient = gradient
        return category
    }

}

extension Category : Identifiable {

}
