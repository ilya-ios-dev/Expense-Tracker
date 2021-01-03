//
//  ExpenseButton.swift
//  Expense Tracker
//
//  Created by isEmpty on 19.12.2020.
//

import UIKit

final class ExpenseButton: TransactionButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureViews()
    }

    private func configureViews(){
        transactionAmountLabel.text = "Expense".localized
        transactionIconLabel.text = "|<"
        transactionKindView.backgroundColor = AppSettings.shared.startColor
    }
}
