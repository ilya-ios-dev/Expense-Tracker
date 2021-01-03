//
//  PlateView.swift
//  Expense Tracker
//
//  Created by isEmpty on 04.12.2020.
//

import UIKit

final class PlateView: UIView {
    
    //MARK: - Properties
    public var reverse = false
    public var plateText = ""
    private let cirecleDiameter = GraphConstants.circleDiameter
    
    override func draw(_ rect: CGRect) {
        if reverse {
            configureCircle(at: CGPoint(x: rect.width / 2, y: cirecleDiameter))
            configureReversePlate(rect)
        } else {
            configureCircle(at: CGPoint(x: rect.width / 2, y: rect.height - cirecleDiameter))
            configurePlate(rect)
        }
        configurePlateLabel()
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
    /// Configure plate label.
    private func configurePlateLabel() {
        let plateLabel = UILabel()
        plateLabel.text = plateText
        plateLabel.font = UIFont.systemFont(ofSize: 14)
        plateLabel.textColor = .white
        plateLabel.textAlignment = .center
        plateLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(plateLabel)
        NSLayoutConstraint.activate([
            plateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            plateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            plateLabel.topAnchor.constraint(equalTo: topAnchor),
            plateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: (reverse ? 18 : -18))
        ])
    }
    
    /// Configure reversed black Plate.
    private func configureReversePlate(_ rect: CGRect) {
        let rectSize = CGSize(width: rect.width, height: rect.height - 18)
        let rectOrigin = CGPoint(x: 0, y: rect.height - rectSize.height)
        let roundedRect = CGRect(origin: rectOrigin, size: rectSize)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: (rect.height - 18) / 5)
        
        let firstPoint = CGPoint(x: (rect.width / 2) + 5, y: rect.height - rectSize.height)
        let secondPoint = CGPoint(x: rect.width / 2, y: rect.height - rectSize.height - 5)
        let thirdPoint = CGPoint(x: (rect.width / 2) - 5, y: rect.height - rectSize.height)

        path.move(to: firstPoint)
        path.addLine(to: secondPoint)
        path.addLine(to: thirdPoint)
        
        UIColor.black.setFill()
        path.fill()
    }

    /// Configure black Plate.
    private func configurePlate(_ rect: CGRect) {
        let rectSize = CGSize(width: rect.width, height: rect.height - 18)
        let roundedRect = CGRect(origin: .zero, size: rectSize)
        let path = UIBezierPath(roundedRect: roundedRect, cornerRadius: (rect.height - 18) / 5)
        
        let firstPoint = CGPoint(x: (rect.width / 2) + 5, y: rectSize.height)
        let secondPoint = CGPoint(x: rect.width / 2, y: rectSize.height + 5)
        let thirdPoint = CGPoint(x: (rect.width / 2) - 5, y: rectSize.height)

        path.move(to: firstPoint)
        path.addLine(to: secondPoint)
        path.addLine(to: thirdPoint)
        
        UIColor.black.setFill()
        path.fill()
    }
    
    /// Adds a circle indicating the location of the element.
    private func configureCircle(at point: CGPoint) {
        AppSettings.shared.endColor.setFill()
        configureCircleOn(point, with: cirecleDiameter)?.fill()
        UIColor.white.setFill()
        configureCircleOn(point, with: cirecleDiameter / 2)?.fill()
    }
        
    /// Calculates where the circle point should be on the chart
    private func configureCircleOn(_ point: CGPoint, with diameter: CGFloat) -> UIBezierPath? {
        let circleOrigin = CGPoint(x: point.x - diameter, y: point.y - diameter)
        let backgroundCircle = UIBezierPath(ovalIn: CGRect(origin: circleOrigin, size: CGSize(width: diameter * 2, height: diameter * 2)))
        return backgroundCircle
    }
    
}
