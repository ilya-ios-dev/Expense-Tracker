//
//  PasscodeSuccessfullyView.swift
//  Expense Tracker
//
//  Created by isEmpty on 24.12.2020.
//

import UIKit
@IBDesignable
final class PasscodeSuccessfullyView: UIView {
    override func draw(_ rect: CGRect) {
        PasscodeSuccessfullyDrawing.drawPasscodeSuccesfullDrawing(frame: rect, resizing: .aspectFit)
    }
}


public class PasscodeSuccessfullyDrawing : NSObject {
    
    //// Drawing Methods
    
    @objc dynamic public class func drawPasscodeSuccesfullDrawing(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 361, height: 296), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 361, height: 296), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 361, y: resizedFrame.height / 296)
        
        
        //// Color Declarations
        let fillColor = #colorLiteral(red: 0.4831935167, green: 0.2116402686, blue: 0.8548830152, alpha: 1)
        let fillColor3 = #colorLiteral(red: 0.522, green: 0.584, blue: 0.675, alpha: 1.000)
        let fillColor4 = fillColor.darker(by: 15)!
        let fillColor5 = fillColor.lighter(by: 15)!
        let fillColor6 = #colorLiteral(red: 1.000, green: 1.000, blue: 0.996, alpha: 1.000)
        let fillColor7 = #colorLiteral(red: 0.231, green: 0.388, blue: 0.592, alpha: 1.000)
        let fillColor8 = #colorLiteral(red: 0.831, green: 0.918, blue: 0.949, alpha: 1.000)
        let fillColor9 = #colorLiteral(red: 0.333, green: 0.537, blue: 0.733, alpha: 1.000)
        let fillColor10 = #colorLiteral(red: 0.231, green: 0.388, blue: 0.592, alpha: 0.528)
        let fillColor11 = fillColor.withAlphaComponent(0.3)
        let fillColor12 = #colorLiteral(red: 0.149, green: 0.216, blue: 0.392, alpha: 1.000)
        let fillColor13 = #colorLiteral(red: 0.976, green: 0.827, blue: 0.392, alpha: 1.000)
        let fillColor14 = #colorLiteral(red: 0.863, green: 0.612, blue: 0.184, alpha: 1.000)
        let fillColor15 = #colorLiteral(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let fillColor16 = #colorLiteral(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.083)
        let fillColor17 = #colorLiteral(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.150)
        let fillColor18 = #colorLiteral(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.100)
        
        //// passcode-success
        //// mini-box-colored
        //// Fill-140 Drawing
        context.saveGState()
        context.translateBy(x: 330, y: 71)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill140Path = UIBezierPath()
        fill140Path.move(to: CGPoint(x: 0, y: -19))
        fill140Path.addLine(to: CGPoint(x: 11, y: 0))
        fill140Path.addLine(to: CGPoint(x: 0, y: 19))
        fill140Path.addLine(to: CGPoint(x: -11, y: 0))
        fill140Path.close()
        fillColor3.setFill()
        fill140Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-141 Drawing
        let fill141Path = UIBezierPath()
        fill141Path.move(to: CGPoint(x: 349, y: 56.33))
        fill141Path.addLine(to: CGPoint(x: 330, y: 67))
        fill141Path.addLine(to: CGPoint(x: 330, y: 45.67))
        fill141Path.addLine(to: CGPoint(x: 349, y: 35))
        fill141Path.addLine(to: CGPoint(x: 349, y: 56.33))
        fill141Path.close()
        fill141Path.usesEvenOddFillRule = true
        fillColor4.setFill()
        fill141Path.fill()
        
        
        //// Fill-142 Drawing
        context.saveGState()
        context.translateBy(x: 330, y: 35)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill142Path = UIBezierPath()
        fill142Path.move(to: CGPoint(x: 0, y: -19))
        fill142Path.addLine(to: CGPoint(x: 11, y: 0))
        fill142Path.addLine(to: CGPoint(x: 0, y: 19))
        fill142Path.addLine(to: CGPoint(x: -11, y: 0))
        fill142Path.close()
        fillColor.setFill()
        fill142Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-143 Drawing
        let fill143Path = UIBezierPath()
        fill143Path.move(to: CGPoint(x: 330, y: 67))
        fill143Path.addLine(to: CGPoint(x: 311, y: 56.33))
        fill143Path.addLine(to: CGPoint(x: 311, y: 35))
        fill143Path.addLine(to: CGPoint(x: 330, y: 45.67))
        fill143Path.addLine(to: CGPoint(x: 330, y: 67))
        fill143Path.close()
        fill143Path.usesEvenOddFillRule = true
        fillColor5.setFill()
        fill143Path.fill()
        
        
        //// Fill-144 Drawing
        let fill144Path = UIBezierPath()
        fill144Path.move(to: CGPoint(x: 323, y: 55))
        fill144Path.addLine(to: CGPoint(x: 318, y: 52))
        fill144Path.addLine(to: CGPoint(x: 318, y: 46))
        fill144Path.addLine(to: CGPoint(x: 323, y: 49))
        fill144Path.addLine(to: CGPoint(x: 323, y: 55))
        fill144Path.close()
        fill144Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill144Path.fill()
        
        
        
        
        //// mini-box
        //// Fill- Drawing
        context.saveGState()
        context.translateBy(x: 22, y: 272)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fillPath = UIBezierPath()
        fillPath.move(to: CGPoint(x: 0, y: -19))
        fillPath.addLine(to: CGPoint(x: 11, y: 0))
        fillPath.addLine(to: CGPoint(x: 0, y: 19))
        fillPath.addLine(to: CGPoint(x: -11, y: 0))
        fillPath.close()
        fillColor3.setFill()
        fillPath.fill()
        
        context.restoreGState()
        
        
        //// Fill- 2 Drawing
        let fill2Path = UIBezierPath()
        fill2Path.move(to: CGPoint(x: 41, y: 257.33))
        fill2Path.addLine(to: CGPoint(x: 22, y: 268))
        fill2Path.addLine(to: CGPoint(x: 22, y: 246.67))
        fill2Path.addLine(to: CGPoint(x: 41, y: 236))
        fill2Path.addLine(to: CGPoint(x: 41, y: 257.33))
        fill2Path.close()
        fill2Path.usesEvenOddFillRule = true
        fillColor7.setFill()
        fill2Path.fill()
        
        
        //// Fill- 3 Drawing
        context.saveGState()
        context.translateBy(x: 22, y: 236)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill3Path = UIBezierPath()
        fill3Path.move(to: CGPoint(x: 0, y: -19))
        fill3Path.addLine(to: CGPoint(x: 11, y: 0))
        fill3Path.addLine(to: CGPoint(x: 0, y: 19))
        fill3Path.addLine(to: CGPoint(x: -11, y: 0))
        fill3Path.close()
        fillColor8.setFill()
        fill3Path.fill()
        
        context.restoreGState()
        
        
        //// Fill- 4 Drawing
        let fill4Path = UIBezierPath()
        fill4Path.move(to: CGPoint(x: 22, y: 268))
        fill4Path.addLine(to: CGPoint(x: 3, y: 257.33))
        fill4Path.addLine(to: CGPoint(x: 3, y: 236))
        fill4Path.addLine(to: CGPoint(x: 22, y: 246.67))
        fill4Path.addLine(to: CGPoint(x: 22, y: 268))
        fill4Path.close()
        fill4Path.usesEvenOddFillRule = true
        fillColor9.setFill()
        fill4Path.fill()
        
        
        //// Fill- 5 Drawing
        let fill5Path = UIBezierPath()
        fill5Path.move(to: CGPoint(x: 15, y: 256))
        fill5Path.addLine(to: CGPoint(x: 10, y: 253))
        fill5Path.addLine(to: CGPoint(x: 10, y: 247))
        fill5Path.addLine(to: CGPoint(x: 15, y: 250))
        fill5Path.addLine(to: CGPoint(x: 15, y: 256))
        fill5Path.close()
        fill5Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill5Path.fill()
        
        
        
        
        //// Path-3 Drawing
        let path3Path = UIBezierPath()
        path3Path.move(to: CGPoint(x: 239, y: 1))
        path3Path.addCurve(to: CGPoint(x: 113.5, y: 47), controlPoint1: CGPoint(x: 195.91, y: -6.42), controlPoint2: CGPoint(x: 141.24, y: 33.52))
        path3Path.addCurve(to: CGPoint(x: 21, y: 61.5), controlPoint1: CGPoint(x: 81.46, y: 62.57), controlPoint2: CGPoint(x: 35.74, y: 42.75))
        path3Path.addCurve(to: CGPoint(x: 76, y: 269.5), controlPoint1: CGPoint(x: -6.5, y: 96.49), controlPoint2: CGPoint(x: 33.95, y: 237.86))
        path3Path.addCurve(to: CGPoint(x: 195.82, y: 231), controlPoint1: CGPoint(x: 116.5, y: 299.97), controlPoint2: CGPoint(x: 143.63, y: 241))
        path3Path.addCurve(to: CGPoint(x: 323.17, y: 200), controlPoint1: CGPoint(x: 248, y: 221), controlPoint2: CGPoint(x: 295.11, y: 216.65))
        path3Path.addCurve(to: CGPoint(x: 329, y: 101), controlPoint1: CGPoint(x: 387.2, y: 162), controlPoint2: CGPoint(x: 356.45, y: 107.86))
        path3Path.addCurve(to: CGPoint(x: 239, y: 1), controlPoint1: CGPoint(x: 301.55, y: 94.14), controlPoint2: CGPoint(x: 331.86, y: 17))
        path3Path.close()
        path3Path.usesEvenOddFillRule = true
        fillColor11.setFill()
        path3Path.fill()
        
        
        //// iphone
        //// Fill-6 Drawing
        
        
        //// Fill-7 Drawing
        let fill7Path = UIBezierPath()
        fill7Path.move(to: CGPoint(x: 104.28, y: 233.26))
        fill7Path.addLine(to: CGPoint(x: 4.71, y: 175.66))
        fill7Path.addCurve(to: CGPoint(x: 0.02, y: 168.57), controlPoint1: CGPoint(x: 1.44, y: 173.77), controlPoint2: CGPoint(x: -0.09, y: 171.22))
        fill7Path.addLine(to: CGPoint(x: 0, y: 168.57))
        fill7Path.addLine(to: CGPoint(x: 0.04, y: 154.14))
        fill7Path.addLine(to: CGPoint(x: 5.58, y: 160.62))
        fill7Path.addCurve(to: CGPoint(x: 6.69, y: 159.92), controlPoint1: CGPoint(x: 5.94, y: 160.39), controlPoint2: CGPoint(x: 6.3, y: 160.15))
        fill7Path.addLine(to: CGPoint(x: 210.38, y: 42.83))
        fill7Path.addCurve(to: CGPoint(x: 237.68, y: 41.74), controlPoint1: CGPoint(x: 218.46, y: 38.18), controlPoint2: CGPoint(x: 230.69, y: 37.7))
        fill7Path.addLine(to: CGPoint(x: 335.85, y: 98.53))
        fill7Path.addCurve(to: CGPoint(x: 342, y: 91.76), controlPoint1: CGPoint(x: 337.83, y: 96.35), controlPoint2: CGPoint(x: 342, y: 91.76))
        fill7Path.addLine(to: CGPoint(x: 341.95, y: 105.88))
        fill7Path.addLine(to: CGPoint(x: 341.95, y: 105.88))
        fill7Path.addCurve(to: CGPoint(x: 335.26, y: 115.08), controlPoint1: CGPoint(x: 342.1, y: 109.06), controlPoint2: CGPoint(x: 339.83, y: 112.45))
        fill7Path.addLine(to: CGPoint(x: 131.58, y: 232.17))
        fill7Path.addCurve(to: CGPoint(x: 104.28, y: 233.26), controlPoint1: CGPoint(x: 123.49, y: 236.81), controlPoint2: CGPoint(x: 111.27, y: 237.3))
        fill7Path.close()
        fill7Path.usesEvenOddFillRule = true
        fillColor9.setFill()
        fill7Path.fill()
        
        
        //// Fill-8 Drawing
        let fill8Path = UIBezierPath()
        fill8Path.move(to: CGPoint(x: 50.46, y: 196.68))
        fill8Path.addLine(to: CGPoint(x: 56.54, y: 199.84))
        fill8Path.addCurve(to: CGPoint(x: 58, y: 198.84), controlPoint1: CGPoint(x: 57.35, y: 200.26), controlPoint2: CGPoint(x: 58, y: 199.82))
        fill8Path.addCurve(to: CGPoint(x: 56.54, y: 196.33), controlPoint1: CGPoint(x: 58, y: 197.87), controlPoint2: CGPoint(x: 57.35, y: 196.75))
        fill8Path.addLine(to: CGPoint(x: 50.46, y: 193.16))
        fill8Path.addCurve(to: CGPoint(x: 49, y: 194.15), controlPoint1: CGPoint(x: 49.66, y: 192.74), controlPoint2: CGPoint(x: 49, y: 193.18))
        fill8Path.addCurve(to: CGPoint(x: 50.46, y: 196.68), controlPoint1: CGPoint(x: 49, y: 195.13), controlPoint2: CGPoint(x: 49.66, y: 196.25))
        fill8Path.close()
        fill8Path.usesEvenOddFillRule = true
        fillColor12.setFill()
        fill8Path.fill()
        
        
        //// Fill-9 Drawing
        let fill9Path = UIBezierPath()
        fill9Path.move(to: CGPoint(x: 211.03, y: 42.83))
        fill9Path.addCurve(to: CGPoint(x: 238.2, y: 41.74), controlPoint1: CGPoint(x: 219.08, y: 38.18), controlPoint2: CGPoint(x: 231.24, y: 37.7))
        fill9Path.addLine(to: CGPoint(x: 335.88, y: 98.53))
        fill9Path.addCurve(to: CGPoint(x: 342, y: 91.77), controlPoint1: CGPoint(x: 337.85, y: 96.36), controlPoint2: CGPoint(x: 342, y: 91.77))
        fill9Path.addLine(to: CGPoint(x: 341.95, y: 105.89))
        fill9Path.addLine(to: CGPoint(x: 341.95, y: 105.89))
        fill9Path.addCurve(to: CGPoint(x: 335.3, y: 115.08), controlPoint1: CGPoint(x: 342.1, y: 109.07), controlPoint2: CGPoint(x: 339.84, y: 112.46))
        fill9Path.addLine(to: CGPoint(x: 132.63, y: 232.18))
        fill9Path.addCurve(to: CGPoint(x: 118, y: 236), controlPoint1: CGPoint(x: 128.43, y: 234.61), controlPoint2: CGPoint(x: 123.11, y: 235.89))
        fill9Path.addLine(to: CGPoint(x: 118.19, y: 96.48))
        fill9Path.addLine(to: CGPoint(x: 211.03, y: 42.83))
        fill9Path.close()
        fill9Path.usesEvenOddFillRule = true
        fillColor7.setFill()
        fill9Path.fill()
        
        
        //// Fill-10 Drawing
        let fill10Path = UIBezierPath()
        fill10Path.move(to: CGPoint(x: 337.29, y: 84.34))
        fill10Path.addLine(to: CGPoint(x: 237.71, y: 26.74))
        fill10Path.addCurve(to: CGPoint(x: 210.4, y: 27.83), controlPoint1: CGPoint(x: 230.71, y: 22.7), controlPoint2: CGPoint(x: 218.49, y: 23.18))
        fill10Path.addLine(to: CGPoint(x: 6.7, y: 144.92))
        fill10Path.addCurve(to: CGPoint(x: 4.71, y: 160.67), controlPoint1: CGPoint(x: -1.39, y: 149.57), controlPoint2: CGPoint(x: -2.28, y: 156.62))
        fill10Path.addLine(to: CGPoint(x: 104.29, y: 218.26))
        fill10Path.addCurve(to: CGPoint(x: 131.6, y: 217.17), controlPoint1: CGPoint(x: 111.29, y: 222.3), controlPoint2: CGPoint(x: 123.51, y: 221.82))
        fill10Path.addLine(to: CGPoint(x: 335.3, y: 100.08))
        fill10Path.addCurve(to: CGPoint(x: 337.29, y: 84.34), controlPoint1: CGPoint(x: 343.39, y: 95.43), controlPoint2: CGPoint(x: 344.28, y: 88.38))
        fill10Path.close()
        fill10Path.usesEvenOddFillRule = true
        fillColor8.setFill()
        fill10Path.fill()
        
        
        //// Fill-11 Drawing
        let fill11Path = UIBezierPath()
        fill11Path.move(to: CGPoint(x: 104.29, y: 219.27))
        fill11Path.addLine(to: CGPoint(x: 4.7, y: 161.8))
        fill11Path.addCurve(to: CGPoint(x: 0.09, y: 153.9), controlPoint1: CGPoint(x: 1.09, y: 159.72), controlPoint2: CGPoint(x: -0.4, y: 156.84))
        fill11Path.addCurve(to: CGPoint(x: 4.77, y: 160.26), controlPoint1: CGPoint(x: 0.27, y: 156.29), controlPoint2: CGPoint(x: 1.8, y: 158.55))
        fill11Path.addLine(to: CGPoint(x: 104.36, y: 217.73))
        fill11Path.addCurve(to: CGPoint(x: 131.67, y: 216.64), controlPoint1: CGPoint(x: 111.35, y: 221.77), controlPoint2: CGPoint(x: 123.58, y: 221.28))
        fill11Path.addLine(to: CGPoint(x: 335.39, y: 99.81))
        fill11Path.addCurve(to: CGPoint(x: 341.98, y: 92), controlPoint1: CGPoint(x: 339.31, y: 97.57), controlPoint2: CGPoint(x: 341.52, y: 94.76))
        fill11Path.addCurve(to: CGPoint(x: 335.32, y: 101.35), controlPoint1: CGPoint(x: 342.22, y: 95.23), controlPoint2: CGPoint(x: 339.97, y: 98.68))
        fill11Path.addLine(to: CGPoint(x: 131.59, y: 218.18))
        fill11Path.addCurve(to: CGPoint(x: 104.29, y: 219.27), controlPoint1: CGPoint(x: 123.5, y: 222.81), controlPoint2: CGPoint(x: 111.28, y: 223.3))
        fill11Path.close()
        fill11Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill11Path.fill()
        
        
        //// Fill-12 Drawing
        let fill12Path = UIBezierPath()
        fill12Path.move(to: CGPoint(x: 330.5, y: 85.96))
        fill12Path.addLine(to: CGPoint(x: 234.9, y: 31.02))
        fill12Path.addCurve(to: CGPoint(x: 214.62, y: 31.83), controlPoint1: CGPoint(x: 229.7, y: 28.04), controlPoint2: CGPoint(x: 220.62, y: 28.4))
        fill12Path.addLine(to: CGPoint(x: 13.97, y: 146.42))
        fill12Path.addCurve(to: CGPoint(x: 12.5, y: 158.04), controlPoint1: CGPoint(x: 7.97, y: 149.85), controlPoint2: CGPoint(x: 7.31, y: 155.05))
        fill12Path.addLine(to: CGPoint(x: 108.1, y: 212.98))
        fill12Path.addCurve(to: CGPoint(x: 128.38, y: 212.17), controlPoint1: CGPoint(x: 113.3, y: 215.96), controlPoint2: CGPoint(x: 122.38, y: 215.6))
        fill12Path.addLine(to: CGPoint(x: 329.03, y: 97.58))
        fill12Path.addCurve(to: CGPoint(x: 330.5, y: 85.96), controlPoint1: CGPoint(x: 335.03, y: 94.15), controlPoint2: CGPoint(x: 335.69, y: 88.95))
        fill12Path.close()
        fill12Path.usesEvenOddFillRule = true
        fillColor12.setFill()
        fill12Path.fill()
        
        
        //// Fill-13 Drawing
        let fill13Path = UIBezierPath()
        fill13Path.move(to: CGPoint(x: 130.68, y: 186))
        fill13Path.addLine(to: CGPoint(x: 63, y: 147.46))
        fill13Path.addLine(to: CGPoint(x: 67.32, y: 145))
        fill13Path.addLine(to: CGPoint(x: 135, y: 183.54))
        fill13Path.addLine(to: CGPoint(x: 130.68, y: 186))
        fill13Path.close()
        fill13Path.usesEvenOddFillRule = true
        fillColor8.setFill()
        fill13Path.fill()
        
        
        //// Fill-14 Drawing
        let fill14Path = UIBezierPath()
        fill14Path.move(to: CGPoint(x: 84.75, y: 174))
        fill14Path.addLine(to: CGPoint(x: 51, y: 154.46))
        fill14Path.addLine(to: CGPoint(x: 55.25, y: 152))
        fill14Path.addLine(to: CGPoint(x: 89, y: 171.54))
        fill14Path.addLine(to: CGPoint(x: 84.75, y: 174))
        fill14Path.close()
        fill14Path.usesEvenOddFillRule = true
        fillColor8.setFill()
        fill14Path.fill()
        
        
        //// Fill-15 Drawing
        let fill15Path = UIBezierPath()
        fill15Path.move(to: CGPoint(x: 101.8, y: 183))
        fill15Path.addLine(to: CGPoint(x: 91, y: 176.52))
        fill15Path.addLine(to: CGPoint(x: 95.2, y: 174))
        fill15Path.addLine(to: CGPoint(x: 106, y: 180.48))
        fill15Path.addLine(to: CGPoint(x: 101.8, y: 183))
        fill15Path.close()
        fill15Path.usesEvenOddFillRule = true
        fillColor.setFill()
        fill15Path.fill()
        
        
        //// Fill-16 Drawing
        let fill16Path = UIBezierPath()
        fill16Path.move(to: CGPoint(x: 116.8, y: 193))
        fill16Path.addLine(to: CGPoint(x: 106, y: 186.52))
        fill16Path.addLine(to: CGPoint(x: 110.2, y: 184))
        fill16Path.addLine(to: CGPoint(x: 121, y: 190.48))
        fill16Path.addLine(to: CGPoint(x: 116.8, y: 193))
        fill16Path.close()
        fill16Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill16Path.fill()
        
        
        //// Fill-17 Drawing
        let fill17Path = UIBezierPath()
        fill17Path.move(to: CGPoint(x: 84.7, y: 166))
        fill17Path.addLine(to: CGPoint(x: 57, y: 149.55))
        fill17Path.addLine(to: CGPoint(x: 61.3, y: 147))
        fill17Path.addLine(to: CGPoint(x: 89, y: 163.44))
        fill17Path.addLine(to: CGPoint(x: 84.7, y: 166))
        fill17Path.close()
        fill17Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill17Path.fill()
        
        
        //// Fill-18 Drawing
        let fill18Path = UIBezierPath()
        fill18Path.move(to: CGPoint(x: 118.7, y: 186))
        fill18Path.addLine(to: CGPoint(x: 91, y: 169.55))
        fill18Path.addLine(to: CGPoint(x: 95.3, y: 167))
        fill18Path.addLine(to: CGPoint(x: 123, y: 183.44))
        fill18Path.addLine(to: CGPoint(x: 118.7, y: 186))
        fill18Path.close()
        fill18Path.usesEvenOddFillRule = true
        fillColor8.setFill()
        fill18Path.fill()
        
        
        //// Fill-19 Drawing
        let fill19Path = UIBezierPath(ovalIn: CGRect(x: 92, y: 149, width: 7, height: 3))
        fillColor.setFill()
        fill19Path.fill()
        
        
        //// Fill-20 Drawing
        let fill20Path = UIBezierPath(ovalIn: CGRect(x: 99, y: 152, width: 7, height: 3))
        fillColor6.setFill()
        fill20Path.fill()
        
        
        //// Fill-21 Drawing
        let fill21Path = UIBezierPath(ovalIn: CGRect(x: 108, y: 157, width: 7, height: 3))
        fillColor8.setFill()
        fill21Path.fill()
        
        
        //// Fill-22 Drawing
        let fill22Path = UIBezierPath(ovalIn: CGRect(x: 114, y: 163, width: 7, height: 3))
        fillColor.setFill()
        fill22Path.fill()
        
        
        //// Fill-23 Drawing
        let fill23Path = UIBezierPath(ovalIn: CGRect(x: 121, y: 166, width: 7, height: 3))
        fillColor6.setFill()
        fill23Path.fill()
        
        
        //// Fill-24 Drawing
        let fill24Path = UIBezierPath()
        fill24Path.move(to: CGPoint(x: 279.8, y: 87))
        fill24Path.addLine(to: CGPoint(x: 269, y: 80.52))
        fill24Path.addLine(to: CGPoint(x: 273.2, y: 78))
        fill24Path.addLine(to: CGPoint(x: 284, y: 84.48))
        fill24Path.addLine(to: CGPoint(x: 279.8, y: 87))
        fill24Path.close()
        fill24Path.usesEvenOddFillRule = true
        fillColor.setFill()
        fill24Path.fill()
        
        
        //// Fill-25 Drawing
        let fill25Path = UIBezierPath()
        fill25Path.move(to: CGPoint(x: 294.8, y: 96))
        fill25Path.addLine(to: CGPoint(x: 284, y: 89.52))
        fill25Path.addLine(to: CGPoint(x: 288.2, y: 87))
        fill25Path.addLine(to: CGPoint(x: 299, y: 93.48))
        fill25Path.addLine(to: CGPoint(x: 294.8, y: 96))
        fill25Path.close()
        fill25Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill25Path.fill()
        
        
        //// Fill-26 Drawing
        let fill26Path = UIBezierPath()
        fill26Path.move(to: CGPoint(x: 227.8, y: 58))
        fill26Path.addLine(to: CGPoint(x: 217, y: 51.52))
        fill26Path.addLine(to: CGPoint(x: 221.2, y: 49))
        fill26Path.addLine(to: CGPoint(x: 232, y: 55.48))
        fill26Path.addLine(to: CGPoint(x: 227.8, y: 58))
        fill26Path.close()
        fill26Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill26Path.fill()
        
        
        //// Fill-27 Drawing
        let fill27Path = UIBezierPath()
        fill27Path.move(to: CGPoint(x: 276.42, y: 94))
        fill27Path.addLine(to: CGPoint(x: 260, y: 84.62))
        fill27Path.addLine(to: CGPoint(x: 264.58, y: 82))
        fill27Path.addLine(to: CGPoint(x: 281, y: 91.38))
        fill27Path.addLine(to: CGPoint(x: 276.42, y: 94))
        fill27Path.close()
        fill27Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill27Path.fill()
        
        
        //// Fill-28 Drawing
        let fill28Path = UIBezierPath()
        fill28Path.move(to: CGPoint(x: 287.33, y: 101))
        fill28Path.addLine(to: CGPoint(x: 280, y: 96.72))
        fill28Path.addLine(to: CGPoint(x: 284.67, y: 94))
        fill28Path.addLine(to: CGPoint(x: 292, y: 98.28))
        fill28Path.addLine(to: CGPoint(x: 287.33, y: 101))
        fill28Path.close()
        fill28Path.usesEvenOddFillRule = true
        fillColor8.setFill()
        fill28Path.fill()
        
        
        
        
        //// box3
        //// Fill-152 Drawing
        context.saveGState()
        context.translateBy(x: 306.5, y: 235)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill152Path = UIBezierPath()
        fill152Path.move(to: CGPoint(x: 0, y: -19.5))
        fill152Path.addLine(to: CGPoint(x: 11, y: 0))
        fill152Path.addLine(to: CGPoint(x: 0, y: 19.5))
        fill152Path.addLine(to: CGPoint(x: -11, y: 0))
        fill152Path.close()
        fillColor3.setFill()
        fill152Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-153 Drawing
        let fill153Path = UIBezierPath()
        fill153Path.move(to: CGPoint(x: 306, y: 236))
        fill153Path.addLine(to: CGPoint(x: 306, y: 199.07))
        fill153Path.addLine(to: CGPoint(x: 284, y: 186))
        fill153Path.addLine(to: CGPoint(x: 284, y: 222.93))
        fill153Path.addLine(to: CGPoint(x: 306, y: 236))
        fill153Path.close()
        fill153Path.usesEvenOddFillRule = true
        fillColor13.setFill()
        fill153Path.fill()
        
        
        //// Fill-154 Drawing
        let fill154Path = UIBezierPath()
        fill154Path.move(to: CGPoint(x: 306, y: 199.07))
        fill154Path.addLine(to: CGPoint(x: 328, y: 186))
        fill154Path.addLine(to: CGPoint(x: 328, y: 222.93))
        fill154Path.addLine(to: CGPoint(x: 306, y: 236))
        fill154Path.addLine(to: CGPoint(x: 306, y: 199.07))
        fill154Path.close()
        fill154Path.usesEvenOddFillRule = true
        fillColor14.setFill()
        fill154Path.fill()
        
        
        //// Fill-155 Drawing
        context.saveGState()
        context.translateBy(x: 306, y: 186)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill155Path = UIBezierPath()
        fill155Path.move(to: CGPoint(x: 0, y: -22))
        fill155Path.addLine(to: CGPoint(x: 13, y: 0))
        fill155Path.addLine(to: CGPoint(x: 0, y: 22))
        fill155Path.addLine(to: CGPoint(x: -13, y: 0))
        fill155Path.close()
        fillColor13.setFill()
        fill155Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-156 Drawing
        let fill156Path = UIBezierPath()
        fill156Path.move(to: CGPoint(x: 328, y: 188))
        fill156Path.addLine(to: CGPoint(x: 328, y: 189.19))
        fill156Path.addLine(to: CGPoint(x: 306, y: 202))
        fill156Path.addLine(to: CGPoint(x: 284, y: 189.19))
        fill156Path.addLine(to: CGPoint(x: 284, y: 188))
        fill156Path.addLine(to: CGPoint(x: 306, y: 200.81))
        fill156Path.addLine(to: CGPoint(x: 328, y: 188))
        fill156Path.close()
        fill156Path.usesEvenOddFillRule = true
        fillColor15.setFill()
        fill156Path.fill()
        
        
        
        
        //// box2
        //// Fill-150 Drawing
        context.saveGState()
        context.translateBy(x: 271.5, y: 255)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill150Path = UIBezierPath()
        fill150Path.move(to: CGPoint(x: 0, y: -19.5))
        fill150Path.addLine(to: CGPoint(x: 11, y: 0))
        fill150Path.addLine(to: CGPoint(x: 0, y: 19.5))
        fill150Path.addLine(to: CGPoint(x: -11, y: 0))
        fill150Path.close()
        fillColor3.setFill()
        fill150Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-157 Drawing
        let fill157Path = UIBezierPath()
        fill157Path.move(to: CGPoint(x: 270, y: 257))
        fill157Path.addLine(to: CGPoint(x: 270, y: 204.94))
        fill157Path.addLine(to: CGPoint(x: 248, y: 192))
        fill157Path.addLine(to: CGPoint(x: 248, y: 244.06))
        fill157Path.addLine(to: CGPoint(x: 270, y: 257))
        fill157Path.close()
        fill157Path.usesEvenOddFillRule = true
        fillColor.setFill()
        fill157Path.fill()
        
        
        //// Fill- 29 Drawing
        let fill29Path = UIBezierPath()
        fill29Path.move(to: CGPoint(x: 270, y: 257))
        fill29Path.addLine(to: CGPoint(x: 270, y: 204.94))
        fill29Path.addLine(to: CGPoint(x: 248, y: 192))
        fill29Path.addLine(to: CGPoint(x: 248, y: 244.06))
        fill29Path.addLine(to: CGPoint(x: 270, y: 257))
        fill29Path.close()
        fill29Path.usesEvenOddFillRule = true
        fillColor16.setFill()
        fill29Path.fill()
        
        
        //// Fill-158 Drawing
        let fill158Path = UIBezierPath()
        fill158Path.move(to: CGPoint(x: 270, y: 204.94))
        fill158Path.addLine(to: CGPoint(x: 292, y: 192))
        fill158Path.addLine(to: CGPoint(x: 292, y: 244.06))
        fill158Path.addLine(to: CGPoint(x: 270, y: 257))
        fill158Path.addLine(to: CGPoint(x: 270, y: 204.94))
        fill158Path.close()
        fill158Path.usesEvenOddFillRule = true
        fillColor.setFill()
        fill158Path.fill()
        
        
        //// Fill- 30 Drawing
        let fill30Path = UIBezierPath()
        fill30Path.move(to: CGPoint(x: 270, y: 204.94))
        fill30Path.addLine(to: CGPoint(x: 292, y: 192))
        fill30Path.addLine(to: CGPoint(x: 292, y: 244.06))
        fill30Path.addLine(to: CGPoint(x: 270, y: 257))
        fill30Path.addLine(to: CGPoint(x: 270, y: 204.94))
        fill30Path.close()
        fill30Path.usesEvenOddFillRule = true
        fillColor17.setFill()
        fill30Path.fill()
        
        
        //// Fill-159 Drawing
        context.saveGState()
        context.translateBy(x: 270, y: 192)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill159Path = UIBezierPath()
        fill159Path.move(to: CGPoint(x: 0, y: -22))
        fill159Path.addLine(to: CGPoint(x: 13, y: 0))
        fill159Path.addLine(to: CGPoint(x: 0, y: 22))
        fill159Path.addLine(to: CGPoint(x: -13, y: 0))
        fill159Path.close()
        fillColor.setFill()
        fill159Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-160 Drawing
        let fill160Path = UIBezierPath()
        fill160Path.move(to: CGPoint(x: 270, y: 208.81))
        fill160Path.addLine(to: CGPoint(x: 292, y: 196))
        fill160Path.addLine(to: CGPoint(x: 292, y: 197.19))
        fill160Path.addLine(to: CGPoint(x: 270, y: 210))
        fill160Path.addLine(to: CGPoint(x: 248, y: 197.19))
        fill160Path.addLine(to: CGPoint(x: 248, y: 196))
        fill160Path.addLine(to: CGPoint(x: 270, y: 208.81))
        fill160Path.close()
        fill160Path.usesEvenOddFillRule = true
        fillColor15.setFill()
        fill160Path.fill()
        
        
        
        
        //// box1
        //// Fill-151 Drawing
        context.saveGState()
        context.translateBy(x: 235.5, y: 276)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill151Path = UIBezierPath()
        fill151Path.move(to: CGPoint(x: 0, y: -19.5))
        fill151Path.addLine(to: CGPoint(x: 11, y: 0))
        fill151Path.addLine(to: CGPoint(x: 0, y: 19.5))
        fill151Path.addLine(to: CGPoint(x: -11, y: 0))
        fill151Path.close()
        fillColor10.setFill()
        fill151Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-161 Drawing
        let fill161Path = UIBezierPath()
        fill161Path.move(to: CGPoint(x: 236, y: 278))
        fill161Path.addLine(to: CGPoint(x: 236, y: 255.04))
        fill161Path.addLine(to: CGPoint(x: 214, y: 242))
        fill161Path.addLine(to: CGPoint(x: 214, y: 264.96))
        fill161Path.addLine(to: CGPoint(x: 236, y: 278))
        fill161Path.close()
        fill161Path.usesEvenOddFillRule = true
        fillColor9.setFill()
        fill161Path.fill()
        
        
        //// Fill-162 Drawing
        let fill162Path = UIBezierPath()
        fill162Path.move(to: CGPoint(x: 236, y: 255.04))
        fill162Path.addLine(to: CGPoint(x: 258, y: 242))
        fill162Path.addLine(to: CGPoint(x: 258, y: 264.96))
        fill162Path.addLine(to: CGPoint(x: 236, y: 278))
        fill162Path.addLine(to: CGPoint(x: 236, y: 255.04))
        fill162Path.close()
        fill162Path.usesEvenOddFillRule = true
        fillColor7.setFill()
        fill162Path.fill()
        
        
        //// Fill-163 Drawing
        context.saveGState()
        context.translateBy(x: 236, y: 242)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let fill163Path = UIBezierPath()
        fill163Path.move(to: CGPoint(x: 0, y: -22))
        fill163Path.addLine(to: CGPoint(x: 13, y: 0))
        fill163Path.addLine(to: CGPoint(x: 0, y: 22))
        fill163Path.addLine(to: CGPoint(x: -13, y: 0))
        fill163Path.close()
        fillColor8.setFill()
        fill163Path.fill()
        
        context.restoreGState()
        
        
        //// Fill-164 Drawing
        let fill164Path = UIBezierPath()
        fill164Path.move(to: CGPoint(x: 258, y: 244))
        fill164Path.addLine(to: CGPoint(x: 258, y: 245.19))
        fill164Path.addLine(to: CGPoint(x: 236, y: 258))
        fill164Path.addLine(to: CGPoint(x: 214, y: 245.19))
        fill164Path.addLine(to: CGPoint(x: 214, y: 244))
        fill164Path.addLine(to: CGPoint(x: 236, y: 256.81))
        fill164Path.addLine(to: CGPoint(x: 258, y: 244))
        fill164Path.close()
        fill164Path.usesEvenOddFillRule = true
        fillColor15.setFill()
        fill164Path.fill()
        
        
        
        
        //// check-mark
        //// Fill-1 Drawing
        context.saveGState()
        context.translateBy(x: 177.95, y: 126.94)
        context.rotate(by: -0.05 * CGFloat.pi/180)
        
        let fill1Path = UIBezierPath(ovalIn: CGRect(x: -42.95, y: -22, width: 85.9, height: 44))
        fillColor18.setFill()
        fill1Path.fill()
        
        context.restoreGState()
        
        
        //// Fill- 31 Drawing
        let fill31Path = UIBezierPath()
        fill31Path.move(to: CGPoint(x: 220.63, y: 105.96))
        fill31Path.addLine(to: CGPoint(x: 218.37, y: 105.96))
        fill31Path.addCurve(to: CGPoint(x: 208.09, y: 97.35), controlPoint1: CGPoint(x: 216.33, y: 102.82), controlPoint2: CGPoint(x: 212.93, y: 99.86))
        fill31Path.addCurve(to: CGPoint(x: 147.54, y: 97.35), controlPoint1: CGPoint(x: 191.37, y: 88.7), controlPoint2: CGPoint(x: 164.26, y: 88.7))
        fill31Path.addCurve(to: CGPoint(x: 137.27, y: 105.96), controlPoint1: CGPoint(x: 142.7, y: 99.86), controlPoint2: CGPoint(x: 139.3, y: 102.82))
        fill31Path.addLine(to: CGPoint(x: 135, y: 105.96))
        fill31Path.addLine(to: CGPoint(x: 135, y: 116.68))
        fill31Path.addCurve(to: CGPoint(x: 147.54, y: 132.4), controlPoint1: CGPoint(x: 134.97, y: 122.37), controlPoint2: CGPoint(x: 139.15, y: 128.06))
        fill31Path.addCurve(to: CGPoint(x: 208.09, y: 132.4), controlPoint1: CGPoint(x: 164.26, y: 141.05), controlPoint2: CGPoint(x: 191.37, y: 141.05))
        fill31Path.addCurve(to: CGPoint(x: 220.63, y: 116.74), controlPoint1: CGPoint(x: 216.45, y: 128.08), controlPoint2: CGPoint(x: 220.63, y: 122.4))
        fill31Path.addLine(to: CGPoint(x: 220.63, y: 105.96))
        fill31Path.close()
        fill31Path.usesEvenOddFillRule = true
        fillColor4.setFill()
        fill31Path.fill()
        
        
        //// Fill- 32 Drawing
        let fill32Path = UIBezierPath(ovalIn: CGRect(x: 135, y: 84.04, width: 85.6, height: 44.1))
        fillColor.setFill()
        fill32Path.fill()
        
        
        //// Fill- 33 Drawing
        let fill33Path = UIBezierPath()
        fill33Path.move(to: CGPoint(x: 147.51, y: 121))
        fill33Path.addCurve(to: CGPoint(x: 135.02, y: 106.11), controlPoint1: CGPoint(x: 139.49, y: 116.87), controlPoint2: CGPoint(x: 135.35, y: 111.52))
        fill33Path.addCurve(to: CGPoint(x: 147.51, y: 122.4), controlPoint1: CGPoint(x: 134.66, y: 111.99), controlPoint2: CGPoint(x: 138.79, y: 117.92))
        fill33Path.addCurve(to: CGPoint(x: 208.12, y: 122.4), controlPoint1: CGPoint(x: 164.25, y: 131.01), controlPoint2: CGPoint(x: 191.38, y: 131.01))
        fill33Path.addCurve(to: CGPoint(x: 220.61, y: 106.11), controlPoint1: CGPoint(x: 216.84, y: 117.92), controlPoint2: CGPoint(x: 220.97, y: 111.99))
        fill33Path.addCurve(to: CGPoint(x: 208.12, y: 121), controlPoint1: CGPoint(x: 220.28, y: 111.52), controlPoint2: CGPoint(x: 216.14, y: 116.87))
        fill33Path.addCurve(to: CGPoint(x: 147.51, y: 121), controlPoint1: CGPoint(x: 191.38, y: 129.61), controlPoint2: CGPoint(x: 164.25, y: 129.61))
        fill33Path.close()
        fill33Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill33Path.fill()
        
        
        //// Fill- 34 Drawing
        let fill34Path = UIBezierPath()
        fill34Path.move(to: CGPoint(x: 156.32, y: 112.34))
        fill34Path.addLine(to: CGPoint(x: 156.36, y: 97.91))
        fill34Path.addCurve(to: CGPoint(x: 160.22, y: 95.92), controlPoint1: CGPoint(x: 156.36, y: 96.81), controlPoint2: CGPoint(x: 158.09, y: 95.92))
        fill34Path.addCurve(to: CGPoint(x: 164.06, y: 97.91), controlPoint1: CGPoint(x: 162.34, y: 95.92), controlPoint2: CGPoint(x: 164.06, y: 96.81))
        fill34Path.addLine(to: CGPoint(x: 164.02, y: 109.88))
        fill34Path.addLine(to: CGPoint(x: 202.75, y: 105.63))
        fill34Path.addCurve(to: CGPoint(x: 207.32, y: 107.16), controlPoint1: CGPoint(x: 204.83, y: 105.4), controlPoint2: CGPoint(x: 206.88, y: 106.09))
        fill34Path.addCurve(to: CGPoint(x: 204.35, y: 109.53), controlPoint1: CGPoint(x: 207.76, y: 108.24), controlPoint2: CGPoint(x: 206.43, y: 109.3))
        fill34Path.addLine(to: CGPoint(x: 160.96, y: 114.29))
        fill34Path.addCurve(to: CGPoint(x: 157.74, y: 113.89), controlPoint1: CGPoint(x: 159.83, y: 114.41), controlPoint2: CGPoint(x: 158.64, y: 114.27))
        fill34Path.addLine(to: CGPoint(x: 157.44, y: 113.75))
        fill34Path.addCurve(to: CGPoint(x: 156.32, y: 112.34), controlPoint1: CGPoint(x: 156.72, y: 113.38), controlPoint2: CGPoint(x: 156.31, y: 112.87))
        fill34Path.close()
        fill34Path.usesEvenOddFillRule = true
        fillColor6.setFill()
        fill34Path.fill()
        
        context.restoreGState()
        
    }
    
    
    
    
    @objc(PasscodeSuccessDrawingResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
