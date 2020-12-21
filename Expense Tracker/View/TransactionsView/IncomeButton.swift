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
        transactionKindView.backgroundColor = UIColor(named: "TopGradientEnd")
    }
}
