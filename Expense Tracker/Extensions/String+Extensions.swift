//
//  String+Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.12.2020.
//

import Foundation

extension String {
    /// Returns NSLocalizedString without comments.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
