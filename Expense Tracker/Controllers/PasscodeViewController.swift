//
//  PinViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

final class PasscodeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var passcodeTextField: PasscodeTextField!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bottomPasscodeConstraint: NSLayoutConstraint!
    
    //MARK: - Properties
    private var userPasscode: String!
    private var gradientLayer : CAGradientLayer?
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = view.applyGradient(colours: [#colorLiteral(red: 0.4509803922, green: 0.2588235294, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.537254902, green: 0.2941176471, blue: 0.8274509804, alpha: 1)], startPoint: .topRight, endPoint: .bottomLeft)
        getPasscode()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        gradientLayer?.removeFromSuperlayer()
        DispatchQueue.main.async {
            self.gradientLayer = self.view.applyGradient(colours: [#colorLiteral(red: 0.4509803922, green: 0.2588235294, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0.537254902, green: 0.2941176471, blue: 0.8274509804, alpha: 1)], startPoint: .topRight, endPoint: .bottomLeft)
        }
    }
    
    //MARK: - Actions
    @IBAction func pinEndEditing(_ sender: Any) {
        if userPasscode == passcodeTextField.text {
            correctPasscode()
        } else {
            incorrectPasscode()
        }
    }
}

//MARK: - Supporting Methods
extension PasscodeViewController {
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomPasscodeConstraint.constant = keyboardSize.height + 10
        }
    }

    /// Clears the `passcodeTextField` and tells the user that an invalid password was entered.
    private func incorrectPasscode() {
        self.descriptionLabel.text = "You entered an incorrect password. Please try to fill in again."
        UIView.animate(withDuration: 0.5) {
            self.passcodeTextField.clear()
            self.passcodeTextField.shake()
        }
    }

    /// Closes the `PasscodeViewController`. Makes the `TabBarViewController` as a rootViewController.
    private func correctPasscode() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateInitialViewController() as? TabBarViewController {
            guard let window = UIApplication.shared.windows.first else { fatalError() }
            
            self.view.window!.layer.add(dismissAnimation(), forKey: nil)
            window.rootViewController = tabBarController
        }
    }
    
    /// Creates a `CATransition` for the disappearing `ViewController`.
    private func dismissAnimation() -> CATransition {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromTop
        return transition
    }
    
    /// Get password from secureStore.
    private func getPasscode(){
        let genericPwdQueryable = GenericPasswordQueryable(service: "LaunchingPasscode")
        let store = SecureStore(secureStoreQueryable: genericPwdQueryable)
        do {
            userPasscode = try store.getValue(for: "passcode")
        } catch {
            showAlert(alertText: error.localizedDescription)
        }
    }
}
