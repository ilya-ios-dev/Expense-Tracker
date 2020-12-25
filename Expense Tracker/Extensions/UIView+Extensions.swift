//
//  UIView+Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

extension UIView {
    /// Creates a CAGradientLayer with the given parameters.
    /// - Parameters:
    ///   - colours: List of colors used in the gradient.
    ///   - locations: The gradient stops are specified as values between 0 and 1. The values must be monotonically increasing.
    ///     If nil, the stops are spread uniformly across the range. Defaults to nil.
    ///   - startPoint: Where the gradient starts. Accepts enum Point elements.
    ///   - endPoint: Where the gradient starts. Accepts enum Point elements.
    /// - Returns: Returns and applies the generated `CAGradientLayer`.
    @discardableResult func applyGradient(colours: [UIColor], locations: [NSNumber]? = nil, startPoint: Point = .topLeft, endPoint: Point = .bottomLeft) -> CAGradientLayer {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        
        gradient.startPoint = startPoint.point
        gradient.endPoint = endPoint.point
        
        gradient.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    /// Sets the aspect ratio.
    /// - Parameters:
    ///   - multiplier: The multiplier, with what ratio the height will correspond to the width. Default is  1.
    ///   - constant: The difference in height with width, regardless of size. Default is 0.
    /// - Returns: Returns an NSLayoutConstraint object. To make it work, you need to call isActive = true.
    public func aspectRatio(multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: self, attribute: .width, multiplier: multiplier, constant: constant)
    }
    
    /// If `view` has a `superView`, then fills it.
    /// - Parameter inset: Indent from each side. Default is 0.
    public func fillSuperview(with inset: CGFloat = 0) {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: inset),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: inset),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: inset)
        ])
    }
    
    /// Adds a round dash dotted line to view.
    /// - Parameters:
    ///   - strokeColor: Circle border color.
    ///   - fillColor: Color inside the circle.
    ///   - lineWidth: Width of dotted line.
    ///   - lineDashPattern: The dash pattern applied to the shape’s path when stroked.
    public func addDashedCircle(strokeColor: UIColor = .black, fillColor : UIColor = .clear, lineWidth: CGFloat = 2, lineDashPattern: [NSNumber]? = [6,3]) {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeColor =  strokeColor.cgColor//border of circle
        circleLayer.fillColor = fillColor.cgColor//inside the circle
        circleLayer.lineJoin = .round
        circleLayer.lineDashPattern = lineDashPattern
        layer.addSublayer(circleLayer)
    }

    /// Handle shake animation for view
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))

        self.layer.add(animation, forKey: "position")
    }
}
