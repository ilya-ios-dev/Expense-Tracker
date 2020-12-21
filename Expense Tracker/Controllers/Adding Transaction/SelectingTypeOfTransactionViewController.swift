//
//  SelectingTypeOfTransactionViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit
import CoreData

final class SelectingTypeOfTransactionViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var incomeButton: IncomeButton!
    @IBOutlet private weak var expenseButton: ExpenseButton!
    
    //MARK: - Properties
    public var transaction: Transaction?
    private lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        return appDelegate.container.viewContext
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if transaction == nil {
            transaction = Transaction(context: context)
        }
    }
    
    //MARK: - Actions
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /// Listens to pressing two buttons.
    /// Pass the transaction `isExpense` object depending on which button pressed.
    /// Passes the next `ViewController` to the `UINavigationController`.
    /// - Parameter sender: Subclass `TransactionButton`.
    @IBAction func categorySelected(_ sender: TransactionButton) {
        let storyboard = UIStoryboard(name: "FillingAmountAndDescriptionViewController", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? FillingAmountAndDescriptionViewController else { return }
        if sender is IncomeButton {
            transaction?.isExpense = false
            controller.transaction = transaction
        } else if sender is ExpenseButton {
            transaction?.isExpense = true
            controller.transaction = transaction
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
