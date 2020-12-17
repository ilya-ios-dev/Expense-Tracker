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
    @NSManaged @objc dynamic public var transactions: Set<Transaction>?
    
    /// Returns expense` transactions for the entire period.
    @nonobjc public var expense: Double? {
        willAccessValue(forKey: "transactions")
        let expense = transactions?.filter{ $0.isExpense }.map{$0.amount}.reduce(0.0, +)
        didAccessValue(forKey: "transactions")
        return expense
    }
    
    /// Returns `income` transactions for the entire period.
    @nonobjc public var income: Double? {
        willAccessValue(forKey: "transactions")
        let income = transactions?.filter{ !$0.isExpense }.map{$0.amount}.reduce(0.0, +)
        didAccessValue(forKey: "transactions")
        return income
    }

    //MARK: - Transaction for day
    /// Returns  sum of all transactions for a given `Date`.
    @nonobjc public func getSumForDay(_ day: Date) -> Double?{
        willAccessValue(forKey: "transactions")
        let sum = transactions?
            .filter{ $0.date > day.startOfDay && $0.date < day.endOfDay }
            .map{ $0.amount }
            .reduce(0, +)
        didAccessValue(forKey: "transactions")
        return sum
    }
    
    /// Returns  sum of `expense` transactions for a given month.
    @nonobjc public func getExpenseForDay(_ date: Date) -> Double?{
        willAccessValue(forKey: "transactions")
        let expense = transactions?
            .filter{ $0.date > date.startOfDay && $0.date < date.endOfDay && $0.isExpense }
            .map{ $0.amount }
            .reduce(0, +)
        didAccessValue(forKey: "transactions")
        return expense
    }
    
    /// Returns  sum of `expense` transactions for a given month.
    @nonobjc public func getIncomeForDay(_ date: Date) -> Double?{
        willAccessValue(forKey: "transactions")
        let expense = transactions?
            .filter{ $0.date > date.startOfDay && $0.date < date.endOfDay && !$0.isExpense }
            .map{ $0.amount }
            .reduce(0, +)
        didAccessValue(forKey: "transactions")
        return expense
    }
    
    //MARK: - Transaction for month
    /// Returns  sum of `expense` transactions for a given month.
    @nonobjc public func getExpenseForMonth(_ date: Date) -> Double?{
        willAccessValue(forKey: "transactions")
        let expense = transactions?
            .filter{ $0.date > date.startOfMonth && $0.date < date.endOfMonth && $0.isExpense }
            .map{ $0.amount }
            .reduce(0, +)
        didAccessValue(forKey: "transactions")
        return expense
    }
    
    /// Returns  sum of `income` transactions for a given month.
    @nonobjc public func getIncomeForMonth(_ date: Date) -> Double?{
        willAccessValue(forKey: "transactions")
        let income = transactions?
            .filter{ $0.date > date.startOfMonth && $0.date < date.endOfMonth && !$0.isExpense }
            .map{ $0.amount }
            .reduce(0, +)
        didAccessValue(forKey: "transactions")
        return income
    }
    
    /// Returns an array of items grouped by `month`.
    /// Items are summarized by transactions per day.
    @nonobjc public func getTransactionsForMonth(_ month: Date) -> [GraphPoint]?{
        willAccessValue(forKey: "transactions")
        let daysList = transactions?
            .filter{ $0.date > month.startOfMonth && $0.date < month.endOfMonth }
            .groupSort(ascending: true, byDate: {$0.date})
            .map{ trans -> GraphPoint in
                let sum = trans.map{ $0.amount }.reduce(0, +)
                let date = trans[0].date
                return GraphPoint(value: sum, date: date)
            }
        didAccessValue(forKey: "transactions")
        return daysList
    }
    
    @nonobjc public func getMonthList() -> [Date]?{
        willAccessValue(forKey: "transactions")
        let daysList = transactions?
            .groupSort(ascending: true, byDate: {$0.date.startOfMonth})
            .map{
                //get the first item from the list of transactions grouped by month.
                $0.first!
                    .date
                    .startOfMonth
            }
        didAccessValue(forKey: "transactions")
        return daysList
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
