//
//  CircleImageCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 11.12.2020.
//

import UIKit

final class CategoryImageCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var categoryBackgroundView: UIView!
    @IBOutlet weak var circleBackground: UIView!
    @IBOutlet weak var imageView: UIImageView!
    //MARK: - Properties
    var gradientLayer: CAGradientLayer?
    private var shadowLayer: CALayer?
    override var isSelected: Bool {
        didSet{
            shadowLayer?.removeFromSuperlayer()
            if isSelected {
                configureShadowLayer()
            }
        }
    }

    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryBackgroundView.layer.cornerRadius = 17
        categoryBackgroundView.layer.borderWidth = 1
        categoryBackgroundView.layer.borderColor = UIColor(named: "shadowColor")?.cgColor
        circleBackground.layer.cornerRadius = circleBackground.frame.height / 2
    }

}

//MARK: - Supporting Methods
extension CategoryImageCollectionViewCell {
    /// Creates and configure `shadowLayer`
    private func configureShadowLayer() {
       shadowLayer = CALayer()
       let shadowOrigin = CGPoint(x: categoryBackgroundView.frame.minX / 2, y: categoryBackgroundView.frame.minY / 2)
       let shadowFrame = CGRect(origin: shadowOrigin, size: categoryBackgroundView.frame.size)
       
       shadowLayer?.frame = shadowFrame
       shadowLayer?.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
       shadowLayer?.shadowOffset = CGSize(width: 0, height: 2)
       shadowLayer?.shadowRadius = 4
       shadowLayer?.shadowOpacity = 1
        shadowLayer?.shadowPath = CGPath(roundedRect: shadowFrame, cornerWidth: categoryBackgroundView.layer.cornerRadius, cornerHeight: categoryBackgroundView.layer.cornerRadius, transform: nil)
       layer.insertSublayer(shadowLayer!, at: 0)
   }
   
}
