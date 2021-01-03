//
//  CircleColorCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 11.12.2020.
//

import UIKit

final class GradientCategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties & Outlets
    @IBOutlet weak var circleGradient: UIView!
    var gradientLayer: CAGradientLayer?
    private var shadowLayer: CALayer?
    
    override var isSelected: Bool {
        didSet{
            shadowLayer?.removeFromSuperlayer()
            if isSelected {
                configureShadow()
                circleGradient.layer.borderWidth = 2
                circleGradient.layer.borderColor = UIColor.white.cgColor
            } else {
                circleGradient.layer.borderWidth = 0
            }
        }
    }
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        circleGradient.layer.cornerRadius = circleGradient.frame.height / 2
    }
}

//MARK: - Supporting Methods
extension GradientCategoryCollectionViewCell {
    /// Creates and configure `shadowLayer`
    private func configureShadow() {
       shadowLayer = CALayer()
       shadowLayer?.shadowColor = UIColor.black.cgColor
       shadowLayer?.shadowOpacity = 0.25
       shadowLayer?.shadowOffset = CGSize(width: 0, height: 2)
       shadowLayer?.shadowRadius = 3
       shadowLayer?.shadowPath = CGPath(ellipseIn: circleGradient.frame, transform: nil)
       layer.insertSublayer(shadowLayer!, at: 0)
   }

}
