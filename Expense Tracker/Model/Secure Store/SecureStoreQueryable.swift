//
//  SecureStoreQueryable.swift
//  Expense Tracker
//
//  Created by isEmpty on 24.12.2020.
//

import Foundation

public protocol SecureStoreQueryable {
    var query: [String: Any] { get }
}
