//
//  CategoryCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets & Properties
    @IBOutlet private weak var overallView: UIView!
    @IBOutlet private weak var backgroundCategory: UIView!
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    private var gradientLayer: CAGradientLayer?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        overallView.layer.cornerRadius = 17
        overallView.layer.borderWidth = 1
        overallView.layer.borderColor = Colors.borderColor.cgColor
        backgroundCategory.layer.cornerRadius = backgroundCategory.frame.height / 2
        backgroundCategory.backgroundColor = categoryImageView.tintColor.withAlphaComponent(0.3)
    }
    
    public func configure(title: String, imageName: String, colors: [UIColor]) {
        textLabel.text = title
        
        if let systemImage = UIImage(systemName: imageName){
            categoryImageView?.image = systemImage
        } else if let image = UIImage(named: imageName) {
            categoryImageView?.image = image.withRenderingMode(.alwaysTemplate)
        }

        gradientLayer?.removeFromSuperlayer()
        gradientLayer = backgroundCategory.applyGradient(colours: colors)
    }
}
