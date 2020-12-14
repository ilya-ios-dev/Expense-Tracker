//
//  CircleColorCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 11.12.2020.
//

import UIKit

final class CircleColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var circleGradient: UIView!
    var gradientLayer: CAGradientLayer?

    override var isSelected: Bool {
        didSet{
            if isSelected {
                circleGradient.layer.borderWidth = 3
                circleGradient.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
            } else {
                circleGradient.layer.borderWidth = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleGradient.layer.cornerRadius = circleGradient.frame.height / 2
    }

}
