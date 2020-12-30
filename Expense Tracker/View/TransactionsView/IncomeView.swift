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
        let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        transactionKindView.backgroundColor = endColor
    }
}
