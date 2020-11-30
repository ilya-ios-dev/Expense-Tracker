//
//  TopView.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

@IBDesignable
final class TopView: UIView {

    @IBInspectable var startColor: UIColor = #colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1)
    @IBInspectable var endColor: UIColor = #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)
    
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
