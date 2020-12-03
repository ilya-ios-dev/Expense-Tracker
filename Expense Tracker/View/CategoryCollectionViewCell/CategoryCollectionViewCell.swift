//
//  CategoryCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet private weak var backgroundCategory: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCategory.layer.cornerRadius = backgroundCategory.frame.height / 2
        backgroundCategory.backgroundColor = categoryImageView.tintColor.withAlphaComponent(0.3)

    }

}
