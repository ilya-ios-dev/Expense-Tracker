//
//  TopView.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

@IBDesignable
final class TopView: UIView {

    @IBInspectable var startColor: UIColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
    @IBInspectable var endColor: UIColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorsSpace: colorSpace,
                                        colors: colors as CFArray,
                                        locations: colorLocations) else { return }
        
        let startPoint = CGPoint(x: 0, y: rect.height)
        let endPoint = CGPoint(x: rect.width, y: 0)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [CGGradientDrawingOptions(rawValue: 0)])
    }
    
}
