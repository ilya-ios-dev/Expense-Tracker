//
//  TabBar.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class TabBar: UITabBar {
    
    //MARK: - Properties
    private var shapeLayer: CALayer?
    private var centerButton: UIButton!
    
    //MARK: - Drawing
    override func draw(_ rect: CGRect) {
        shapeLayer?.removeFromSuperlayer()
        self.addShape()
        configureCenterButton(rect)
        centerButton.backgroundColor = [AppSettings.shared.startColor, AppSettings.shared.endColor].averageColor()
        centerButton.layer.shadowColor = centerButton.backgroundColor?.cgColor
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
}


//MARK: - Configure Displaying
extension TabBar {
    
    /// Adds a button in the center of the tab bar.
    /// - Parameter frame: Rectangle tab bar.
    private func configureCenterButton(_ frame: CGRect) {
        guard centerButton == nil else { return }
        centerButton = UIButton(type: .custom)
        
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(centerButton)
        NSLayoutConstraint.activate([
            centerButton.heightAnchor.constraint(equalToConstant: 55),
            centerButton.widthAnchor.constraint(equalTo: centerButton.heightAnchor),
            centerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: topAnchor)
        ])
        
        centerButton.layer.cornerRadius = 55 / 2
        
        centerButton.layer.shadowRadius = 8
        centerButton.layer.shadowOpacity = 0.5
        centerButton.layer.shadowOffset = .zero
        let buttonRect = CGRect(x: 0, y: 0, width: 55, height: 55)
        centerButton.layer.shadowPath = UIBezierPath(ovalIn: buttonRect).cgPath
        
        centerButton.addTarget(self, action: #selector(centerButtonTapped(_:)), for: .touchUpInside)
    }

    /// Adds a bezier curve as a sublayer.
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = Colors.shadowColor.cgColor
        shapeLayer.fillColor = Colors.tabBarColor.cgColor
        shapeLayer.lineWidth = 0.5
        layer.shadowOffset = CGSize(width:0, height:0)
        layer.shadowRadius = 10
        layer.shadowColor = Colors.shadowColor.cgColor
        layer.shadowOpacity = 1
        layer.shadowPath = shapeLayer.path
        self.layer.insertSublayer(shapeLayer, at: 0)
        self.shapeLayer = shapeLayer
    }
    
    ///  Creates a bezier curve with a sag in the middle.
    func createPath() -> CGPath {
        let height: CGFloat = 86.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: (centerWidth - height ), y: 0))
        path.addCurve(to: CGPoint(x: centerWidth, y: height - 40),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 35, y: height - 40))
        path.addCurve(to: CGPoint(x: (centerWidth + height ), y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height - 40), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
}

//MARK: - Supporting Methods
extension TabBar {
    @objc private func centerButtonTapped(_ sender: UIButton){
        guard let count = items?.count else { return }
        guard let item = items?[count / 2] else { return }
        delegate?.tabBar?(self, didSelect: item)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !self.isHidden else {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = centerButton.center
        
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? centerButton : super.hitTest(point, with: event)
    }
}
