//
//  ExpenseView.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class ExpenseView: TransactionView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureViews()
    }
    
    private func configureViews(){
        transactionKindLabel.text = "Expense"
        transactionIconLabel.text = "|<"
        let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
        transactionKindView.backgroundColor = startColor
    }
}
