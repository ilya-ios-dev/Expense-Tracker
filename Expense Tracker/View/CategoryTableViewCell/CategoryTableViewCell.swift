//
//  CategoryTableViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    //MARK: - Outlets & Properties
    @IBOutlet private weak var imageBackgroundView: UIView!
    @IBOutlet private weak var categoryImage: UIImageView!{
        didSet {
            categoryImage.image = categoryImage.image?.withRenderingMode(.alwaysTemplate)
            categoryImage.tintColor = .white
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    private var gradientLayer: CAGradientLayer?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.height / 2
    }
    
    public func configure(title: String, imageName: String, colors: [UIColor]) {
        titleLabel.text = title
        
        if let systemImage = UIImage(systemName: imageName){
            categoryImage?.image = systemImage
        } else if let image = UIImage(named: imageName) {
            categoryImage?.image = image.withRenderingMode(.alwaysTemplate)
        }

        gradientLayer?.removeFromSuperlayer()
        gradientLayer = imageBackgroundView.applyGradient(colours: colors)

    }
}
