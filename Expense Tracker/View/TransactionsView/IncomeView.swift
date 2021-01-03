//
//  IncomeView.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class IncomeView: TransactionView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configureViews()
    }

    private func configureViews(){
        transactionKindLabel.text = "Income".localized
        transactionIconLabel.text = ">|"
        transactionKindView.backgroundColor = AppSettings.shared.endColor
    }
}
