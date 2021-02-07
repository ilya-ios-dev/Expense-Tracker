//
//  TransactionCategoryViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit
import CoreData

final class TransactionCategoryViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var transactionTypeLabel: UILabel!
    @IBOutlet private weak var transactionIconBackground: UIView!
    @IBOutlet private weak var transactionIconLabel: UILabel!
    @IBOutlet private weak var transactionNameLabel: UILabel!
    @IBOutlet private weak var transactionAmountLabel: UILabel!
    @IBOutlet private weak var transactionCategoryEmpty: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    public var transaction: Transaction!
    public var creatingType = CreatingType.none

    private let appSettings = AppSettings.shared
    private var fetchedResultsController: NSFetchedResultsController<Category>!
    private var dataSource: UICollectionViewDiffableDataSource<String, NSManagedObjectID>!
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        return transaction.managedObjectContext!
    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.viewContext
    }()

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Configure UI
        configureCollectionView()
        configureTransactionType()
        configureTransactionNameAndAmount()
        transactionCategoryEmpty.backgroundColor = .clear
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black
        let fillColor = Colors.descriptionColor
        transactionCategoryEmpty.addDashedCircle(strokeColor: fillColor, fillColor: fillColor.withAlphaComponent(0.5), lineWidth: 1)
        //Setup Data
        setupDataSource()
        setupFetchedResultsController()
    }
}

//MARK: - Supporting Methods
extension TransactionCategoryViewController {
    ///Setup the `UICollectionViewDiffableDataSource` which displays the list of `Category`
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, NSManagedObjectID>(collectionView: collectionView) { (collectionView, indexPath, objectId) -> UICollectionViewCell? in
            guard let category = try? self.context.existingObject(with: objectId) as? Category else { return nil }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            guard let startColor = UIColor(hex: category.gradient.startColor),
                  let endColor = UIColor(hex: category.gradient.endColor) else { return cell }
            cell.configure(title: category.name, imageName: category.categoryImage.name, colors: [startColor, endColor])
            return cell
        }
        collectionView.dataSource = dataSource
    }
    
    ///Setup the `NSFetchedResultsController` which gets the data from `Category`
    private func setupFetchedResultsController() {
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        categoryFetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: categoryFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            showAlert(alertText: error.localizedDescription)
        }
    }
    
    // Passes the object to another controller along with the edit type
    private func createTapped() {
        let storyboard = UIStoryboard(name: Storyboards.transactionDate, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? TransactionDateViewController else { return }
        controller.transaction = transaction
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // Saves the current object and closes the controller
    private func editTapped() {
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

//MARK: - Configure Layouts
extension TransactionCategoryViewController {
    /// Register `collectionViewCell` and sets a delegate.
    private func configureCollectionView() {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "categoryCollectionViewCell")
        collectionView.delegate = self
    }
    
    /// Changes the appearance of items depending on the type of `transaction`.
    private func configureTransactionType() {
        if transaction.isExpense {
            transactionIconLabel.text = "|<"
            let startColor = appSettings.startColor
            transactionIconBackground.backgroundColor = startColor
            transactionTypeLabel.text = "Expense".localized
        } else {
            transactionIconLabel.text = ">|"
            let endColor = appSettings.endColor
            transactionIconBackground.backgroundColor = endColor
            transactionTypeLabel.text = "Income".localized
        }
        transactionIconBackground.layer.cornerRadius = transactionIconBackground.frame.height / 2
    }

    /// Fills `transactionNameLabel` and `transactionAmountLabel` fields.
    private func configureTransactionNameAndAmount(){
        transactionNameLabel.text = transaction.name
        transactionAmountLabel.text = String(transaction.amount)
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension TransactionCategoryViewController: NSFetchedResultsControllerDelegate {
    /// Receives data change notifications. Passes them to `dataSource`.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let categorySnapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
        dataSource.apply(categorySnapshot)
    }
}

//MARK: - UICollectionViewDelegate
extension TransactionCategoryViewController: UICollectionViewDelegate {
    /// Adds data to `transaction` and passes it to the next `UIViewController`.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let objectId = dataSource.itemIdentifier(for: indexPath) else { return }
        guard let category = try? self.context.existingObject(with: objectId) as? Category else { return }
        transaction.category = category

        switch creatingType {
        case .recreate, .none:
            createTapped()
        case .editing:
            editTapped()
        }
        
    }
}
