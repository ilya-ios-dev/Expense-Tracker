//
//  ExpenseButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 19.12.2020.
//

import UIKit

class ExpenseButton: TransactionButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    private func configureViews(){
        transactionAmountLabel.text = "Expense"
        transactionIconLabel.text = "|<"
        
        transactionKindView.backgroundColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.5490196078, green: 0.298, blue: 0.831, alpha: 1)
    }
}
