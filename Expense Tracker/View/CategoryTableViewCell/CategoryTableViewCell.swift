//
//  CategoryTableViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    //MARK: - Outlets & Properties
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!{
        didSet {
            categoryImage.image = categoryImage.image?.withRenderingMode(.alwaysTemplate)
            categoryImage.tintColor = .white
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    var gradientLayer: CAGradientLayer?

    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.height / 2
    }
}
