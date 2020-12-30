//
//  FillingAmountAndDescriptionViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class FillingAmountAndDescriptionViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var transactionIconLabel: UILabel!
    @IBOutlet private weak var transactionIconBackground: UIView!
    @IBOutlet private weak var transactionTypeLabel: UILabel!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextField!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var bottomTextFieldConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    public var transaction: Transaction!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTransactionType()
        configureAmountTextField()
        configureDescriptionTextField()
        configureNextButton()
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .black

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //MARK: - Actions
    /// Adds data to `transaction` and passes it to the next `UIViewController`.
    @IBAction private func nextTapped(_ sender: Any) {
        guard let amount = Double(amountTextField.text ?? "") else { return }
        guard let name = descriptionTextField.text else { return }
        transaction.amount = amount
        transaction.name = name
        let storyboard = UIStoryboard(name: "ChooseCategoryViewController", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? ChooseCategoryViewController else { return }
        controller.transaction = transaction
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - Supptoring Methods
extension FillingAmountAndDescriptionViewController {
    ///Brings up the `textFields` along with the keyboard.
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomTextFieldConstraint.constant = keyboardSize.height
        }
    }
    
    ///Activates the `nextButton` button if  `descriptionTextField` are not empty
    ///and `amountTextField` can be converted to `Double`.
    @objc private func textFieldValidate(_ textField: UITextField) {
        if descriptionTextField.text != "" &&
            Double(amountTextField.text ?? "") != nil{
            nextButton.backgroundColor = transactionIconBackground.backgroundColor
            nextButton.isEnabled = true
        } else {
            nextButton.backgroundColor = .lightGray
            nextButton.isEnabled = false
        }
    }
}

//MARK: - Configure Layouts
extension FillingAmountAndDescriptionViewController {
    /// Customization of appearance `amountTextField`.
    /// Adding bottomLine to `UITextField`.
    private func configureAmountTextField() {
        let bottomLine = CALayer()
        let amountOrigin = CGPoint(x: 0, y: amountTextField.frame.height)
        bottomLine.frame = CGRect(origin: amountOrigin, size: CGSize(width: amountTextField.frame.width - 20, height: 1))
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        amountTextField.borderStyle = .none
        amountTextField.layer.addSublayer(bottomLine)
        amountTextField.delegate = self
        amountTextField.becomeFirstResponder()
        amountTextField.text = transaction.amount.isZero ? "" : "\(transaction.amount)"
        amountTextField.addTarget(self, action: #selector(textFieldValidate(_:)), for: .editingChanged)
    }
    
    /// Customization of appearance `descriptionTextField`.
    /// Adding bottomLine to `UITextField`.
    private func configureDescriptionTextField() {
        let bottomLine = CALayer()
        let descOrigin = CGPoint(x: 0, y: descriptionTextField.frame.height)
        bottomLine.frame = CGRect(origin: descOrigin, size: CGSize(width: descriptionTextField.frame.width - 20, height: 1))
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        descriptionTextField.borderStyle = .none
        descriptionTextField.layer.addSublayer(bottomLine)
        descriptionTextField.delegate = self
        descriptionTextField.text = String(transaction.name)
        descriptionTextField.addTarget(self, action: #selector(textFieldValidate(_:)), for: .editingChanged)
    }
    
    /// Customization of appearance `nextButton`.
    private func configureNextButton(){
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.setTitle(String(), for: .normal)
        nextButton.setImage(UIImage(systemName: "greaterthan"), for: .normal)
        nextButton.tintColor = .white
        nextButton.isEnabled = false
        nextButton.backgroundColor = UIColor.lightGray
    }
        
    /// Changes the appearance of items depending on the type of `transaction`.
    private func configureTransactionType() {
        if transaction.isExpense {
            transactionIconLabel.text = "|<"
            let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
            transactionIconBackground.backgroundColor = startColor
            transactionTypeLabel.text = "Expense".localized
        } else {
            transactionIconLabel.text = ">|"
            let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
            transactionIconBackground.backgroundColor = endColor
            transactionTypeLabel.text = "Income".localized
        }
        transactionIconBackground.layer.cornerRadius = transactionIconBackground.frame.height / 2
    }
    
}

//MARK: - UITextFieldDelegate
extension FillingAmountAndDescriptionViewController: UITextFieldDelegate {
    /// Hears both `textFields`.
    /// Pressing `return` on `amountTextField` places the focus on `descriptionTextField`.
    /// When you press `return` on `descriptionTextField`,
    /// it is checked whether the button for switching to a new screen is available, if true, then the transition is called.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == amountTextField {
            descriptionTextField.becomeFirstResponder()
            return false
        } else {
            guard nextButton.isEnabled else { return false }
            nextTapped(self)
            return true
        }
    }
}
