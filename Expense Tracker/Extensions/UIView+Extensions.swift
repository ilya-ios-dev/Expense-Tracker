//
//  UIView+Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor],
                       locations: [NSNumber]? = nil,
                       startPoint: Point = .topLeft,
                       endPoint: Point = .bottomLeft) -> CAGradientLayer {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        
        gradient.startPoint = startPoint.point
        gradient.endPoint = endPoint.point
        
        gradient.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
