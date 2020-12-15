//
//  AddingViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 02.12.2020.
//

import UIKit
import CoreData

final class AddingViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var sumTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var saveButton: CustomButton!
    
    //MARK: - Properties
    private var balance: Balance!
    private var fetchedResultsController: NSFetchedResultsController<Category>!
    private var dataSource: UICollectionViewDiffableDataSource<String, NSManagedObjectID>!
    
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
        //configure UI
        configureSegmentedControl()
        configureCollectionView()
        sumTextField.addTarget(self, action: #selector(validateTextFields(_:)), for: .editingChanged)
        descriptionTextField.addTarget(self, action: #selector(validateTextFields(_:)), for: .editingChanged)
        
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)], startPoint: .bottomLeft, endPoint: .topRight)
        saveButton.isEnabled = false

        //setup data
        addKeyboardCancelGesture()
        setupDataSource()
        setupFetchedResultsController()
        
        //select first item on CollectionView
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    //MARK: - Actions
    @IBAction func saveTapped(_ sender: Any) {
        guard let amount = Double(sumTextField.text!) else { return }
        guard let name = descriptionTextField.text else { return }
        let isExpense = stateSegmentedControl.selectedSegmentIndex == 0 ? false : true
        guard let selectedItem = collectionView.indexPathsForSelectedItems?.first else { return }
        let category = fetchedResultsController.object(at: selectedItem)
        
        balance.totalBalance = balance.totalBalance - amount
        Transaction.create(in: context, amount: amount, date: datePicker.date, isExpense: isExpense, name: name, balance: balance, category: category)
        do {
            try context.save()
            alert.title = "Успешно сохранено!"
            present(alert, animated: true, completion: nil)
        } catch {
            alert.title = "\(error.localizedDescription)"
            present(alert, animated: true, completion: nil)
        }
    }
    
}

//MARK: - Configure Layouts
extension AddingViewController {
            
    ///Register Cell for `collectionView`
    private func configureCollectionView() {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "categoryCollectionViewCell")
    }
    
    ///Сhange text color for `stateSegmentedControl`
    private func configureSegmentedControl() {
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        stateSegmentedControl.setTitleTextAttributes(titleTextAttributes1, for: .selected)
    }
    
}

//MARK: - Supptorting Methods
extension AddingViewController {
    
    ///Add `UITapGestureRecognizer` to tapping anywhere on the view controller to dismiss the keyboard.
    private func addKeyboardCancelGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    ///Setup the `UICollectionViewDiffableDataSource` which displays the list of `Category`
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<String, NSManagedObjectID>(collectionView: collectionView) { (collectionView, indexPath, objectId) -> UICollectionViewCell? in
            guard let category = try? self.context.existingObject(with: objectId) as? Category else { return nil }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            guard let gradient = category.gradient else { return cell }
            guard let startColor = UIColor(hex: gradient.startColor!) else { return cell }
            guard let endColor = UIColor(hex: gradient.endColor!) else { return cell }
            cell.gradientLayer = cell.backgroundCategory.applyGradient(colours: [startColor, endColor])
            
            let imageName = category.categoryImage?.name
            cell.categoryImageView.image = UIImage(systemName: imageName!)
            
            cell.textLabel.text = category.name
            
            return cell
        }
        collectionView.dataSource = dataSource
    }
    
    ///Setup the `NSFetchedResultsController` which gets the data from `Balance` and `Category`
    private func setupFetchedResultsController() {
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let balanceFetchRequest: NSFetchRequest = Balance.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        categoryFetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: categoryFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            let balances = try context.fetch(balanceFetchRequest)
            balance = balances.first ?? Balance(context: context)
        } catch {
            alert.title = "Core Data fetch error"
            present(alert, animated: true, completion: nil)
        }
    }
    
    ///Activates the save button if both `UITextFields` are not empty.
    @objc private func validateTextFields(_ textField: UITextField) {
        guard let sumText = sumTextField.text else { return }
        guard Double(sumText) != nil else { return }
        guard let descriptionText = descriptionTextField.text else { return }
        if (sumText.isEmpty && descriptionText.isEmpty) ||
            (sumText.isEmpty || descriptionText.isEmpty){
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension AddingViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        let remindersSnapshot = snapshot as NSDiffableDataSourceSnapshot<String, NSManagedObjectID>
        dataSource.apply(remindersSnapshot)
    }
}

