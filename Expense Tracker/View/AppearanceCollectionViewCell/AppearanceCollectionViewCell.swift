//
//  AppearCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 27.12.2020.
//

import UIKit

final class AppearanceCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    public var appearance: Appearance! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal enum Appearance {
        case automatic
        case dark
        case light
    }
    
    //MARK: - Initializations
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isOpaque = false
    }
    
    //MARK: - Drawing
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        // Scale Stiings
        let resizedFrame: CGRect = ResizingBehavior.aspectFit.apply(rect: CGRect(x: 0, y: 0, width: 120, height: 85), target: rect)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 120, y: resizedFrame.height / 85)
        let resizedShadowScale: CGFloat = min(resizedFrame.width / 120, resizedFrame.height / 85)
        // Drawing
        drawTitleLabel(appearance, rect: resizedFrame)
        drawAppearanceImage(context, resizedShadowScale, appearance)
        if isSelected {
            addSelectedOutline()
        }
        context.endTransparencyLayer()
        context.restoreGState()
    }
}

//MARK: - Drawing Methods
extension AppearanceCollectionViewCell {
    //MARK: - Bottom Label Drawing
    /// Bottom Title Label Drawing
    private func drawTitleLabel(_ appearance: AppearanceCollectionViewCell.Appearance, rect: CGRect) {
        let appearanceTitleColor = UIColor.label
        let labelRect = CGRect(x: 0, y: 62, width: rect.width, height: 23)
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .center
        let labelFontAttributes = [
            .font: UIFont.systemFont(ofSize: 15, weight: .light),
            .foregroundColor: appearanceTitleColor,
            .paragraphStyle: labelStyle,
        ] as [NSAttributedString.Key: Any]
        
        switch appearance {
        case .automatic:
            "Automatic".localized.draw(in: labelRect, withAttributes: labelFontAttributes)
        case .dark:
            "Dark".localized.draw(in: labelRect, withAttributes: labelFontAttributes)
        case .light:
            "Light".localized.draw(in: labelRect, withAttributes: labelFontAttributes)
        }
    }
    
    //MARK: - Outline Drawing
    
    /// Draw outline around Appear Image
    private func addSelectedOutline() {
        let selectedStrokeColor = AppSettings.shared.endColor
        let strokePathPath = UIBezierPath(roundedRect: CGRect(x: 5, y: 3, width: 109, height: 56), cornerRadius: 8)
        selectedStrokeColor.setStroke()
        strokePathPath.lineWidth = 2
        strokePathPath.stroke()
    }
    
    //MARK: - Appear Image Drawing
    /// Draw Appear Image
    private func drawAppearanceImage(_ context: CGContext, _ resizedShadowScale: CGFloat, _ appearance: AppearanceCollectionViewCell.Appearance) {
        // Color Declarations
        let darkTitleColor: UIColor!
        let transactionsBackgroundColor: UIColor!
        let lightStrokeColor: UIColor!
        
        switch appearance {
        case .automatic:
            transactionsBackgroundColor = #colorLiteral(red: 0.239, green: 0.239, blue: 0.239, alpha: 1.000)
            lightStrokeColor = #colorLiteral(red: 0.894, green: 0.894, blue: 0.894, alpha: 1.000)
            darkTitleColor = #colorLiteral(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        case .light:
            transactionsBackgroundColor = UIColor.white
            lightStrokeColor = #colorLiteral(red: 0.894, green: 0.894, blue: 0.894, alpha: 1.000)
            darkTitleColor = UIColor.white
        case .dark:
            transactionsBackgroundColor = #colorLiteral(red: 0.239, green: 0.239, blue: 0.239, alpha: 1.000)
            lightStrokeColor = #colorLiteral(red: 0.329, green: 0.329, blue: 0.329, alpha: 1.000)
            darkTitleColor = #colorLiteral(red: 0.239, green: 0.239, blue: 0.239, alpha: 1.000)
        }
        context.saveGState()
        
        drawShadow(context, resizedShadowScale)
        addClip()
        drawBackgoundGradient(context)
        drawTransactionsBackground(context, transactionsBackgroundColor)
        drawTransaction(context, darkTitleColor, lightStrokeColor, appearance, transactionsBackgroundColor)
    }
    
    /// Draw Shadow behind Appear Image
    private func drawShadow(_ context: CGContext, _ resizedShadowScale: CGFloat) {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.15)
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowBlurRadius = 4
        context.setShadow(offset: CGSize(width: shadow.shadowOffset.width * resizedShadowScale, height: shadow.shadowOffset.height * resizedShadowScale), blur: shadow.shadowBlurRadius * resizedShadowScale, color: (shadow.shadowColor as! UIColor).cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
    }
    
    /// Add Clipping Path
    private func addClip() {
        let clippingPathPath = UIBezierPath(roundedRect: CGRect(x: 5, y: 3, width: 109, height: 56), cornerRadius: 8)
        clippingPathPath.addClip()
    }
    
    /// Draws Background Gradient
    private func drawBackgoundGradient(_ context: CGContext) {
        let backgroundGradientStart = AppSettings.shared.startColor
        let backgroundGradientEnd = AppSettings.shared.endColor
        
        let linearGradient1 = CGGradient(colorsSpace: nil, colors: [backgroundGradientStart.cgColor, backgroundGradientEnd.cgColor] as CFArray, locations: [0, 1])!
        
        let backgroundGradientPath = UIBezierPath(rect: CGRect(x: 5, y: 3, width: 109, height: 56))
        context.saveGState()
        backgroundGradientPath.addClip()
        context.drawLinearGradient(linearGradient1,
                                   start: CGPoint(x: 5, y: 38.39),
                                   end: CGPoint(x: 114, y: 23.61),
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()
    }

    /// Draws background behind Transaction
    private func drawTransactionsBackground(_ context: CGContext, _ transactionsBackgroundColor: UIColor) {
        context.saveGState()
        context.setBlendMode(.sourceAtop)
        let transactionsBackgroundPath = UIBezierPath(rect: CGRect(x: 5, y: 39, width: 109, height: 20))
        transactionsBackgroundColor.setFill()
        transactionsBackgroundPath.fill()
        
        context.restoreGState()
    }
        
    /// Draws Transaction
    private func drawTransaction(_ context: CGContext , _ darkTitleColor: UIColor, _ lightStrokeColor: UIColor, _ appearance: Appearance, _ transactionsBackgroundColor: UIColor) {
        drawTransactionBackground(darkTitleColor, lightStrokeColor)
        
        if appearance == .automatic {
            drawDarkSideOfTransaction(context, transactionsBackgroundColor)
        }
        
        drawCircleGradient(context)
        drawDateLabel()
        
        switch appearance {
        case .automatic:
            drawAutomaticTitleLabel(context, #colorLiteral(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000), darkTitleColor)
        case .dark:
            drawNonAutomaticTitleLabel(UIColor.white, context)
        case .light:
            drawNonAutomaticTitleLabel(UIColor.black, context)
        }
    }

    /// Draws transaction's rectangle
    private func drawTransactionBackground(_ darkTitleColor: UIColor, _ lightStrokeColor: UIColor) {
        let transactionBackgroundPath = UIBezierPath()
        transactionBackgroundPath.move(to: CGPoint(x: 126.25, y: 31.25))
        transactionBackgroundPath.addLine(to: CGPoint(x: 126.25, y: 58.75))
        transactionBackgroundPath.addLine(to: CGPoint(x: 24.5, y: 58.75))
        transactionBackgroundPath.addCurve(to: CGPoint(x: 21.5, y: 57.65), controlPoint1: CGPoint(x: 23.33, y: 58.75), controlPoint2: CGPoint(x: 22.26, y: 58.33))
        transactionBackgroundPath.addCurve(to: CGPoint(x: 20.25, y: 55), controlPoint1: CGPoint(x: 20.73, y: 56.97), controlPoint2: CGPoint(x: 20.25, y: 56.04))
        transactionBackgroundPath.addLine(to: CGPoint(x: 20.25, y: 55))
        transactionBackgroundPath.addLine(to: CGPoint(x: 20.25, y: 35))
        transactionBackgroundPath.addCurve(to: CGPoint(x: 21.5, y: 32.35), controlPoint1: CGPoint(x: 20.25, y: 33.96), controlPoint2: CGPoint(x: 20.73, y: 33.03))
        transactionBackgroundPath.addCurve(to: CGPoint(x: 24.5, y: 31.25), controlPoint1: CGPoint(x: 22.26, y: 31.67), controlPoint2: CGPoint(x: 23.33, y: 31.25))
        transactionBackgroundPath.addLine(to: CGPoint(x: 24.5, y: 31.25))
        transactionBackgroundPath.addLine(to: CGPoint(x: 126.25, y: 31.25))
        transactionBackgroundPath.close()
        transactionBackgroundPath.usesEvenOddFillRule = true
        darkTitleColor.setFill()
        transactionBackgroundPath.fill()
        lightStrokeColor.setStroke()
        transactionBackgroundPath.lineWidth = 0.5
        transactionBackgroundPath.miterLimit = 4
        transactionBackgroundPath.stroke()
    }

    /// Draws dark side of transaction
    private func drawDarkSideOfTransaction(_ context: CGContext, _ transactionsBackgroundColor: UIColor) {
        let darkStrokeColor = #colorLiteral(red: 0.329, green: 0.329, blue: 0.329, alpha: 1.000)
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let automaticClippingPathPath = UIBezierPath(rect: CGRect(x: 18, y: 31, width: 42, height: 28))
        automaticClippingPathPath.addClip()
        
        let blackBackgroundTransactionPath = UIBezierPath()
        blackBackgroundTransactionPath.move(to: CGPoint(x: 69.75, y: 31.25))
        blackBackgroundTransactionPath.addLine(to: CGPoint(x: 69.75, y: 58.75))
        blackBackgroundTransactionPath.addLine(to: CGPoint(x: 24, y: 58.75))
        blackBackgroundTransactionPath.addCurve(to: CGPoint(x: 21.35, y: 57.65), controlPoint1: CGPoint(x: 22.96, y: 58.75), controlPoint2: CGPoint(x: 22.03, y: 58.33))
        blackBackgroundTransactionPath.addCurve(to: CGPoint(x: 20.25, y: 55), controlPoint1: CGPoint(x: 20.67, y: 56.97), controlPoint2: CGPoint(x: 20.25, y: 56.04))
        blackBackgroundTransactionPath.addLine(to: CGPoint(x: 20.25, y: 55))
        blackBackgroundTransactionPath.addLine(to: CGPoint(x: 20.25, y: 35))
        blackBackgroundTransactionPath.addCurve(to: CGPoint(x: 21.35, y: 32.35), controlPoint1: CGPoint(x: 20.25, y: 33.96), controlPoint2: CGPoint(x: 20.67, y: 33.03))
        blackBackgroundTransactionPath.addCurve(to: CGPoint(x: 24, y: 31.25), controlPoint1: CGPoint(x: 22.03, y: 31.67), controlPoint2: CGPoint(x: 22.96, y: 31.25))
        blackBackgroundTransactionPath.addLine(to: CGPoint(x: 24, y: 31.25))
        blackBackgroundTransactionPath.addLine(to: CGPoint(x: 69.75, y: 31.25))
        blackBackgroundTransactionPath.close()
        blackBackgroundTransactionPath.usesEvenOddFillRule = true
        transactionsBackgroundColor.setFill()
        blackBackgroundTransactionPath.fill()
        darkStrokeColor.setStroke()
        blackBackgroundTransactionPath.lineWidth = 0.5
        blackBackgroundTransactionPath.miterLimit = 4
        blackBackgroundTransactionPath.stroke()
        
        context.endTransparencyLayer()
        context.restoreGState()
    }

    /// Draws circle gradient inside transaction
    private func drawCircleGradient(_ context: CGContext) {
        let circleGradientStart = #colorLiteral(red: 1.000, green: 0.627, blue: 0.631, alpha: 1.000)
        let circleGradientEnd = #colorLiteral(red: 0.980, green: 0.800, blue: 0.753, alpha: 1.000)
        let linearGradient7 = CGGradient(colorsSpace: nil, colors: [circleGradientStart.cgColor, circleGradientEnd.cgColor] as CFArray, locations: [0, 1])!
        
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 26, y: 37, width: 17, height: 17))
        context.saveGState()
        oval2Path.addClip()
        context.drawLinearGradient(linearGradient7,
                                   start: CGPoint(x: 34.5, y: 37),
                                   end: CGPoint(x: 34.5, y: 54),
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        context.restoreGState()
    }
    
    /// Draws Date Label
    private func drawDateLabel() {
        let dateLabelColor = #colorLiteral(red: 0.608, green: 0.608, blue: 0.608, alpha: 1.000)
        
        let dateLabelRect = CGRect(x: 48.5, y: 46, width: 55.66, height: 8)
        let dateLabelStyle = NSMutableParagraphStyle()
        dateLabelStyle.alignment = .left
        let dateLabelFontAttributes = [
            .font: UIFont.systemFont(ofSize: 5, weight: .light),
            .foregroundColor: dateLabelColor,
            .paragraphStyle: dateLabelStyle,
        ] as [NSAttributedString.Key: Any]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, HH:MM"

        dateFormatter.string(from: Date()).draw(in: dateLabelRect, withAttributes: dateLabelFontAttributes)
    }
    
    /// Draws Label with two colors
    private func drawAutomaticTitleLabel(_ context: CGContext, _ fillColor: UIColor, _ fillColor3: UIColor) {
        // Light Label
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: 60, y: 31, width: 44, height: 28))
        rectanglePath.addClip()
        
        let titleLabel2Rect = CGRect(x: 48.06, y: 35, width: 55.94, height: 8)
        let titleLabel2Style = NSMutableParagraphStyle()
        titleLabel2Style.alignment = .left
        let titleLabel2FontAttributes = [
            .font: UIFont.systemFont(ofSize: 7, weight: .light),
            .foregroundColor: fillColor,
            .paragraphStyle: titleLabel2Style,
        ] as [NSAttributedString.Key: Any]
        
        "Title".draw(in: titleLabel2Rect, withAttributes: titleLabel2FontAttributes)
        
        context.endTransparencyLayer()
        context.restoreGState()
        
        // Dark Label
        context.saveGState()
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let rectangle15Path = UIBezierPath(rect: CGRect(x: 20, y: 31, width: 40, height: 28))
        rectangle15Path.addClip()

        let titleLabelRect = CGRect(x: 48.06, y: 35, width: 55.94, height: 8)
        let titleLabelStyle = NSMutableParagraphStyle()
        titleLabelStyle.alignment = .left
        let titleLabelFontAttributes = [
            .font: UIFont.systemFont(ofSize: 7, weight: .light),
            .foregroundColor: fillColor3,
            .paragraphStyle: titleLabelStyle,
        ] as [NSAttributedString.Key: Any]
        
        "Title".draw(in: titleLabelRect, withAttributes: titleLabelFontAttributes)
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
    
    /// Drawing Label for Light or Dark Appearance
    private func drawNonAutomaticTitleLabel(_ fillColor3: UIColor, _ context: CGContext) {
        let titleLabelNonAutomaticRect = CGRect(x: 48.06, y: 35, width: 55.94, height: 8)
        let titleLabelNonAutomaticStyle = NSMutableParagraphStyle()
        titleLabelNonAutomaticStyle.alignment = .left
        let titleLabelNonAutomaticFontAttributes = [
            .font: UIFont.systemFont(ofSize: 7, weight: .light),
            .foregroundColor: fillColor3,
            .paragraphStyle: titleLabelNonAutomaticStyle,
        ] as [NSAttributedString.Key: Any]
        
        "Title".draw(in: titleLabelNonAutomaticRect, withAttributes: titleLabelNonAutomaticFontAttributes)
        
        context.endTransparencyLayer()
        context.restoreGState()
    }
}
