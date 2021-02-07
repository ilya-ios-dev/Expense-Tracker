//
//  RoundedGradientButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 15.12.2020.
//

import UIKit

@IBDesignable
final class RoundedGradientButton: UIButton {
    //MARK: - Properties
    private let appSettings = AppSettings.shared
    
    //MARK: - Drawing
    override func draw(_ rect: CGRect) {
        configureButton(rect)
    }
    
    private func configureButton(_ frame: CGRect) {
        layer.cornerRadius = frame.height / 2
        let startColor = appSettings.startColor
        let endColor = appSettings.endColor
        layer.shadowColor = [startColor, endColor].averageColor().cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        applyGradient(colours: [startColor, endColor], startPoint: .topRight, endPoint: .bottomLeft)
    }
}
