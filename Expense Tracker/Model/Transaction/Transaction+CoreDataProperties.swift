//
//  Transaction+CoreDataProperties.swift
//  Expense Tracker
//
//  Created by isEmpty on 15.12.2020.
//
//

import Foundation
import CoreData


extension Transaction {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }
    
    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var isExpense: Bool
    @NSManaged public var name: String
    @NSManaged public var balance: Balance
    @NSManaged public var category: Category
    
    @discardableResult
    class func create(in context: NSManagedObjectContext, amount: Double, date: Date, isExpense: Bool, name: String, balance: Balance, category: Category) -> Transaction {
        let transaction = Transaction(context: context)
        transaction.amount = amount
        transaction.date = date
        transaction.isExpense = isExpense
        transaction.name = name
        transaction.balance = balance
        transaction.category = category

        return transaction
    }    
}

extension Transaction : Identifiable {
    
}
