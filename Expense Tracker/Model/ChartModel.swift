//
//  ChartModel.swift
//  Expense Tracker
//
//  Created by isEmpty on 04.12.2020.
//

import Foundation

struct ChartModel {
    let balance: String
    let points: [GraphModel]
}

struct GraphModel {
    let progress: Int
    let step: Int
}
