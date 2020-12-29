//
//  IncomeButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 19.12.2020.
//

import UIKit

class IncomeButton: TransactionButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    private func configureViews(){
        transactionAmountLabel.text = "Income"
        transactionIconLabel.text = ">|"
        transactionKindView.backgroundColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)
    }
}
