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
        layer.shadowColor = UIColor(hex: "#894BD3")?.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        applyGradient(colours: [#colorLiteral(red: 0.537254902, green: 0.2941176471, blue: 0.8274509804, alpha: 1), #colorLiteral(red: 0.4, green: 0.2352941176, blue: 0.7568627451, alpha: 1)], startPoint: .topRight, endPoint: .bottomLeft)

    }
}
