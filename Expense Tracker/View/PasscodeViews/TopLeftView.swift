//
//  TopLeftView.swift
//  Expense Tracker
//
//  Created by isEmpty on 24.12.2020.
//

import UIKit
@IBDesignable
final class TopLeftView: UIView {

    override func draw(_ rect: CGRect) {
        //// Color Declarations
        let fillColor2 = UIColor(red: 0.482, green: 0.212, blue: 0.855, alpha: 1.000)

        let path = UIBezierPath()
        /// 124 | 125
        let width = rect.maxX - rect.minX
        let height = rect.maxY - rect.minY
        
        path.move(to: CGPoint(x: -0.008 * width, y: 0.987 * height))
        path.addCurve(to: CGPoint(x: 0.137 * width, y: height), controlPoint1: CGPoint(x: 0.039 * width, y: 0.99 * height), controlPoint2: CGPoint(x: 0.087 * width, y: height))
        path.addCurve(to: CGPoint(x: 0.991 * width, y: 0.153 * height), controlPoint1: CGPoint(x: 0.609 * width, y: height), controlPoint2: CGPoint(x: 0.991 * width, y: 0.620 * height))
        path.addCurve(to: CGPoint(x: 0.977 * width, y: rect.minY), controlPoint1: CGPoint(x: 0.99 * width, y: 0.10 * height), controlPoint2: CGPoint(x: 0.987 * width, y: 0.049 * height))
        path.addLine(to: CGPoint(x: -0.008 * width, y: rect.minY))
        path.addLine(to: CGPoint(x: -0.008 * width, y: 0.99 * height))
        
        path.close()
        path.usesEvenOddFillRule = true
        fillColor2.setFill()
        path.fill()
    }

}
