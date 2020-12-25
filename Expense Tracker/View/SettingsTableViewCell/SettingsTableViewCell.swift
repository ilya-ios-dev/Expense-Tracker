//
//  SettingsTableViewCell.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var settingsImageBackgroundView: UIView!
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var settingsTitle: UILabel!
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        settingsImageBackgroundView.layer.cornerRadius = settingsImageBackgroundView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
