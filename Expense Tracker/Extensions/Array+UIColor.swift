//
//  Array+UIColor.swift
//  Expense Tracker
//
//  Created by isEmpty on 28.12.2020.
//

import UIKit

extension Array where Element: UIColor {
    func averageColor() -> UIColor {
        let rgba = self.map{ $0.rgba }
        let count = CGFloat(self.count)
        let r = rgba.reduce(0) { $0 + $1.red } / count
        let g = rgba.reduce(0) { $0 + $1.green } / count
        let b = rgba.reduce(0) { $0 + $1.blue } / count
        let a = rgba.reduce(0) { $0 + $1.alpha } / count
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
