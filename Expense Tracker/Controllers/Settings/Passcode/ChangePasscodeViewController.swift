//
//  AddPinViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

final class ChangePasscodeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var passcodeTextField: PasscodeTextField!
    @IBOutlet private weak var bottomPasscodeConstraint: NSLayoutConstraint!
    
    
    //MARK: - Properties
    private var passcode = ""
    private var gradientLayer: CAGradientLayer?
    public var editingMode: EditingMode!
    private lazy var _editingMode: EditingMode = {
        return editingMode
    }()
    private var oldPasscode: String {
        let genericPwdQueryable = GenericPasswordQueryable(service: "LaunchingPasscode")
        let store = SecureStore(secureStoreQueryable: genericPwdQueryable)
        return try! store.getValue(for: "passcode") ?? ""
    }
    
    internal enum EditingMode {
        case create
        case edit
        case disable
    }

    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
        let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        gradientLayer = view.applyGradient(colours: [endColor, startColor], startPoint: .bottomLeft, endPoint: .topRight)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        if editingMode == .disable {
            descriptionLabel.isHidden = true
        } else if editingMode == .edit {
            titleLabel.text = "Enter your previous password"
            descriptionLabel.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        gradientLayer?.removeFromSuperlayer()
        DispatchQueue.main.async {
            let startColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
            let endColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
            self.gradientLayer = self.view.applyGradient(colours: [endColor, startColor], startPoint: .topRight, endPoint: .bottomLeft)
        }
    }
    
    //MARK: - Actions
    @IBAction func passcodeDidEndEditing(_ sender: Any) {
        switch _editingMode {
        case .create: createPasscode()
        case .edit: changeOldPasscode()
        case .disable: disablePasscode()
        }
    }
}

//MARK: - Supporting Methods
extension ChangePasscodeViewController {
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomPasscodeConstraint.constant = keyboardSize.height + 10
        }
    }
    
    /// Checks the old passcode. If the user enters it, it gives the opportunity to create a new one.
    private func changeOldPasscode(){
        if passcodeTextField.text != oldPasscode {
            incorrectPasscode()
        } else {
            _editingMode = .create
            prepareForCreatingMode()
        }
    }
    
    /// Shows incorrect animation.
    private func incorrectPasscode() {
        self.descriptionLabel.text = "You entered an incorrect password. Please try to fill in again."
        UIView.transition(with: titleLabel, duration: 0.5, options: .transitionCrossDissolve) {
            self.titleLabel.text = "Enter your PIN code"
        }
        
        UIView.animate(withDuration: 0.5) {
            self.descriptionLabel.isHidden = false
            self.self.view.layoutIfNeeded()
            self.passcodeTextField.clear()
        } completion: { (_) in
            self.passcodeTextField.shake()
        }
    }
    
    /// Prepares view for creating new passcode.
    private func prepareForCreatingMode() {
        UIView.transition(with: titleLabel, duration: 0.5, options: .transitionCrossDissolve) {
            self.titleLabel.text = "Enter new PIN code"
            self.descriptionLabel.text = "You will now be required to enter a password to enter the application."
        }
        
        UIView.animate(withDuration: 0.5) {
            self.descriptionLabel.isHidden = false
            self.self.view.layoutIfNeeded()
            self.passcodeTextField.clear()
        }
    }
    
    /// Does password validation. If everything is correct creates new.
    private func createPasscode() {
        if passcode == "" {
            firstTypePasscode()
        } else if passcode != passcodeTextField.text {
            incorrectPasscode()
            passcode = ""
        } else {
            savePasscode()
        }
    }
    
    /// When creating new passcode, user creates it in two step.
    /// This method prepares the display for password verification.
    private func firstTypePasscode() {
        passcode = passcodeTextField.text
        UIView.transition(with: titleLabel, duration: 0.5, options: .transitionCrossDissolve) {
            self.titleLabel.text = "Confirm pin code"
        }
        
        UIView.animate(withDuration: 0.5) {
            self.descriptionLabel.isHidden = true
            self.self.view.layoutIfNeeded()
            self.passcodeTextField.clear()
        }
    }
    
    /// Called when the password has been successfully created.
    /// Sets `isPasscodeEnabled` true and save passcode to store.
    private func savePasscode() {
        UserDefaults.standard.setValue(true, forKey: "isPasscodeEnabled")
        let genericPwdQueryable = GenericPasswordQueryable(service: "LaunchingPasscode")
        let store = SecureStore(secureStoreQueryable: genericPwdQueryable)
        try? store.setValue(passcode, for: "passcode")
        showSuccess()
    }
    
    /// Does password validation. If everything is correct sets `isPasscodeEnabled` false.
    private func disablePasscode() {
        if passcodeTextField.text != oldPasscode {
            incorrectPasscode()
        } else {
            UserDefaults.standard.setValue(false, forKey: "isPasscodeEnabled")
            showSuccess()
        }
    }
    
    /// Shows `PasscodeSuccessViewController` and gives it `editingMode`.
    private func showSuccess() {
        let storyboard = UIStoryboard(name: "PasscodeSuccessfully", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? PasscodeSuccessViewController else { return }
        controller.editingMode = editingMode
        navigationController?.pushViewController(controller, animated: true)
    }
}
