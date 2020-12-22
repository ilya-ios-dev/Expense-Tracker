//
//  CategoryViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit
import CoreData

final class CategoryViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Properties
    private var fetchedResultsController: NSFetchedResultsController<Category>!
    private var diffableDataSource: UITableViewDiffableDataSource<Int, Category>!
    private var diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Category>()
    private var currentSearchText = ""
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.viewContext
    }()
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        return alert
    }()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure UI
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)], startPoint: .bottomLeft, endPoint: .topRight)
        configureTableView()
        createSearchController()

        //Setup Data
        setupFetchedResultsController()
        setupDiffableDataSource()
    }
}

//MARK: - Supptorting Methods
extension CategoryViewController {
    
    /// Setup the `NSFetchedResultsController` which gets the data from `Category`
    private func setupFetchedResultsController() {
        let request: NSFetchRequest = Category.fetchRequest()
        
        if !currentSearchText.isEmpty {
            request.predicate = NSPredicate(format: "name CONTAINS[c] %@", currentSearchText)
        }
        
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            alert.title = "Fetch failed"
            present(alert, animated: true, completion: nil)
        }
    }
    
    /// Setup the `NSDiffableDataSourceSnapshot` which displays the current state of the UI.
    private func setupSnapshot() {
        diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Category>()
        diffableDataSourceSnapshot.appendSections([0])
        diffableDataSourceSnapshot.appendItems(fetchedResultsController.fetchedObjects ?? [])
        
        DispatchQueue.main.async {
            self.diffableDataSource?.apply(self.diffableDataSourceSnapshot, animatingDifferences: true)
        }
    }
    
    /// Setup the `UITableViewDiffableDataSource` with a cell provider that sets up the default table view cell
    private func setupDiffableDataSource() {
        diffableDataSource = DataSource(tableView: tableView) { (tableView, indexPath, category) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            cell.gradientLayer?.removeFromSuperlayer()
            cell.categoryImage?.image = nil
            
            cell.titleLabel.text = category.name
            cell.categoryImage?.image = UIImage(systemName: category.categoryImage.name)
            
            guard let startColor = UIColor(hex: category.gradient.startColor),
                  let endColor = UIColor(hex: category.gradient.endColor) else { return cell }
            cell.gradientLayer = cell.imageBackgroundView.applyGradient(colours: [startColor, endColor])
            return cell
        }
        setupSnapshot()
    }
    
    private class DataSource: UITableViewDiffableDataSource<Int, Category> {
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
        searchController.searchBar.placeholder = "Search Transiction"
        navigationItem.searchController = searchController
        
        searchController.searchBar.backgroundImage = UIImage()
        guard let searchTextField: UITextField = searchController.searchBar.value(forKey: "searchField") as? UITextField else { return }
        guard let imageView = searchTextField.leftView as? UIImageView else { return }
        searchTextField.textColor = .black
        
        let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributeDict)
        
        imageView.tintColor = UIColor.gray
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        
        searchController.searchBar.searchTextField.backgroundColor = .white
    }
    
    /// Register reusable cell for `tableView`. Assigning a delegate.
    private func configureTableView() {
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "categoryCell")
        tableView.delegate = self
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension CategoryViewController: NSFetchedResultsControllerDelegate {
    ///Responsible for reacting to changes in `Category` in the CoreData
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let category = anObject as? Category else { return }
            diffableDataSourceSnapshot.appendItems([category])
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
extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            
            guard let category = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
            let storyboard = UIStoryboard(name: "CreateCategory", bundle: nil)
            guard let navController = storyboard.instantiateInitialViewController() as? UINavigationController else { return }
            guard let editCategoryViewController = navController.topViewController as? CreateCategoryViewController else { return }
            editCategoryViewController.category = category
            self.navigationController?.present(navController, animated: true, completion: nil)

            completionHandler(true)
        }
        editAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        editAction.image = UIImage(systemName: "square.and.pencil")
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            guard let category = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
            self.context.delete(category)
            try? self.context.save()
            self.setupSnapshot()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: - UISearchResultsUpdating
extension CategoryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        currentSearchText = text
        setupFetchedResultsController()
        setupSnapshot()
    }
}
