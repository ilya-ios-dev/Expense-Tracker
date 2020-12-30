//
//  IncomeButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 19.12.2020.
//

import UIKit

final class IncomeButton: TransactionButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureViews()
    }

    private func configureViews(){
        transactionAmountLabel.text = "Income"
        transactionIconLabel.text = ">|"
        transactionKindView.backgroundColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)
    }
}
