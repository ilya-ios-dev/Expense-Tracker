//
//  ExpenseView.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

class ExpenseView: TransactionView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    private func configureViews(){
        transactionKindLabel.text = "Expense"
        transactionIconLabel.text = "|<"
        transactionKindView.backgroundColor = UIColor(named: "TopGradientStart")
    }
}
