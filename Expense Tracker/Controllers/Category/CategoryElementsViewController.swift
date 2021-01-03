//
//  CategoryElementsViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.12.2020.
//

import UIKit
import CoreData

final class CategoryElementsViewController: UITableViewController {

    //MARK: - Properties
    public var category: Category!
    private var balance: Balance!
    private var currentSearchText = ""
    private var fetchedResultsController: NSFetchedResultsController<Transaction>!
    private var diffableDataSource: UITableViewDiffableDataSource<Int, Transaction>!
    private var diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Transaction>()
    private let appSettings = AppSettings.shared
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return appDelegate.container.viewContext
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure UI
        configureTableView()
        createSearchController()

        //Setup Data
        fetchBalance()
        setupFetchedResultsController()
        setupDiffableDataSource()
    }
}

//MARK: - Supptorting Methods
extension CategoryElementsViewController {
    ///Gets `balance` from CoreData. If not already created, creates.
    private func fetchBalance() {
        let request: NSFetchRequest = Balance.fetchRequest()
        balance = try? context.fetch(request).first ?? Balance(context: context)
    }

    /// Setup the `NSFetchedResultsController` which gets the data from `Category`
    private func setupFetchedResultsController() {
        let request: NSFetchRequest = Transaction.fetchRequest()
        
        var subPredicates = [NSPredicate]()
        let categoryPredicate = NSPredicate(format: "%K == %@", "category.name", category.name)
        subPredicates.append(categoryPredicate)
        if !currentSearchText.isEmpty {
            let namePredicate = NSPredicate(format: "name CONTAINS[c] %@", currentSearchText)
            subPredicates.append(namePredicate)
        }
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates)

        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            showAlert(alertText: error.localizedDescription)
        }
    }
    
    /// Setup the `NSDiffableDataSourceSnapshot` which displays the current state of the UI.
    private func setupSnapshot() {
        diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Transaction>()
        diffableDataSourceSnapshot.appendSections([0])
        diffableDataSourceSnapshot.appendItems(fetchedResultsController.fetchedObjects ?? [])
        
        DispatchQueue.main.async {
            self.diffableDataSource?.apply(self.diffableDataSourceSnapshot, animatingDifferences: true)
        }
    }
    
    /// Setup the `UITableViewDiffableDataSource` with a cell provider that sets up the default table view cell
    private func setupDiffableDataSource() {
        diffableDataSource = DataSource(tableView: tableView) { (tableView, indexPath, transaction) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionsTableViewCell
    
            //Gradient
            cell.gradientLayer?.removeFromSuperlayer()
            guard let startColor = UIColor(hex: transaction.category.gradient.startColor) else { return cell }
            guard let endColor = UIColor(hex: transaction.category.gradient.endColor) else { return cell }
            cell.gradientLayer = cell.imageBackground.applyGradient(colours: [startColor, endColor])
            
            //Image
            let imageName = transaction.category.categoryImage.name
            cell.categoryImageView.image = nil
            if let systemImage = UIImage(systemName: imageName){
                cell.categoryImageView.image = systemImage
            } else if let image = UIImage(named: imageName) {
                cell.categoryImageView.image = image.withRenderingMode(.alwaysTemplate)
            }

            //Title
            cell.titleLabel.text = transaction.name
            
            //Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            cell.dateLabel.text = "\(dateFormatter.string(from: transaction.date))"
            
            //Sum
            cell.sumLabel.text = String(format: self.appSettings.roundedFormat, transaction.amount)
            
            cell.isExpense = transaction.isExpense
            return cell
        }
        setupSnapshot()
    }
    
    private class DataSource: UITableViewDiffableDataSource<Int, Transaction> {
        // editing support
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
    }
    
    /// Create `UISearchController` searches for a corresponding row in tablevev.
    private func createSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        searchController.searchBar.backgroundImage = UIImage()
        guard let searchTextField: UITextField = searchController.searchBar.value(forKey: "searchField") as? UITextField else { return }
        guard let imageView = searchTextField.leftView as? UIImageView else { return }
        searchTextField.textColor = .black
        
        let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search".localized, attributes: attributeDict)
        
        imageView.tintColor = UIColor.gray
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        searchController.searchBar.searchTextField.backgroundColor = .white
    }
    
    /// Register reusable cell for `tableView`. Assigning a delegate.
    private func configureTableView() {
        let nib = UINib(nibName: "TransactionsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "transactionCell")
        tableView.delegate = self
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension CategoryElementsViewController: NSFetchedResultsControllerDelegate {
    ///Responsible for reacting to changes in `Category` in the CoreData
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let transaction = anObject as? Transaction else { return }
            diffableDataSourceSnapshot.appendItems([transaction])
            setupSnapshot()
        case .update:
            setupSnapshot()
            tableView.reloadData()
        case .move:
            setupSnapshot()
        case .delete:break
        default: break
        }
    }
}

//MARK: - UITableViewDelegate
extension CategoryElementsViewController {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit".localized) { (_, _, completionHandler) in

            guard let transaction = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
            let storyboard = UIStoryboard(name: "SelectingTypeOfTransactionViewController", bundle: nil)
            guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else { return }
            guard let addingViewController = navController.topViewController as? SelectingTypeOfTransactionViewController else { return }
            addingViewController.transaction = transaction
            self.navigationController?.present(navController, animated: true, completion: nil)
            completionHandler(true)
        }
        editAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        editAction.image = UIImage(systemName: "square.and.pencil")

        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized) { (_, _, completionHandler) in
            guard let transaction = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
            self.balance.totalBalance = transaction.isExpense ? self.balance.totalBalance + transaction.amount : self.balance.totalBalance - transaction.amount
            self.context.delete(transaction)
            try? self.context.save()
            self.setupSnapshot()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - UISearchResultsUpdating
extension CategoryElementsViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        currentSearchText = text
        setupFetchedResultsController()
        setupSnapshot()
    }
}
