//
//  PlateView.swift
//  Expense Tracker
//
//  Created by isEmpty on 04.12.2020.
//

import UIKit

final class PlateView: UIView {
    
    //MARK: - Properties
    public var plateText = "" {
        didSet {
            plateLabel.text = plateText
        }
    }
    
    private lazy var plateLabel: UILabel = {
        let label = UILabel()
        label.text = plateText
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        addCircle(at: CGPoint(x: rect.width / 2, y: rect.height - 6))
        addPlate()
        addSubview(plateLabel)
        NSLayoutConstraint.activate([
            plateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            plateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            plateLabel.topAnchor.constraint(equalTo: topAnchor),
            plateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18)
        ])
    }
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isOpaque = false
    }
    
}


//MARK: - Supporting Methods

extension PlateView {
    
    private func addPlate() {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 46, y: 0))
        shape.addCurve(to: CGPoint(x: 49, y: 3), controlPoint1: CGPoint(x: 47.66, y: 0), controlPoint2: CGPoint(x: 49, y: 1.34))
        shape.addLine(to: CGPoint(x: 49, y: 22.29))
        shape.addCurve(to: CGPoint(x: 46, y: 25.29), controlPoint1: CGPoint(x: 49, y: 23.95), controlPoint2: CGPoint(x: 47.66, y: 25.29))
        shape.addLine(to: CGPoint(x: 30.61, y: 25.29))
        shape.addLine(to: CGPoint(x: 24.5, y: 31.4))
        shape.addLine(to: CGPoint(x: 18.39, y: 25.29))
        shape.addLine(to: CGPoint(x: 3, y: 25.29))
        shape.addCurve(to: CGPoint(x: 0, y: 22.29), controlPoint1: CGPoint(x: 1.34, y: 25.29), controlPoint2: CGPoint(x: 0, y: 23.95))
        shape.addLine(to: CGPoint(x: 0, y: 3))
        shape.addCurve(to: CGPoint(x: 3, y: 0), controlPoint1: CGPoint(x: 0, y: 1.34), controlPoint2: CGPoint(x: 1.34, y: 0))
        shape.addLine(to: CGPoint(x: 46, y: 0))
        shape.close()
        UIColor.black.setFill()
        shape.fill()
    }
    
    private func addCircle(at point: CGPoint) {
        #colorLiteral(red: 0.3529411765, green: 0.2196078431, blue: 0.737254902, alpha: 1).setFill()
        calculateBackgroundCircle(point).fill()
        UIColor.white.setFill()
        calculateCircle(point).fill()
    }
    
    //Calculates where the circle point should be on the chart
    private func calculateCircle(_ point: CGPoint) -> UIBezierPath {
        let circleOrigin = CGPoint(x: point.x - 6 / 2, y: point.y - 6 / 2)
        let circle = UIBezierPath(ovalIn: CGRect(origin: circleOrigin, size: CGSize(width: 6, height: 6)))
        
        return circle
    }
    
    private func calculateBackgroundCircle(_ point: CGPoint) -> UIBezierPath {
        let circleOrigin = CGPoint(x: point.x - 6, y: point.y - 6)
        let backgroundCircle = UIBezierPath(ovalIn: CGRect(origin: circleOrigin, size: CGSize(width: 6 * 2, height: 6 * 2)))
        return backgroundCircle
    }
    
}
