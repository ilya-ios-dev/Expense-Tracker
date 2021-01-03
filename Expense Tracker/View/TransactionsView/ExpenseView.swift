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
        transactionKindLabel.text = "Expense".localized
        transactionIconLabel.text = "|<"
        transactionKindView.backgroundColor = AppSettings.shared.startColor
    }
}
