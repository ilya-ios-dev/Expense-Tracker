//
//  AddingViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 02.12.2020.
//

import UIKit

final class AddingViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var stateSegmentedControl: UISegmentedControl!
    @IBOutlet private weak var sumTextField: UITextField!
    @IBOutlet private weak var currencyPicker: UIPickerView!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var saveButton: UIButton!
    
    //MARK: - Properties
    private let currencyList = ["UAH", "USD", "RUB", "EUR"]
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
        stateSegmentedControl.setTitleTextAttributes(titleTextAttributes1, for: .selected)
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)], startPoint: .bottomLeft, endPoint: .topRight)
        
        configureCollectionView()
        configureSaveButton()
    }
        
}



//MARK: - Layouts

extension AddingViewController {
    
    private func configureSaveButton() {
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        
        let startGradient = CGPoint(x: -0.5, y: 1.5)
        let endGradient = CGPoint(x: 1.5, y: -0.5)
        saveButton.applyGradient(colours: [#colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)], startPoint: .custom(point: startGradient), endPoint: .custom(point: endGradient))

        
        saveButton.layer.shadowColor = saveButton.backgroundColor?.cgColor
        saveButton.layer.shadowOpacity = 0.5
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        saveButton.layer.shadowRadius = 3
        saveButton.layer.shadowPath = UIBezierPath(roundedRect: saveButton.bounds, cornerRadius: saveButton.layer.cornerRadius).cgPath
    }
    
    private func configureCollectionView() {
        let nib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "categoryCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    
}



//MARK: - CollectionViewDataSource & CollectionViewDelegate

extension AddingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        return cell
    }
}



//MARK: - UIPickerViewDataSource

extension AddingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
}
