//
//  CustomButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 15.12.2020.
//

import UIKit

@IBDesignable
final class CustomButton: UIButton {
        
    override func draw(_ rect: CGRect) {
        configureButton(rect)
    }
    
    private func configureButton(_ frame: CGRect) {
        layer.cornerRadius = frame.height / 2
        let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        layer.shadowColor = endColor.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
        applyGradient(colours: [startColor, endColor], startPoint: .topRight, endPoint: .bottomLeft)

    }
}
