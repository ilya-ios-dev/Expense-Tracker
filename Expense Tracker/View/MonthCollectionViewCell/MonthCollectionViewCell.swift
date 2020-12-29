//
//  MonthCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class MonthCollectionViewCell: UICollectionViewCell {

    @IBOutlet public weak var yearLabel: UILabel!
    @IBOutlet public weak var monthLabel: UILabel!
    @IBOutlet public weak var monthBackground: UIView!
    private var gradientLayer: CAGradientLayer?
        
    override var isSelected: Bool{
        didSet{
            gradientLayer?.removeFromSuperlayer()
            if isSelected {
                let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1)
                let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
                gradientLayer = monthBackground.applyGradient(colours: [startColor, endColor], startPoint: .bottomLeft, endPoint: .topRight)
                monthLabel.textColor = .white
            } else {
                monthLabel.textColor = #colorLiteral(red: 0.337254902, green: 0.3568627451, blue: 0.4, alpha: 1)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monthBackground.layer.cornerRadius = 8
    }

}

extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero

        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }

        layer.colors = layerColorSet
        layer.locations = layerLocations

        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }

        self.layer.insertSublayer(layer, above: self.layer)
    }
}
