//
//  GradientAccent+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by isEmpty on 27.12.2020.
//
//

import Foundation
import CoreData


extension GradientAccent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GradientAccent> {
        return NSFetchRequest<GradientAccent>(entityName: "GradientAccent")
    }

    @NSManaged public var startColor: String
    @NSManaged public var endColor: String

}

extension GradientAccent : Identifiable {

}
