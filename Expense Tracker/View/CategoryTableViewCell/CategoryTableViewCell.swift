//
//  CategoryTableViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var imageBackgroundView: UIView!{
        didSet{
            imageBackgroundView.layer.cornerRadius = imageBackgroundView.frame.height / 2
            imageBackgroundView.backgroundColor = categoryImage.tintColor.withAlphaComponent(0.3)
        }
    }
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
