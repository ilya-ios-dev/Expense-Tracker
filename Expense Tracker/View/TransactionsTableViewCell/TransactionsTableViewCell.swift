//
//  TransactionsTableViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.12.2020.
//

import UIKit

final class TransactionsTableViewCell: UITableViewCell {
    
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
}
