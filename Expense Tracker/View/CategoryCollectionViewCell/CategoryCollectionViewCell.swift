//
//  CategoryCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundCategory: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    var gradientLayer: CAGradientLayer?

    override var isSelected: Bool {
        didSet{
            if isSelected {
                backgroundCategory.layer.borderWidth = 3
                backgroundCategory.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
            } else {
                backgroundCategory.layer.borderWidth = 0
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCategory.layer.cornerRadius = backgroundCategory.frame.height / 2
        backgroundCategory.backgroundColor = categoryImageView.tintColor.withAlphaComponent(0.3)

    }

}
