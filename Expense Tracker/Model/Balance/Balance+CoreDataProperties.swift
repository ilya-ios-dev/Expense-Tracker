//
//  Balance+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by isEmpty on 16.12.2020.
//
//

import Foundation
import CoreData


extension Balance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Balance> {
        return NSFetchRequest<Balance>(entityName: "Balance")
    }

    @NSManaged public var totalBalance: Double
    @NSManaged public var transactions: Set<Transaction>?
    
    @nonobjc public var expense: Double? {
        willAccessValue(forKey: "transactions")
        let count = transactions?.filter{ $0.isExpense }.map{$0.amount}.reduce(0.0, +)
        didAccessValue(forKey: "transactions")
        return count
    }
    
    @nonobjc public var income: Double? {
        willAccessValue(forKey: "transactions")
        let count = transactions?.filter{ !$0.isExpense }.map{$0.amount}.reduce(0.0, +)
        didAccessValue(forKey: "transactions")
        return count
    }


}

// MARK: Generated accessors for transactions
extension Balance {

    @objc(insertObject:inTransactionsAtIndex:)
    @NSManaged public func insertIntoTransactions(_ value: Transaction, at idx: Int)

    @objc(removeObjectFromTransactionsAtIndex:)
    @NSManaged public func removeFromTransactions(at idx: Int)

    @objc(insertTransactions:atIndexes:)
    @NSManaged public func insertIntoTransactions(_ values: [Transaction], at indexes: NSIndexSet)

    @objc(removeTransactionsAtIndexes:)
    @NSManaged public func removeFromTransactions(at indexes: NSIndexSet)

    @objc(replaceObjectInTransactionsAtIndex:withObject:)
    @NSManaged public func replaceTransactions(at idx: Int, with value: Transaction)

    @objc(replaceTransactionsAtIndexes:withTransactions:)
    @NSManaged public func replaceTransactions(at indexes: NSIndexSet, with values: [Transaction])

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSOrderedSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSOrderedSet)

}

extension Balance : Identifiable {

}
