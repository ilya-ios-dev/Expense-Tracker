//
//  AppearanceViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 26.12.2020.
//

import UIKit
import CoreData

final class AppearanceViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var topView: GradientView!
    @IBOutlet private weak var appearanceCollectionView: UICollectionView!
    @IBOutlet private weak var colorAccentCollectionView: UICollectionView!
    
    //MARK: - Properties
    private var appSettings = AppSettings.shared
    private var gradients = [GradientAccent]()
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.viewContext
    }()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup Data
        preloadDBData()
        loadGradientsCoreData()
        //Configure UI
        configureColorAccentCollectionView()
        configureAppearanceCollectionView()
    }
}

//MARK: - Suppoting Methods
extension AppearanceViewController {
    
    /// Checks if data is loaded into CoreData.
    /// If the data is not loaded, then it loads it.
    private func preloadDBData() {
        if !UserDefaults.standard.bool(forKey: "gradients.preload"){
            loadGradients()
            UserDefaults.standard.set(true, forKey: "gradients.preload")
        }
    }

    /// Load a list of gradients from Core Data
    private func loadGradientsCoreData(){
        let fetchRequest: NSFetchRequest = GradientAccent.fetchRequest()
        gradients = try! context.fetch(fetchRequest)
    }
        
    /// Loads a list of gradients from `gradients.csv` to CoreData.
    private func loadGradients() {
        guard let filePath = Bundle.main.path(forResource: "GradientAccents", ofType: "csv") else { return }
        guard let str = try? String.init(contentsOfFile: filePath, encoding: .utf8) else { return }
        let gradients = parseGradients(csvString: str)
        
        for item in gradients {
            let gradient = GradientAccent(context: context)
            gradient.startColor = item.startColor
            gradient.endColor = item.endColor
            try? context.save()
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

//MARK: - Configure Layouts
extension AppearanceViewController {
    private func configureColorAccentCollectionView(){
        let nib = UINib(nibName: "GradientCategoryCollectionViewCell", bundle: nil)
        colorAccentCollectionView.register(nib, forCellWithReuseIdentifier: "colorCell")
        colorAccentCollectionView.delegate = self
        colorAccentCollectionView.dataSource = self
        if let index = gradients.firstIndex(where: { $0.startColor == appSettings.startColor.toHex && $0.endColor == appSettings.endColor.toHex }) {
            let indexPath = IndexPath(item: index, section: 0)
            colorAccentCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        }
    }
    
    private func configureAppearanceCollectionView(){
        appearanceCollectionView.register(AppearanceCollectionViewCell.self, forCellWithReuseIdentifier: "appear")
        appearanceCollectionView.delegate = self
        appearanceCollectionView.dataSource = self
        let appearanceRaw = appSettings.userInterfaceStyle.rawValue
        let indexPath = IndexPath(item: appearanceRaw, section: 0)
        appearanceCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension AppearanceViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorAccentCollectionView {
            return gradients.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorAccentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! GradientCategoryCollectionViewCell
            let gradient = gradients[indexPath.item]
            guard let startColor = UIColor(hex: gradient.startColor) else { return cell }
            guard let endColor = UIColor(hex: gradient.endColor) else { return cell }
            cell.configure(colors: [startColor, endColor])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appear", for: indexPath) as! AppearanceCollectionViewCell
            if indexPath.item == 0 {
                cell.appearance = .automatic
            } else if indexPath.item == 1 {
                cell.appearance = .light
            } else {
                cell.appearance = .dark
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorAccentCollectionView {
            configureColorAccent(at: indexPath)
        } else {
            configureAppearance(at: indexPath)
        }
    }
    
    /// Checks which appearance is clicked, takes it and saves it.
    private func configureAppearance(at indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            tabBarController?.overrideUserInterfaceStyle = .unspecified
            navigationController?.overrideUserInterfaceStyle = .unspecified
        case 1:
            tabBarController?.overrideUserInterfaceStyle = .light
            navigationController?.overrideUserInterfaceStyle = .light
        default:
            tabBarController?.overrideUserInterfaceStyle = .dark
            navigationController?.overrideUserInterfaceStyle = .dark
        }
        appSettings.userInterfaceStyle = navigationController?.overrideUserInterfaceStyle ?? .unspecified
    }
    
    /// Checks which gradient is clicked, takes it and saves it.
    private func configureColorAccent(at indexPath: IndexPath) {
        let gradient = gradients[indexPath.item]
        guard let startColor = UIColor(hex: gradient.startColor) else { return }
        guard let endColor = UIColor(hex: gradient.endColor) else { return }

        appSettings.startColor = startColor
        appSettings.endColor = endColor
        appearanceCollectionView.reloadData()
        
        tabBarController?.tabBar.tintColor = startColor
        tabBarController?.tabBar.setNeedsDisplay()
        topView.startColor = startColor
        topView.endColor = endColor
        topView.setNeedsDisplay()
    }
}
