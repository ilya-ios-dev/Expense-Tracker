//
//  CategoryViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.12.2020.
//

import UIKit
import CoreData

final class CategoryViewController: UITableViewController {
    
    //MARK: - Properties
    private var fetchedResultsController: NSFetchedResultsController<Category>!
    private var diffableDataSource: UITableViewDiffableDataSource<Int, Category>!
    private var diffableDataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, Category>()
    private var currentSearchText = ""
    private let appSettings = AppSettings.shared

    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.viewContext
    }()
        
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.overrideUserInterfaceStyle = appSettings.userInterfaceStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure UI
        configureTableView()
        createSearchController()

        //Setup Data
        setupFetchedResultsController()
        setupDiffableDataSource()
    }
    
    //MARK: - Actions
    @IBAction func addCategory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CreateCategory", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        navigationController?.pushViewController(controller, animated: true)
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
            showAlert(alertText: error.localizedDescription)
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
            let imageName = category.categoryImage.name
            if let systemImage = UIImage(systemName: imageName){
                cell.categoryImage?.image = systemImage
            } else if let image = UIImage(named: imageName) {
                cell.categoryImage?.image = image.withRenderingMode(.alwaysTemplate)
            }

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
        navigationItem.searchController = searchController
        
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
extension CategoryViewController {
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit".localized) { (_, _, completionHandler) in
            
            guard let category = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
            let storyboard = UIStoryboard(name: "CreateCategory", bundle: nil)
            guard let controller = storyboard.instantiateInitialViewController() as? CreateCategoryViewController else { return }
            controller.category = category
            self.navigationController?.pushViewController(controller, animated: true)
            completionHandler(true)
        }
        editAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        editAction.image = UIImage(systemName: "square.and.pencil")
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let category = self.diffableDataSource?.itemIdentifier(for: indexPath) else { return }
        let storyboard = UIStoryboard(name: "CategoryElements", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? CategoryElementsViewController else { return }
        controller.category = category
        navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized) { (_, _, completionHandler) in
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
