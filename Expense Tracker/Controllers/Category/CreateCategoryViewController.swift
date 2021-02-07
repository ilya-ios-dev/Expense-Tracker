//
//  CreateCategoryViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 11.12.2020.
//

import UIKit
import CoreData

final class CreateCategoryViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var gradientCollectionView: UICollectionView!
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    @IBOutlet private weak var saveBarButtonItem: UIBarButtonItem!
    
    //MARK: - Properties
    public var category: Category?
    
    private var gradients = [Gradient]()
    private var images = [CategoryImage]()
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = appDelegate.container.viewContext
        return privateContext
    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.viewContext
    }()

    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup Data
        preloadDBData()
        loadGradientsAndImages()
        //Configure UI
        addKeyboardCancelGesture()
        configureColorCollectionView()
        configureImageCollectionView()
        titleTextField.addTarget(self, action: #selector(textFieldValidate(_:)), for: .editingChanged)
        //if editing category
        if category != nil {
            prepareForEditingCategory()
        } else {
            saveBarButtonItem.isEnabled = false
        }
    }
    
    
    //MARK: - Actions
    @IBAction private func saveTapped(_ sender: Any) {
        guard let name = titleTextField.text else { return }
        guard let selectedImageIndexPath = imagesCollectionView.indexPathsForSelectedItems?.first else { return }
        guard let selectedColorIndexPath = gradientCollectionView.indexPathsForSelectedItems?.first else { return }
        let image = images[selectedImageIndexPath.item]
        let gradient = gradients[selectedColorIndexPath.item]
        
        //if editing category
        if let category = category {
            category.name = name
            category.categoryImage = image
            category.gradient = gradient
        } else {
            Category.create(in: context, name: name, categoryImage: image, gradient: gradient)
        }
        
        do {
            try context.save()
            saveOnMainContext()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            showAlert(alertText: "\(error.localizedDescription)")
        }
    }
}

//MARK: - Supporting Methods
extension CreateCategoryViewController {
    /// Prepares views for editing a category.
    private func prepareForEditingCategory() {
        category = try! context.existingObject(with: category!.objectID) as? Category
        titleTextField.text = category?.name
        
        guard let gradientIndex = gradients.firstIndex(of: category!.gradient) else { return }
        let gradientIndexPath = IndexPath(item: gradientIndex, section: 0)
        gradientCollectionView.selectItem(at: gradientIndexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)

        guard let imageIndex = images.firstIndex(of: category!.categoryImage) else { return }
        let imageIndexPath = IndexPath(item: imageIndex, section: 0)
        imagesCollectionView.selectItem(at: imageIndexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
    
    ///Add `UITapGestureRecognizer` to tapping anywhere on the view controller to dismiss the keyboard.
    private func addKeyboardCancelGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Saving all changes on main context
    private func saveOnMainContext() {
        context.performAndWait {
            do {
                try mainContext.save()
            } catch {
                print(error)
                showAlert(alertText: error.localizedDescription)
            }
        }
    }

    ///Activates the save button if  `UITextField` are not empty.
    @objc private func textFieldValidate(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            saveBarButtonItem.isEnabled = false
        } else {
            saveBarButtonItem.isEnabled = true
        }
    }
    
    /// Register cell for `gradientCollectionView`.
    /// Setting DataSource and Delegate.
    /// Select First Item if not selected.
    private func configureColorCollectionView() {
        let nib = UINib(nibName: "GradientCategoryCollectionViewCell", bundle: nil)
        gradientCollectionView.register(nib, forCellWithReuseIdentifier: "colorCell")
        gradientCollectionView.delegate = self
        gradientCollectionView.dataSource = self
        let indexPath = IndexPath(item: 0, section: 0)
        gradientCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
    
    /// Register cell for `imagesCollectionView`.
    /// Setting DataSource and Delegate.
    /// Select First Item if not selected.
    private func configureImageCollectionView() {
        let nib = UINib(nibName: "CategoryImageCollectionViewCell", bundle: nil)
        imagesCollectionView.register(nib, forCellWithReuseIdentifier: "imageCell")
        imagesCollectionView.collectionViewLayout = configureLayout()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        let indexPath = IndexPath(item: 0, section: 0)
        imagesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
    }
    
    /// creates a UICollectionViewCompositionalLayout, which is responsible for placing cells.
    private func configureLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .absolute(96))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(96),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
        
    /// Loads data for `gradients` and `images`
    private func loadGradientsAndImages() {
        let gradientRequest: NSFetchRequest = Gradient.fetchRequest()
        gradients = try! context.fetch(gradientRequest)
        
        // Sort by color 
        gradients.sort { (gradient1, gradient2) -> Bool in
            guard let number1Start = UInt8(gradient1.startColor, radix: 16),
                  let number1End = UInt8(gradient1.endColor, radix: 16),
                  let number2Start = UInt8(gradient2.startColor, radix: 16),
                  let number2End = UInt8(gradient2.endColor, radix: 16)  else { return false }
            return (number1Start + number1End) < (number2Start + number2End)
        }
        
        let imageRequest: NSFetchRequest = CategoryImage.fetchRequest()
        images = try! context.fetch(imageRequest)
    }
    
    /// Checks if data is loaded into CoreData.
    /// If the data is not loaded, then it loads it.
    private func preloadDBData() {
        if UserDefaults.standard.bool(forKey: "create_category.preload") == false {
            loadGradients()
            loadImages()
            UserDefaults.standard.set(true, forKey: "create_category.preload")
        }
    }
    
    /// Loads a list of gradients from `images.csv` to CoreData.
    private func loadImages() {
        guard let filePath = Bundle.main.path(forResource: "Images", ofType: "csv") else { return }
        guard let str = try? String.init(contentsOfFile: filePath, encoding: .utf8) else { return }
        let images = parseImages(csvString: str)
        
        for item in images {
            let image = CategoryImage(context: mainContext)
            image.name = item
            try? mainContext.save()
        }
        
    }
    
    /// Splits a String into an array of Strings.
    private func parseImages(csvString: String) -> [String] {
        let lines: [String] = (csvString.components(separatedBy: NSCharacterSet.newlines) as [String])
            .filter{!$0.isEmpty}
        return lines
    }
    
    /// Loads a list of gradients from `gradients.csv` to CoreData.
    private func loadGradients() {
        guard let filePath = Bundle.main.path(forResource: "GradientCategories", ofType: "csv") else { return }
        guard let str = try? String.init(contentsOfFile: filePath, encoding: .utf8) else { return }
        let gradients = parseGradients(csvString: str)
        
        for item in gradients {
            let gradient = Gradient(context: mainContext)
            gradient.startColor = item.startColor
            gradient.endColor = item.endColor
            try? mainContext.save()
        }
    }
    
    /// Splits a String into an array of Tuples.
    private func parseGradients(csvString: String) -> [(startColor: String, endColor: String)] {
        let lines: [String] = (csvString.components(separatedBy: NSCharacterSet.newlines) as [String])
            .filter{!$0.isEmpty}
        
        var gradients = [(startColor: String, endColor: String)]()
        
        lines.forEach { line in
            let gradient = line.split(separator: ";")
            let startColor = String(gradient[0])
            let endColor = String(gradient[1])
            gradients.append((startColor: startColor, endColor: endColor))
        }
        
        return gradients
    }
}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension CreateCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == gradientCollectionView {
            return gradients.count
        } else {
            return images.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == gradientCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! GradientCategoryCollectionViewCell
            cell.configure(colors: getGradientColors(for: indexPath))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CategoryImageCollectionViewCell
            
            let imageName = images[indexPath.item].name
            guard let selectedIndexPath = gradientCollectionView.indexPathsForSelectedItems?.first else { return cell }
            cell.configure(imageName: imageName, colors: getGradientColors(for: selectedIndexPath))
            return cell
        }
    }
    
    /// Gets the gradient colors for the cell.
    /// - Parameter indexPath: The index of the call whose gradient is needed.
    /// - Returns: The colors used in the call.
    private func getGradientColors(for indexPath: IndexPath) -> [UIColor] {
        let gradient = gradients[indexPath.item]
        guard let startColor = UIColor(hex: gradient.startColor) else { return [] }
        guard let endColor = UIColor(hex: gradient.endColor) else { return [] }
        return [startColor, endColor]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == gradientCollectionView {
            guard let selectedIndexPath = imagesCollectionView.indexPathsForSelectedItems?.first else { return }
            let indexpaths = imagesCollectionView.visibleCells.map { imagesCollectionView.indexPath(for: $0)! }
            imagesCollectionView.deselectItem(at: selectedIndexPath, animated: false)
            imagesCollectionView.reloadItems(at: indexpaths)
            imagesCollectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .centeredVertically)
            
        }
    }
}
