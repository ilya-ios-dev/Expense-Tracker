//
//  GradientView.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

@IBDesignable
public final class GradientView: UIView {
    
    //MARK: - Properties
    @IBInspectable var startColor: UIColor = AppSettings.shared.startColor
    @IBInspectable var endColor: UIColor = AppSettings.shared.endColor

    //MARK: - Drawing
    public override func draw(_ rect: CGRect) {
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
