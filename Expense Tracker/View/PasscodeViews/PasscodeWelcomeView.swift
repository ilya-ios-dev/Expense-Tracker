//
//  PasscodePicterView.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

@IBDesignable
final class PasscodeWelcomeView: UIView {
    override func draw(_ rect: CGRect) {
        PasscodeWelcomeDraw.drawCanvas1(frame: rect, resizing: .aspectFit)
    }
}

public class PasscodeWelcomeDraw : NSObject {

    //// Drawing Methods

    @objc dynamic public class func drawCanvas1(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 356, height: 264), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 356, height: 264), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 356, y: resizedFrame.height / 264)

        let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
        let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)

        //// Color Declarations
        let gradientColor =  startColor
        let gradientColor2 = endColor
        let gradientColor3 = startColor.withAlphaComponent(0.11)
        let gradientColor4 = endColor.withAlphaComponent(0.11)
        let gradientColor5 = #colorLiteral(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.000)
        let gradientColor6 = #colorLiteral(red: 0.702, green: 0.702, blue: 0.702, alpha: 0.970)
        let fillColor =      #colorLiteral(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.501)
        let fillColor2 =     #colorLiteral(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let fillColor3 =     #colorLiteral(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let strokeColor =    startColor.withAlphaComponent(0.5)
        let fillColor4 =     #colorLiteral(red: 1.000, green: 0.514, blue: 0.525, alpha: 1.000)
        let fillColor5 =     #colorLiteral(red: 0.169, green: 0.255, blue: 0.365, alpha: 1.000)
        let fillColor6 =     #colorLiteral(red: 1.000, green: 0.675, blue: 0.451, alpha: 1.000)
        let fillColor7 =     #colorLiteral(red: 0.898, green: 0.537, blue: 0.290, alpha: 1.000)
        let fillColor8 =     #colorLiteral(red: 0.294, green: 0.106, blue: 0.075, alpha: 1.000)
        let fillColor9 =     #colorLiteral(red: 0.737, green: 0.259, blue: 0.294, alpha: 1.000)
        let fillColor10 =    #colorLiteral(red: 0.910, green: 0.863, blue: 0.918, alpha: 1.000)

        //// Gradient Declarations
        let linearGradient2 = CGGradient(colorsSpace: nil, colors: [gradientColor.cgColor, gradientColor2.cgColor] as CFArray, locations: [0, 1])!
        let linearGradient1 = CGGradient(colorsSpace: nil, colors: [gradientColor3.cgColor, gradientColor4.cgColor] as CFArray, locations: [0, 1])!
        let linearGradient5 = CGGradient(colorsSpace: nil, colors: [gradientColor5.cgColor, gradientColor6.cgColor] as CFArray, locations: [0.01, 1])!

        //// passcode
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)


        //// Path-2 Drawing
        let path2Path = UIBezierPath()
        path2Path.move(to: CGPoint(x: 33, y: 65.29))
        path2Path.addCurve(to: CGPoint(x: 192.49, y: 6.41), controlPoint1: CGPoint(x: 41.29, y: -13.37), controlPoint2: CGPoint(x: 158.94, y: -3.03))
        path2Path.addCurve(to: CGPoint(x: 315.5, y: 65.29), controlPoint1: CGPoint(x: 226.04, y: 15.85), controlPoint2: CGPoint(x: 257.69, y: 65.29))
        path2Path.addCurve(to: CGPoint(x: 315.5, y: 192.04), controlPoint1: CGPoint(x: 373.31, y: 65.29), controlPoint2: CGPoint(x: 365.56, y: 150.24))
        path2Path.addCurve(to: CGPoint(x: 142.73, y: 264), controlPoint1: CGPoint(x: 265.43, y: 233.85), controlPoint2: CGPoint(x: 227.24, y: 264))
        path2Path.addCurve(to: CGPoint(x: 0, y: 192.04), controlPoint1: CGPoint(x: 58.22, y: 264), controlPoint2: CGPoint(x: 0, y: 240.13))
        path2Path.addCurve(to: CGPoint(x: 33, y: 65.29), controlPoint1: CGPoint(x: 0, y: 143.96), controlPoint2: CGPoint(x: 24.71, y: 143.96))
        path2Path.close()
        path2Path.usesEvenOddFillRule = true
        context.saveGState()
        path2Path.addClip()
        context.drawLinearGradient(linearGradient1,
            start: CGPoint(x: 336.73, y: 59.41),
            end: CGPoint(x: -167.35, y: 286.56),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()


        //// ipad
        //// Path Drawing
        let pathPath = UIBezierPath()
        pathPath.move(to: CGPoint(x: 11.8, y: 164.9))
        pathPath.addLine(to: CGPoint(x: 16.08, y: 167.45))
        pathPath.addLine(to: CGPoint(x: 198.72, y: 62.83))
        pathPath.addLine(to: CGPoint(x: 337.39, y: 146.16))
        pathPath.addLine(to: CGPoint(x: 343.72, y: 144.27))
        pathPath.addLine(to: CGPoint(x: 343.72, y: 151.76))
        pathPath.addCurve(to: CGPoint(x: 341.72, y: 155.66), controlPoint1: CGPoint(x: 343.89, y: 153.34), controlPoint2: CGPoint(x: 343.1, y: 154.87))
        pathPath.addLine(to: CGPoint(x: 166.84, y: 256.07))
        pathPath.addCurve(to: CGPoint(x: 150.55, y: 256.14), controlPoint1: CGPoint(x: 161.8, y: 258.96), controlPoint2: CGPoint(x: 155.61, y: 258.99))
        pathPath.addLine(to: CGPoint(x: 15.41, y: 180.14))
        pathPath.addCurve(to: CGPoint(x: 11.91, y: 172.68), controlPoint1: CGPoint(x: 12.76, y: 178.66), controlPoint2: CGPoint(x: 11.35, y: 175.66))
        pathPath.addLine(to: CGPoint(x: 11.8, y: 164.9))
        pathPath.close()
        context.saveGState()
        pathPath.addClip()
        context.drawLinearGradient(linearGradient2,
            start: CGPoint(x: 316.1, y: 75.05),
            end: CGPoint(x: -84.8, y: 326.56),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()


        //// Path 3 Drawing
        context.saveGState()
        context.setAlpha(0.39)

        let path3Path = UIBezierPath()
        path3Path.move(to: CGPoint(x: 11.8, y: 164.9))
        path3Path.addLine(to: CGPoint(x: 16.08, y: 167.45))
        path3Path.addLine(to: CGPoint(x: 198.72, y: 62.83))
        path3Path.addLine(to: CGPoint(x: 337.39, y: 146.16))
        path3Path.addLine(to: CGPoint(x: 343.72, y: 144.27))
        path3Path.addLine(to: CGPoint(x: 343.72, y: 151.76))
        path3Path.addCurve(to: CGPoint(x: 341.72, y: 155.66), controlPoint1: CGPoint(x: 343.89, y: 153.34), controlPoint2: CGPoint(x: 343.1, y: 154.87))
        path3Path.addLine(to: CGPoint(x: 166.84, y: 256.07))
        path3Path.addCurve(to: CGPoint(x: 150.55, y: 256.14), controlPoint1: CGPoint(x: 161.8, y: 258.96), controlPoint2: CGPoint(x: 155.61, y: 258.99))
        path3Path.addLine(to: CGPoint(x: 15.41, y: 180.14))
        path3Path.addCurve(to: CGPoint(x: 11.91, y: 172.68), controlPoint1: CGPoint(x: 12.76, y: 178.66), controlPoint2: CGPoint(x: 11.35, y: 175.66))
        path3Path.addLine(to: CGPoint(x: 11.8, y: 164.9))
        path3Path.close()
        fillColor.setFill()
        path3Path.fill()

        context.restoreGState()


        //// Path 4 Drawing
        let path4Path = UIBezierPath()
        path4Path.move(to: CGPoint(x: 341.73, y: 146.41))
        path4Path.addLine(to: CGPoint(x: 166.84, y: 246.82))
        path4Path.addCurve(to: CGPoint(x: 150.55, y: 246.89), controlPoint1: CGPoint(x: 161.8, y: 249.71), controlPoint2: CGPoint(x: 155.61, y: 249.74))
        path4Path.addLine(to: CGPoint(x: 15.41, y: 170.89))
        path4Path.addCurve(to: CGPoint(x: 11.81, y: 164.72), controlPoint1: CGPoint(x: 13.19, y: 169.63), controlPoint2: CGPoint(x: 11.81, y: 167.27))
        path4Path.addCurve(to: CGPoint(x: 15.41, y: 158.55), controlPoint1: CGPoint(x: 11.81, y: 162.17), controlPoint2: CGPoint(x: 13.19, y: 159.81))
        path4Path.addLine(to: CGPoint(x: 198.76, y: 53.55))
        path4Path.addLine(to: CGPoint(x: 341.84, y: 139.55))
        path4Path.addCurve(to: CGPoint(x: 343.73, y: 143.01), controlPoint1: CGPoint(x: 343.03, y: 140.29), controlPoint2: CGPoint(x: 343.75, y: 141.61))
        path4Path.addCurve(to: CGPoint(x: 341.73, y: 146.41), controlPoint1: CGPoint(x: 343.71, y: 144.42), controlPoint2: CGPoint(x: 342.95, y: 145.71))
        path4Path.close()
        context.saveGState()
        path4Path.addClip()
        context.drawLinearGradient(linearGradient2,
            start: CGPoint(x: 310.75, y: 87.7),
            end: CGPoint(x: -76.17, y: 304),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()


        //// Path 5 Drawing
        let path5Path = UIBezierPath()
        path5Path.move(to: CGPoint(x: 320.99, y: 142.23))
        path5Path.addLine(to: CGPoint(x: 170.6, y: 228.51))
        path5Path.addLine(to: CGPoint(x: 37.29, y: 153.57))
        path5Path.addLine(to: CGPoint(x: 189.76, y: 64.03))
        path5Path.addLine(to: CGPoint(x: 320.99, y: 142.23))
        path5Path.close()
        fillColor2.setFill()
        path5Path.fill()


        //// Oval 2 Drawing
        context.saveGState()
        context.setAlpha(0.39)

        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 80.92, y: 191.62, width: 13.3, height: 7.26))
        fillColor3.setFill()
        oval2Path.fill()

        context.restoreGState()




        //// checkmark
        //// Path 6 Drawing
        let path6Path = UIBezierPath()
        path6Path.move(to: CGPoint(x: 69.59, y: 39.87))
        path6Path.addLine(to: CGPoint(x: 71.18, y: 96.19))
        path6Path.addCurve(to: CGPoint(x: 73.05, y: 99.12), controlPoint1: CGPoint(x: 71.29, y: 97.41), controlPoint2: CGPoint(x: 71.99, y: 98.5))
        path6Path.addCurve(to: CGPoint(x: 76.52, y: 99.28), controlPoint1: CGPoint(x: 74.11, y: 99.73), controlPoint2: CGPoint(x: 75.41, y: 99.79))
        path6Path.addLine(to: CGPoint(x: 121.72, y: 74.22))
        path6Path.addCurve(to: CGPoint(x: 124.23, y: 70.09), controlPoint1: CGPoint(x: 123.28, y: 73.44), controlPoint2: CGPoint(x: 124.26, y: 71.84))
        path6Path.addLine(to: CGPoint(x: 123.23, y: 15.7))
        path6Path.addCurve(to: CGPoint(x: 121.44, y: 12.59), controlPoint1: CGPoint(x: 123.21, y: 14.42), controlPoint2: CGPoint(x: 122.53, y: 13.25))
        path6Path.addCurve(to: CGPoint(x: 117.85, y: 12.47), controlPoint1: CGPoint(x: 120.34, y: 11.94), controlPoint2: CGPoint(x: 118.99, y: 11.89))
        path6Path.addLine(to: CGPoint(x: 72.07, y: 35.75))
        path6Path.addCurve(to: CGPoint(x: 69.59, y: 39.87), controlPoint1: CGPoint(x: 70.52, y: 36.53), controlPoint2: CGPoint(x: 69.56, y: 38.14))
        path6Path.addLine(to: CGPoint(x: 69.59, y: 39.87))
        path6Path.close()
        context.saveGState()
        path6Path.addClip()
        context.drawLinearGradient(linearGradient2,
            start: CGPoint(x: 124.23, y: 12.07),
            end: CGPoint(x: 41.47, y: 146.77),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()


        //// Path 7 Drawing
        let path7Path = UIBezierPath()
        path7Path.move(to: CGPoint(x: 93.37, y: 70.79))
        path7Path.addCurve(to: CGPoint(x: 87, y: 59), controlPoint1: CGPoint(x: 91.12, y: 66.89), controlPoint2: CGPoint(x: 89, y: 62.96))
        path7Path.addCurve(to: CGPoint(x: 83.74, y: 56.88), controlPoint1: CGPoint(x: 86.36, y: 57.77), controlPoint2: CGPoint(x: 85.12, y: 56.96))
        path7Path.addCurve(to: CGPoint(x: 80.25, y: 58.6), controlPoint1: CGPoint(x: 82.35, y: 56.79), controlPoint2: CGPoint(x: 81.03, y: 57.45))
        path7Path.addLine(to: CGPoint(x: 80.2, y: 58.68))
        path7Path.addCurve(to: CGPoint(x: 79.96, y: 62.68), controlPoint1: CGPoint(x: 79.41, y: 59.87), controlPoint2: CGPoint(x: 79.32, y: 61.4))
        path7Path.addCurve(to: CGPoint(x: 86.51, y: 74.82), controlPoint1: CGPoint(x: 82.07, y: 66.76), controlPoint2: CGPoint(x: 84.24, y: 70.82))
        path7Path.addCurve(to: CGPoint(x: 93.37, y: 70.79), controlPoint1: CGPoint(x: 89, y: 79.27), controlPoint2: CGPoint(x: 95.91, y: 75.26))
        path7Path.close()
        fillColor2.setFill()
        path7Path.fill()


        //// Path 8 Drawing
        let path8Path = UIBezierPath()
        path8Path.move(to: CGPoint(x: 86.78, y: 70.89))
        path8Path.addCurve(to: CGPoint(x: 109.18, y: 31.46), controlPoint1: CGPoint(x: 94.96, y: 58.16), controlPoint2: CGPoint(x: 102.43, y: 45))
        path8Path.addCurve(to: CGPoint(x: 116.06, y: 35.46), controlPoint1: CGPoint(x: 111.47, y: 26.87), controlPoint2: CGPoint(x: 118.34, y: 30.9))
        path8Path.addCurve(to: CGPoint(x: 93.66, y: 74.89), controlPoint1: CGPoint(x: 109.31, y: 49), controlPoint2: CGPoint(x: 101.84, y: 62.16))
        path8Path.addCurve(to: CGPoint(x: 86.78, y: 70.89), controlPoint1: CGPoint(x: 90.89, y: 79.21), controlPoint2: CGPoint(x: 84, y: 75.22))
        path8Path.close()
        fillColor2.setFill()
        path8Path.fill()




        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalIn: CGRect(x: 147.71, y: 101.17, width: 125.4, height: 57.38))
        strokeColor.setStroke()
        oval4Path.lineWidth = 1
        oval4Path.stroke()


        //// shadow Drawing
        context.saveGState()
        context.setAlpha(0.46)
        context.setBlendMode(.multiply)

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 176.73, y: 128.54))
        shadowPath.addLine(to: CGPoint(x: 126.64, y: 155.96))
        shadowPath.addLine(to: CGPoint(x: 176.73, y: 182.94))
        shadowPath.addLine(to: CGPoint(x: 250.78, y: 141.99))
        context.saveGState()
        shadowPath.addClip()
        context.drawLinearGradient(linearGradient5,
            start: CGPoint(x: 172.8, y: 171.71),
            end: CGPoint(x: 192.62, y: 146.75),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()

        context.restoreGState()


        //// woman
        //// Path 9 Drawing
        let path9Path = UIBezierPath()
        path9Path.move(to: CGPoint(x: 250.78, y: 142))
        path9Path.addCurve(to: CGPoint(x: 249.26, y: 119.94), controlPoint1: CGPoint(x: 250.78, y: 142), controlPoint2: CGPoint(x: 249.67, y: 124.32))
        path9Path.addCurve(to: CGPoint(x: 236.7, y: 93.12), controlPoint1: CGPoint(x: 248.89, y: 115.94), controlPoint2: CGPoint(x: 247.57, y: 98.61))
        path9Path.addCurve(to: CGPoint(x: 192.5, y: 81.37), controlPoint1: CGPoint(x: 222.96, y: 86.18), controlPoint2: CGPoint(x: 207.13, y: 77.18))
        path9Path.addCurve(to: CGPoint(x: 176.73, y: 128.55), controlPoint1: CGPoint(x: 180.64, y: 84.77), controlPoint2: CGPoint(x: 176.6, y: 125.81))
        path9Path.addCurve(to: CGPoint(x: 250.78, y: 142), controlPoint1: CGPoint(x: 177, y: 133.46), controlPoint2: CGPoint(x: 213.75, y: 159.45))
        path9Path.close()
        fillColor4.setFill()
        path9Path.fill()


        //// Path 10 Drawing
        let path10Path = UIBezierPath()
        path10Path.move(to: CGPoint(x: 222.69, y: 95.22))
        path10Path.addCurve(to: CGPoint(x: 210.69, y: 105.64), controlPoint1: CGPoint(x: 222.69, y: 96.02), controlPoint2: CGPoint(x: 212.99, y: 107.07))
        path10Path.addCurve(to: CGPoint(x: 205.84, y: 95.22), controlPoint1: CGPoint(x: 208.39, y: 104.21), controlPoint2: CGPoint(x: 207.28, y: 94.33))
        path10Path.addCurve(to: CGPoint(x: 198.35, y: 102), controlPoint1: CGPoint(x: 204.4, y: 96.11), controlPoint2: CGPoint(x: 199.11, y: 102.5))
        path10Path.addCurve(to: CGPoint(x: 201.05, y: 81.72), controlPoint1: CGPoint(x: 197.59, y: 101.5), controlPoint2: CGPoint(x: 199.49, y: 84.56))
        path10Path.addCurve(to: CGPoint(x: 222.69, y: 95.22), controlPoint1: CGPoint(x: 202.61, y: 78.88), controlPoint2: CGPoint(x: 222.69, y: 88.94))
        path10Path.close()
        fillColor5.setFill()
        path10Path.fill()


        //// Path 11 Drawing
        let path11Path = UIBezierPath()
        path11Path.move(to: CGPoint(x: 198.31, y: 54.1))
        path11Path.addCurve(to: CGPoint(x: 198.31, y: 69.86), controlPoint1: CGPoint(x: 198.31, y: 54.1), controlPoint2: CGPoint(x: 198.37, y: 65.59))
        path11Path.addCurve(to: CGPoint(x: 207.55, y: 86.13), controlPoint1: CGPoint(x: 198.25, y: 74.36), controlPoint2: CGPoint(x: 200.15, y: 86.52))
        path11Path.addCurve(to: CGPoint(x: 222.55, y: 75.13), controlPoint1: CGPoint(x: 214.95, y: 85.74), controlPoint2: CGPoint(x: 222.55, y: 77.13))
        path11Path.addCurve(to: CGPoint(x: 225.8, y: 66.9), controlPoint1: CGPoint(x: 222.55, y: 75.13), controlPoint2: CGPoint(x: 230.03, y: 70.48))
        path11Path.addCurve(to: CGPoint(x: 221.25, y: 69.38), controlPoint1: CGPoint(x: 221.57, y: 63.32), controlPoint2: CGPoint(x: 221.25, y: 69.38))
        path11Path.addCurve(to: CGPoint(x: 218.8, y: 57.11), controlPoint1: CGPoint(x: 221.25, y: 69.38), controlPoint2: CGPoint(x: 218.96, y: 66.05))
        path11Path.addCurve(to: CGPoint(x: 198.31, y: 54.1), controlPoint1: CGPoint(x: 218.79, y: 57.13), controlPoint2: CGPoint(x: 208.23, y: 58.8))
        path11Path.close()
        fillColor6.setFill()
        path11Path.fill()


        //// Path 12 Drawing
        let path12Path = UIBezierPath()
        path12Path.move(to: CGPoint(x: 222.19, y: 87.08))
        path12Path.addCurve(to: CGPoint(x: 206.6, y: 90.39), controlPoint1: CGPoint(x: 218.42, y: 90.56), controlPoint2: CGPoint(x: 212.28, y: 91.21))
        path12Path.addCurve(to: CGPoint(x: 204.9, y: 88.78), controlPoint1: CGPoint(x: 205.72, y: 90.33), controlPoint2: CGPoint(x: 205.01, y: 89.65))
        path12Path.addCurve(to: CGPoint(x: 204.55, y: 83.57), controlPoint1: CGPoint(x: 204.81, y: 87.04), controlPoint2: CGPoint(x: 204.7, y: 85.3))
        path12Path.addLine(to: CGPoint(x: 224.06, y: 74))
        path12Path.addLine(to: CGPoint(x: 222.55, y: 86.43))
        path12Path.addCurve(to: CGPoint(x: 222.19, y: 87.08), controlPoint1: CGPoint(x: 222.55, y: 86.43), controlPoint2: CGPoint(x: 222.43, y: 86.71))
        path12Path.close()
        fillColor6.setFill()
        path12Path.fill()


        //// Path 13 Drawing
        let path13Path = UIBezierPath()
        path13Path.move(to: CGPoint(x: 208.81, y: 90.62))
        path13Path.addCurve(to: CGPoint(x: 206.54, y: 90.38), controlPoint1: CGPoint(x: 208.05, y: 90.56), controlPoint2: CGPoint(x: 207.29, y: 90.48))
        path13Path.addCurve(to: CGPoint(x: 204.9, y: 88.83), controlPoint1: CGPoint(x: 205.69, y: 90.32), controlPoint2: CGPoint(x: 205.01, y: 89.67))
        path13Path.addCurve(to: CGPoint(x: 204.75, y: 86.12), controlPoint1: CGPoint(x: 204.9, y: 87.92), controlPoint2: CGPoint(x: 204.81, y: 87.02))
        path13Path.addCurve(to: CGPoint(x: 220.11, y: 77.5), controlPoint1: CGPoint(x: 208.88, y: 86.12), controlPoint2: CGPoint(x: 216.23, y: 85.12))
        path13Path.addCurve(to: CGPoint(x: 208.81, y: 90.62), controlPoint1: CGPoint(x: 219.09, y: 83.64), controlPoint2: CGPoint(x: 214.73, y: 88.7))
        path13Path.close()
        fillColor7.setFill()
        path13Path.fill()


        //// Path 14 Drawing
        let path14Path = UIBezierPath()
        path14Path.move(to: CGPoint(x: 198.34, y: 60.64))
        path14Path.addCurve(to: CGPoint(x: 194.21, y: 50.69), controlPoint1: CGPoint(x: 198.34, y: 60.64), controlPoint2: CGPoint(x: 193.65, y: 57.64))
        path14Path.addCurve(to: CGPoint(x: 213, y: 40.34), controlPoint1: CGPoint(x: 194.77, y: 43.74), controlPoint2: CGPoint(x: 202.49, y: 39.75))
        path14Path.addCurve(to: CGPoint(x: 237.33, y: 63.34), controlPoint1: CGPoint(x: 223.51, y: 40.93), controlPoint2: CGPoint(x: 235.63, y: 46.11))
        path14Path.addCurve(to: CGPoint(x: 236.66, y: 93.1), controlPoint1: CGPoint(x: 239.03, y: 80.57), controlPoint2: CGPoint(x: 242.77, y: 90.58))
        path14Path.addCurve(to: CGPoint(x: 210.66, y: 97.26), controlPoint1: CGPoint(x: 230.55, y: 95.62), controlPoint2: CGPoint(x: 220.79, y: 98.47))
        path14Path.addCurve(to: CGPoint(x: 219.54, y: 64.5), controlPoint1: CGPoint(x: 210.66, y: 97.26), controlPoint2: CGPoint(x: 220.57, y: 77.68))
        path14Path.addCurve(to: CGPoint(x: 217.12, y: 63.56), controlPoint1: CGPoint(x: 218.51, y: 51.32), controlPoint2: CGPoint(x: 218.27, y: 61.38))
        path14Path.addCurve(to: CGPoint(x: 198.34, y: 60.64), controlPoint1: CGPoint(x: 215.97, y: 65.74), controlPoint2: CGPoint(x: 198.34, y: 60.64))
        path14Path.close()
        fillColor8.setFill()
        path14Path.fill()


        //// Path 15 Drawing
        let path15Path = UIBezierPath()
        path15Path.move(to: CGPoint(x: 228.74, y: 147.85))
        path15Path.addCurve(to: CGPoint(x: 227.64, y: 147.91), controlPoint1: CGPoint(x: 228.37, y: 147.85), controlPoint2: CGPoint(x: 228.01, y: 147.85))
        path15Path.addCurve(to: CGPoint(x: 227.7, y: 125.74), controlPoint1: CGPoint(x: 227.75, y: 140.52), controlPoint2: CGPoint(x: 227.77, y: 133.13))
        path15Path.addCurve(to: CGPoint(x: 228.91, y: 124.63), controlPoint1: CGPoint(x: 227.76, y: 125.11), controlPoint2: CGPoint(x: 228.28, y: 124.63))
        path15Path.addCurve(to: CGPoint(x: 230.13, y: 125.74), controlPoint1: CGPoint(x: 229.55, y: 124.63), controlPoint2: CGPoint(x: 230.07, y: 125.11))
        path15Path.addCurve(to: CGPoint(x: 230.07, y: 147.74), controlPoint1: CGPoint(x: 230.2, y: 133.07), controlPoint2: CGPoint(x: 230.18, y: 140.41))
        path15Path.addLine(to: CGPoint(x: 228.74, y: 147.85))
        path15Path.close()
        fillColor9.setFill()
        path15Path.fill()


        //// Path 16 Drawing
        let path16Path = UIBezierPath()
        path16Path.move(to: CGPoint(x: 188.66, y: 138.58))
        path16Path.addLine(to: CGPoint(x: 188.66, y: 138.58))
        path16Path.addCurve(to: CGPoint(x: 188.41, y: 138.46), controlPoint1: CGPoint(x: 188.58, y: 138.53), controlPoint2: CGPoint(x: 188.5, y: 138.49))
        path16Path.addLine(to: CGPoint(x: 187.75, y: 138.1))
        path16Path.addLine(to: CGPoint(x: 186.98, y: 137.68))
        path16Path.addLine(to: CGPoint(x: 186.34, y: 137.33))
        path16Path.addCurve(to: CGPoint(x: 187.12, y: 111), controlPoint1: CGPoint(x: 186.34, y: 128.54), controlPoint2: CGPoint(x: 186.6, y: 119.77))
        path16Path.addCurve(to: CGPoint(x: 189.55, y: 111), controlPoint1: CGPoint(x: 187.21, y: 109.44), controlPoint2: CGPoint(x: 189.64, y: 109.43))
        path16Path.addCurve(to: CGPoint(x: 188.76, y: 138.13), controlPoint1: CGPoint(x: 189.04, y: 120.04), controlPoint2: CGPoint(x: 188.78, y: 129.08))
        path16Path.addCurve(to: CGPoint(x: 188.66, y: 138.58), controlPoint1: CGPoint(x: 188.76, y: 138.28), controlPoint2: CGPoint(x: 188.72, y: 138.44))
        path16Path.addLine(to: CGPoint(x: 188.66, y: 138.58))
        path16Path.close()
        fillColor9.setFill()
        path16Path.fill()




        //// face-id
        //// Path 17 Drawing
        let path17Path = UIBezierPath()
        path17Path.move(to: CGPoint(x: 228.14, y: 35.86))
        path17Path.addLine(to: CGPoint(x: 245.54, y: 45.51))
        path17Path.addCurve(to: CGPoint(x: 247.67, y: 49.13), controlPoint1: CGPoint(x: 246.85, y: 46.24), controlPoint2: CGPoint(x: 247.67, y: 47.63))
        path17Path.addLine(to: CGPoint(x: 247.67, y: 75.82))
        strokeColor.setStroke()
        path17Path.lineWidth = 4
        path17Path.miterLimit = 4
        path17Path.stroke()


        //// Path 18 Drawing
        let path18Path = UIBezierPath()
        path18Path.move(to: CGPoint(x: 247.67, y: 119.15))
        path18Path.addLine(to: CGPoint(x: 247.67, y: 142.77))
        path18Path.addCurve(to: CGPoint(x: 246.13, y: 145.45), controlPoint1: CGPoint(x: 247.67, y: 143.87), controlPoint2: CGPoint(x: 247.09, y: 144.9))
        path18Path.addCurve(to: CGPoint(x: 243.04, y: 145.47), controlPoint1: CGPoint(x: 245.18, y: 146.01), controlPoint2: CGPoint(x: 244, y: 146.01))
        path18Path.addLine(to: CGPoint(x: 228.26, y: 137.09))
        strokeColor.setStroke()
        path18Path.lineWidth = 4
        path18Path.miterLimit = 4
        path18Path.stroke()


        //// Path 19 Drawing
        let path19Path = UIBezierPath()
        path19Path.move(to: CGPoint(x: 198.59, y: 19.09))
        path19Path.addLine(to: CGPoint(x: 180.31, y: 8.54))
        path19Path.addCurve(to: CGPoint(x: 178.3, y: 8.54), controlPoint1: CGPoint(x: 179.69, y: 8.18), controlPoint2: CGPoint(x: 178.92, y: 8.18))
        path19Path.addCurve(to: CGPoint(x: 177.31, y: 10.29), controlPoint1: CGPoint(x: 177.68, y: 8.91), controlPoint2: CGPoint(x: 177.3, y: 9.57))
        path19Path.addLine(to: CGPoint(x: 177.31, y: 34.62))
        strokeColor.setStroke()
        path19Path.lineWidth = 4
        path19Path.miterLimit = 4
        path19Path.stroke()


        //// Path 20 Drawing
        let path20Path = UIBezierPath()
        path20Path.move(to: CGPoint(x: 191.65, y: 121))
        path20Path.addLine(to: CGPoint(x: 178.9, y: 114.25))
        path20Path.addCurve(to: CGPoint(x: 175.68, y: 108.9), controlPoint1: CGPoint(x: 176.92, y: 113.2), controlPoint2: CGPoint(x: 175.68, y: 111.14))
        path20Path.addLine(to: CGPoint(x: 175.68, y: 86.79))
        strokeColor.setStroke()
        path20Path.lineWidth = 4
        path20Path.miterLimit = 4
        path20Path.stroke()




        //// password
        //// Path 21 Drawing
        let path21Path = UIBezierPath()
        path21Path.move(to: CGPoint(x: 181.29, y: 188.86))
        path21Path.addCurve(to: CGPoint(x: 177.14, y: 181.9), controlPoint1: CGPoint(x: 181.23, y: 185.97), controlPoint2: CGPoint(x: 179.65, y: 183.33))
        path21Path.addLine(to: CGPoint(x: 110.14, y: 143.72))
        path21Path.addCurve(to: CGPoint(x: 93.99, y: 143.81), controlPoint1: CGPoint(x: 105.13, y: 140.86), controlPoint2: CGPoint(x: 98.97, y: 140.9))
        path21Path.addCurve(to: CGPoint(x: 89.98, y: 150.94), controlPoint1: CGPoint(x: 91.48, y: 145.3), controlPoint2: CGPoint(x: 89.95, y: 148.02))
        path21Path.addCurve(to: CGPoint(x: 94.1, y: 158), controlPoint1: CGPoint(x: 90, y: 153.86), controlPoint2: CGPoint(x: 91.57, y: 156.55))
        path21Path.addLine(to: CGPoint(x: 160.84, y: 196.3))
        path21Path.addCurve(to: CGPoint(x: 177.45, y: 196), controlPoint1: CGPoint(x: 166.01, y: 199.28), controlPoint2: CGPoint(x: 172.39, y: 199.16))
        path21Path.addCurve(to: CGPoint(x: 181.29, y: 188.86), controlPoint1: CGPoint(x: 179.9, y: 194.46), controlPoint2: CGPoint(x: 181.35, y: 191.75))
        path21Path.close()
        fillColor10.setFill()
        path21Path.fill()


        //// Path 22 Drawing
        let path22Path = UIBezierPath()
        path22Path.move(to: CGPoint(x: 104.19, y: 156.92))
        path22Path.addLine(to: CGPoint(x: 103.82, y: 155.03))
        path22Path.addLine(to: CGPoint(x: 108.15, y: 154.8))
        path22Path.addLine(to: CGPoint(x: 106.15, y: 152.92))
        path22Path.addLine(to: CGPoint(x: 109.54, y: 152.08))
        path22Path.addLine(to: CGPoint(x: 111.25, y: 154.08))
        path22Path.addLine(to: CGPoint(x: 114.25, y: 152.31))
        path22Path.addLine(to: CGPoint(x: 116.93, y: 153.67))
        path22Path.addLine(to: CGPoint(x: 113.45, y: 155.18))
        path22Path.addLine(to: CGPoint(x: 117.45, y: 156.05))
        path22Path.addLine(to: CGPoint(x: 115.78, y: 157.76))
        path22Path.addLine(to: CGPoint(x: 112.07, y: 156.76))
        path22Path.addLine(to: CGPoint(x: 111.63, y: 158.95))
        path22Path.addLine(to: CGPoint(x: 107.89, y: 158.77))
        path22Path.addLine(to: CGPoint(x: 108.76, y: 156.5))
        path22Path.addLine(to: CGPoint(x: 104.19, y: 156.92))
        path22Path.close()
        fillColor3.setFill()
        path22Path.fill()


        //// Path 23 Drawing
        let path23Path = UIBezierPath()
        path23Path.move(to: CGPoint(x: 119, y: 165.84))
        path23Path.addLine(to: CGPoint(x: 118.63, y: 163.95))
        path23Path.addLine(to: CGPoint(x: 122.96, y: 163.72))
        path23Path.addLine(to: CGPoint(x: 120.96, y: 161.84))
        path23Path.addLine(to: CGPoint(x: 124.35, y: 161))
        path23Path.addLine(to: CGPoint(x: 126.06, y: 163))
        path23Path.addLine(to: CGPoint(x: 129.06, y: 161.23))
        path23Path.addLine(to: CGPoint(x: 131.74, y: 162.59))
        path23Path.addLine(to: CGPoint(x: 128.26, y: 164.1))
        path23Path.addLine(to: CGPoint(x: 132.26, y: 164.97))
        path23Path.addLine(to: CGPoint(x: 130.59, y: 166.68))
        path23Path.addLine(to: CGPoint(x: 126.88, y: 165.68))
        path23Path.addLine(to: CGPoint(x: 126.44, y: 167.87))
        path23Path.addLine(to: CGPoint(x: 122.7, y: 167.69))
        path23Path.addLine(to: CGPoint(x: 123.57, y: 165.42))
        path23Path.addLine(to: CGPoint(x: 119, y: 165.84))
        path23Path.close()
        fillColor3.setFill()
        path23Path.fill()


        //// Path 24 Drawing
        let path24Path = UIBezierPath()
        path24Path.move(to: CGPoint(x: 137.34, y: 176))
        path24Path.addLine(to: CGPoint(x: 136.97, y: 174.11))
        path24Path.addLine(to: CGPoint(x: 141.3, y: 173.88))
        path24Path.addLine(to: CGPoint(x: 139.3, y: 172))
        path24Path.addLine(to: CGPoint(x: 142.69, y: 171.16))
        path24Path.addLine(to: CGPoint(x: 144.4, y: 173.16))
        path24Path.addLine(to: CGPoint(x: 147.4, y: 171.39))
        path24Path.addLine(to: CGPoint(x: 150.08, y: 172.75))
        path24Path.addLine(to: CGPoint(x: 146.6, y: 174.26))
        path24Path.addLine(to: CGPoint(x: 150.6, y: 175.13))
        path24Path.addLine(to: CGPoint(x: 148.93, y: 176.84))
        path24Path.addLine(to: CGPoint(x: 145.22, y: 175.84))
        path24Path.addLine(to: CGPoint(x: 144.7, y: 178))
        path24Path.addLine(to: CGPoint(x: 140.96, y: 177.82))
        path24Path.addLine(to: CGPoint(x: 141.83, y: 175.55))
        path24Path.addLine(to: CGPoint(x: 137.34, y: 176))
        path24Path.close()
        fillColor3.setFill()
        path24Path.fill()


        //// Path 25 Drawing
        let path25Path = UIBezierPath()
        path25Path.move(to: CGPoint(x: 154.43, y: 185.92))
        path25Path.addLine(to: CGPoint(x: 154.06, y: 184.03))
        path25Path.addLine(to: CGPoint(x: 158.39, y: 183.8))
        path25Path.addLine(to: CGPoint(x: 156.39, y: 181.92))
        path25Path.addLine(to: CGPoint(x: 159.78, y: 181.08))
        path25Path.addLine(to: CGPoint(x: 161.49, y: 183.08))
        path25Path.addLine(to: CGPoint(x: 164.49, y: 181.31))
        path25Path.addLine(to: CGPoint(x: 167.17, y: 182.67))
        path25Path.addLine(to: CGPoint(x: 163.69, y: 184.18))
        path25Path.addLine(to: CGPoint(x: 167.69, y: 185.05))
        path25Path.addLine(to: CGPoint(x: 166.02, y: 186.76))
        path25Path.addLine(to: CGPoint(x: 162.31, y: 185.76))
        path25Path.addLine(to: CGPoint(x: 161.87, y: 187.95))
        path25Path.addLine(to: CGPoint(x: 158.13, y: 187.77))
        path25Path.addLine(to: CGPoint(x: 159, y: 185.5))
        path25Path.addLine(to: CGPoint(x: 154.43, y: 185.92))
        path25Path.close()
        fillColor3.setFill()
        path25Path.fill()




        context.endTransparencyLayer()
        context.restoreGState()
        
        context.restoreGState()

    }




    @objc(PasscodeImageResizingBehavior)
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

