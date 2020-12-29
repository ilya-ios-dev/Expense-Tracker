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
        let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        transactionKindView.backgroundColor = endColor
    }

}
