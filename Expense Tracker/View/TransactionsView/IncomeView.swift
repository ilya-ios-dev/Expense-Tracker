//
//  IncomeView.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

class IncomeView: TransactionView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    private func configureViews(){
        transactionKindLabel.text = "Income"
        transactionIconLabel.text = ">|"
        transactionKindView.backgroundColor = UIColor(named: "TopGradientEnd")
    }

}
