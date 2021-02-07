//
//  TransactionTypeViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit
import CoreData

/// Вид создания транзакции.
enum CreatingType {
    case recreate, editing, none
}

final class TransactionTypeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var incomeButton: IncomeButton!
    @IBOutlet private weak var expenseButton: ExpenseButton!
    
    //MARK: - Properties
    public var transaction: Transaction!
    public var creatingType = CreatingType.none
    
    private let appSettings = AppSettings.shared
    private var balance: Balance!
    
    private lazy var mainContext: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).container.viewContext
    }()
    
    private lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = appDelegate.container.viewContext
        return privateContext
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.overrideUserInterfaceStyle = appSettings.userInterfaceStyle
        configureTransaction()
    }
    
    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /// Listens to pressing two buttons.
    /// Pass the transaction `isExpense` object depending on which button pressed.
    /// Passes the next `ViewController` to the `UINavigationController`.
    /// - Parameter sender: Subclass `TransactionButton`.
    @IBAction private func categorySelected(_ sender: TransactionButton) {
        let isExpense = sender is ExpenseButton
        switch creatingType {
        case .recreate, .none:
            createTapped(isExpense)
        case .editing:
            editTapped(isExpense)
        }
    }
}

//MARK: - Supporting Methods
extension TransactionTypeViewController {
    private func fetchBalance() {
        let fetchRequest: NSFetchRequest = Balance.fetchRequest()
        do {
            balance = try context.fetch(fetchRequest).first ?? Balance(context: context)
        } catch {
            showAlert(alertText: error.localizedDescription)
        }
    }
    
    // Настраивает объект танзакции в соответствии с видом редактирования
    private func configureTransaction() {
        switch creatingType {
        case .recreate:
            transaction = try? context.existingObject(with: transaction.objectID) as? Transaction
            fetchBalance()
            balance.totalBalance += transaction.isExpense ? transaction.amount : -transaction.amount
        case .editing:
            transaction = try? context.existingObject(with: transaction.objectID) as? Transaction
        case .none:
            transaction = Transaction(context: context)
        }
    }
    
    // Сохраняет поле isExpense и передает транзакцию другому контроллеру
    private func createTapped(_ isExpense: Bool) {
        let storyboard = UIStoryboard(name: Storyboards.transactionAmount, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController()
                as? TransactionAmountViewController else { return }
        transaction.isExpense = isExpense
        controller.transaction = transaction
        controller.creatingType = creatingType
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // Сохраняет транзакцию с одним измененым полем
    private func editTapped(_ isExpense: Bool) {
        transaction.isExpense = isExpense
        
        do {
            try context.save()
            context.performAndWait {
                do {
                    try mainContext.save()
                } catch {
                    print(error)
                    showAlert(alertText: error.localizedDescription)
                }
            }
            dismiss(animated: true, completion: nil)
        } catch {
            print(error)
            showAlert(alertText: error.localizedDescription)
        }
    }
}
