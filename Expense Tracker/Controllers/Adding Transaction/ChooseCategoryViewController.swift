//
//  ChooseCategoryViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit
import CoreData

final class ChooseCategoryViewController: UIViewController {
    
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
    private var fetchedResultsController: NSFetchedResultsController<Category>!
    private var dataSource: UICollectionViewDiffableDataSource<String, NSManagedObjectID>!
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.privateContext
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
        transactionCategoryEmpty.addDashedCircle(strokeColor: .darkGray, fillColor: #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9411764706, alpha: 1), lineWidth: 1)
        //Setup Data
        setupDataSource()
        setupFetchedResultsController()
    }
}

//MARK: - Supporting Methods
extension ChooseCategoryViewController {
    ///Setup the `UICollectionViewDiffableDataSource` which displays the list of `Category`
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, NSManagedObjectID>(collectionView: collectionView) { (collectionView, indexPath, objectId) -> UICollectionViewCell? in
            guard let category = try? self.context.existingObject(with: objectId) as? Category else { return nil }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            cell.gradientLayer?.removeFromSuperlayer()
            guard let startColor = UIColor(hex: category.gradient.startColor) else { return cell }
            guard let endColor = UIColor(hex: category.gradient.endColor) else { return cell }
            cell.gradientLayer = cell.backgroundCategory.applyGradient(colours: [startColor, endColor])
            
            let imageName = category.categoryImage.name
            cell.categoryImageView.image = UIImage(systemName: imageName)
            
            cell.textLabel.text = category.name
            
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
            print("\(error)")
        }
    }
}

//MARK: - Configure Layouts
extension ChooseCategoryViewController {
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
            transactionIconBackground.backgroundColor = UIColor(named: "TopGradientStart")
            transactionTypeLabel.text = "Expense"
        } else {
            transactionIconLabel.text = ">|"
            transactionIconBackground.backgroundColor = UIColor(named: "TopGradientEnd")
            transactionTypeLabel.text = "Income"
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
extension ChooseCategoryViewController: NSFetchedResultsControllerDelegate {
    /// Receives data change notifications. Passes them to `dataSource`.
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let categorySnapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
        dataSource.apply(categorySnapshot)
    }
}

//MARK: - UICollectionViewDelegate
extension ChooseCategoryViewController: UICollectionViewDelegate {
    /// Adds data to `transaction` and passes it to the next `UIViewController`.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let objectId = dataSource.itemIdentifier(for: indexPath) else { return }
        guard let category = try? self.context.existingObject(with: objectId) as? Category else { return }
        let storyboard = UIStoryboard(name: "ChooseDateViewController", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? ChooseDateViewController else { return }
        transaction.category = category
        controller.transaction = transaction
        navigationController?.pushViewController(controller, animated: true)
    }
}
