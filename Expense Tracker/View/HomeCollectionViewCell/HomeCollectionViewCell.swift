//
//  HomeCollectionViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet private weak var backgroundCellView: UIView!
    @IBOutlet private weak var imageBackground: UIView!
    @IBOutlet private weak var categoryImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var sumLabel: UILabel!
    
    //MARK: - Properties
    private var gradientLayer: CAGradientLayer?
    private var isExpense: Bool = false {
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
    
    public func configure(title: String?, date: Date, sum: String, isExpense: Bool, startColor: UIColor?, endColor: UIColor?, imageName: String) {
        titleLabel.text = title
        sumLabel.text = sum
        self.isExpense = isExpense
        
        // Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateLabel.text = "\(dateFormatter.string(from: date))"
        
        // Category Image
        if let systemImage = UIImage(systemName: imageName){
            categoryImageView.image = systemImage
        } else if let image = UIImage(named: imageName) {
            categoryImageView.image = image.withRenderingMode(.alwaysTemplate)
        }
        
        // Gradient below image
        gradientLayer?.removeFromSuperlayer()
        if let startColor = startColor, let endColor = endColor {
            gradientLayer = imageBackground.applyGradient(colours: [startColor, endColor])
        }
    }
    
    //MARK: - Life Cycle & Drawing
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
