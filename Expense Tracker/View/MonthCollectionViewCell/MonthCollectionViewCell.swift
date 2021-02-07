//
//  MonthCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class MonthCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets & Properties
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var monthLabel: UILabel!
    @IBOutlet private weak var monthBackground: UIView!
    private var gradientLayer: CAGradientLayer?
        
    override var isSelected: Bool{
        didSet{
            configureGradient()
        }
    }
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        monthBackground.layer.cornerRadius = 8
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        configureGradient()
    }
    
    //MARK: - Supporting Methods
    private func configureGradient() {
        gradientLayer?.removeFromSuperlayer()
        if isSelected {
            let startColor = AppSettings.shared.startColor
            let endColor = AppSettings.shared.endColor
            gradientLayer = monthBackground?.applyGradient(colours: [startColor, endColor], startPoint: .bottomLeft, endPoint: .topRight)
            monthLabel?.textColor = .white
        } else {
            monthLabel?.textColor = #colorLiteral(red: 0.337254902, green: 0.3568627451, blue: 0.4, alpha: 1)
        }
    }
    
    public func configure(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: date)
        formatter.dateFormat = "YYYY"
        yearLabel.text = formatter.string(from: date)
    }
}
