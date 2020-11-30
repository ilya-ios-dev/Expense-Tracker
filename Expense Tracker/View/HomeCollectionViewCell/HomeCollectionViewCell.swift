//
//  HomeCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var backgroundCellView: UIView!{
        didSet{
            backgroundCellView.layer.cornerRadius = 10
            backgroundCellView.layer.borderWidth = 1
            backgroundCellView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08)
        }
    }
    @IBOutlet private weak var imageBackground: UIView!{
        didSet{
            imageBackground.layer.cornerRadius = imageBackground.frame.height / 2
            imageBackground.backgroundColor = categoryImageView.tintColor.withAlphaComponent(0.3)
        }
    }
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var sumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
