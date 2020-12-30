//
//  HomeCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var backgroundCellView: UIView!
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    var gradientLayer: CAGradientLayer?
    var isExpense: Bool = false {
        didSet {
            if isExpense {
                sumLabel.textColor = Colors.decreasingColor
                guard let text = sumLabel.text else { return }
                sumLabel.text =  "-" + text
            } else {
                sumLabel.textColor = Colors.increasingColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackground.layer.cornerRadius = imageBackground.frame.height / 2
    }
    
    override func draw(_ rect: CGRect) {
        backgroundCellView.layer.cornerRadius = 10
        backgroundCellView.layer.borderWidth = 1
        backgroundCellView.layer.borderColor = Colors.borderColor.cgColor
    }
    
}
