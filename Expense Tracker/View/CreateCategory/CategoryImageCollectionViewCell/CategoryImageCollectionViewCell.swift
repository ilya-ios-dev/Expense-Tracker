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
    @IBOutlet private weak var circleBackground: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    //MARK: - Properties
    private var gradientLayer: CAGradientLayer?
    private var shadowLayer: CALayer?
    override var isSelected: Bool {
        didSet{
            shadowLayer?.removeFromSuperlayer()
            if isSelected {
                categoryBackgroundView.backgroundColor = Colors.selectedColor
                configureShadowLayer()
            } else {
                categoryBackgroundView.backgroundColor = Colors.tabBarColor
            }
        }
    }
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryBackgroundView.layer.cornerRadius = 17
        categoryBackgroundView.layer.borderWidth = 1
        categoryBackgroundView.layer.borderColor = Colors.shadowColor.cgColor
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
    
    public func configure(imageName: String, colors: [UIColor]) {
        if let systemImage = UIImage(systemName: imageName){
            imageView.image = systemImage
        } else if let image = UIImage(named: imageName) {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
        }

       gradientLayer?.removeFromSuperlayer()
       gradientLayer = circleBackground?.applyGradient(colours: colors, startPoint: .bottomLeft, endPoint: .topRight)
    }
}
