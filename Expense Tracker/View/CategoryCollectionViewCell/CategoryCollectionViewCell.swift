//
//  CategoryCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets & Properties
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var backgroundCategory: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    var gradientLayer: CAGradientLayer?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        overallView.layer.cornerRadius = 17
        overallView.layer.borderWidth = 1
        overallView.layer.borderColor = Colors.borderColor.cgColor
        backgroundCategory.layer.cornerRadius = backgroundCategory.frame.height / 2
        backgroundCategory.backgroundColor = categoryImageView.tintColor.withAlphaComponent(0.3)
    }
}
