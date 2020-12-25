//
//  BottomLeftView.swift
//  Expense Tracker
//
//  Created by isEmpty on 24.12.2020.
//

import UIKit

@IBDesignable
final class BottomLeftView: UIView {

    override func draw(_ rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        //// Color Declarations
        let fillColor = UIColor(red: 0.537, green: 0.294, blue: 0.827, alpha: 1.000)
        context.saveGState()
        context.setAlpha(0.2)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        let width = rect.maxX - rect.minX
        let height = rect.maxY - rect.minY

        let path = UIBezierPath()
        path.move(to: CGPoint(x: width * 0.6, y: height))
        path.addCurve(to: CGPoint(x: width * 0.986, y: height * 0.564), controlPoint1: CGPoint(x: width * 0.82, y: height * 0.895), controlPoint2: CGPoint(x: width * 0.986, y: height * 0.738))
        path.addCurve(to: CGPoint(x: height * -0.02, y: width * 0.004), controlPoint1: CGPoint(x: width * 0.98, y: height * 0.25), controlPoint2: CGPoint(x: width * 0.532, y: width * 0.004))
        path.addLine(to: CGPoint(x: -0.02 * width, y: height))
        path.close()
        path.usesEvenOddFillRule = true
        fillColor.setFill()
        path.fill()

        context.endTransparencyLayer()
        context.restoreGState()
    }
}
