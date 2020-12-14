//
//  CircleImageCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 11.12.2020.
//

import UIKit

class CircleImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var circleBackground: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var gradientLayer: CAGradientLayer?

    override var isSelected: Bool {
        didSet{
            if isSelected {
                circleBackground.layer.borderWidth = 3
                circleBackground.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
            } else {
                circleBackground.layer.borderWidth = 0
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleBackground.layer.cornerRadius = circleBackground.frame.height / 2
    }

}
