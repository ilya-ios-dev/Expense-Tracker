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
        transactionKindView.backgroundColor = UIColor(named: "TopGradientStart")
    }
}
