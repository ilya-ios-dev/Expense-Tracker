//
//  ExpenseModel.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import Foundation

struct ExpenseModel: Hashable {
    let categoryImageName: String
    let title: String
    let description: String
    let currency: String
    let sum: Float
    
    static func getSampleData() -> [ExpenseModel]{
        return [
            ExpenseModel(categoryImageName: "airplane", title: "airplane1", description: "airplane", currency: "$", sum: 135),
            ExpenseModel(categoryImageName: "airplane", title: "airplane2", description: "airplane", currency: "$", sum: 135),
            ExpenseModel(categoryImageName: "airplane", title: "airplane3", description: "airplane", currency: "$", sum: 135),
            ExpenseModel(categoryImageName: "airplane", title: "airplane4", description: "airplane", currency: "$", sum: 135),
            ExpenseModel(categoryImageName: "airplane", title: "airplane5", description: "airplane", currency: "$", sum: 135),
            ExpenseModel(categoryImageName: "airplane", title: "airplane6", description: "airplane", currency: "$", sum: 135),
            ExpenseModel(categoryImageName: "airplane", title: "airplane7", description: "airplane", currency: "$", sum: 135)
        ]
    }
}
