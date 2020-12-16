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
                sumLabel.textColor = #colorLiteral(red: 0.9778844714, green: 0.120779939, blue: 0.3286553323, alpha: 1)
                guard let text = sumLabel.text else { return }
                sumLabel.text =  "-" + text
            } else {
                sumLabel.textColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackground.layer.cornerRadius = imageBackground.frame.height / 2
        
        backgroundCellView.layer.cornerRadius = 10
        backgroundCellView.layer.borderWidth = 1
        backgroundCellView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08)

    }

}
