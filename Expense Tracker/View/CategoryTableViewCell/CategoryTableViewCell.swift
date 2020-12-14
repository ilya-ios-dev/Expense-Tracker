//
//  CategoryTableViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!{
        didSet {
            categoryImage.image = categoryImage.image?.withRenderingMode(.alwaysTemplate)
            categoryImage.tintColor = .white
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    var gradientLayer: CAGradientLayer?

    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.height / 2
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
