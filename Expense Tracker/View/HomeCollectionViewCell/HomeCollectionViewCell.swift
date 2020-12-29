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
                sumLabel.textColor = UIColor(named: "DecreasingColor")
                guard let text = sumLabel.text else { return }
                sumLabel.text =  "-" + text
            } else {
                sumLabel.textColor = UIColor(named: "IncreasingColor")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackground.layer.cornerRadius = imageBackground.frame.height / 2
        
        backgroundCellView.layer.cornerRadius = 10
        backgroundCellView.layer.borderWidth = 1
        backgroundCellView.layer.borderColor = UIColor(named: "shadowColor")?.cgColor

    }

}
