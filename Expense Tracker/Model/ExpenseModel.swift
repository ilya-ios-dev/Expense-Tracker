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
        var arr = [ExpenseModel]()
        (0...5).forEach { (i) in
            arr.append(ExpenseModel(categoryImageName: "airplane", title: "airplane\(i)", description: "", currency: "", sum: 0))
        }
        return arr
    }
}
