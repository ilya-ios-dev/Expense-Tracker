//
//  CustomButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 15.12.2020.
//

import UIKit

final class CustomButton: UIButton {
    
    private var gradientLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    private func configureButton() {
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = backgroundColor?.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    override var isEnabled: Bool {
        didSet {
            gradientLayer?.removeFromSuperlayer()
            if isEnabled {
                let startGradient = CGPoint(x: -0.5, y: 1.5)
                let endGradient = CGPoint(x: 1.5, y: -0.5)
                gradientLayer = self.applyGradient(colours: [#colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)], startPoint: .custom(point: startGradient), endPoint: .custom(point: endGradient))
            }
        }
    }
}
