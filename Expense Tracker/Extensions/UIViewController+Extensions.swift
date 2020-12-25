//
//  UIViewController+Extensions.swift
//  Expense Tracker
//
//  Created by isEmpty on 25.12.2020.
//

import UIKit

extension UIViewController {
    /// Show a basic alert
    /// - Parameters:
    ///   - alertText: Title of alert
    ///   - alertMessage: Message of alert
    func showAlert(alertText : String, alertMessage : String? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
