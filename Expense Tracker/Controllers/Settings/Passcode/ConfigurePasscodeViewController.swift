//
//  ConfigurePasscodeViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

final class ConfigurePasscodeViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet private weak var turnOnButton: CustomButton!
    @IBOutlet private weak var turnOffButton: CustomButton!
    @IBOutlet private weak var passcodePictureView: PasscodeWelcomeView!
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureButtons()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        passcodePictureView.setNeedsDisplay()
    }
    
    //MARK: - Actions
    @IBAction private func trurnOnTapped(_ sender: Any) {
        UserDefaults.standard.bool(forKey: "isPasscodeEnabled") ?
            pushViewController(with: .edit) : pushViewController(with: .create)
    }
    
    @IBAction private func turnOffTapped(_ sender: Any) {
        pushViewController(with: .disable)
    }
}

//MARK: - Supporting Methods
extension ConfigurePasscodeViewController {
    
    /// Shows the `ChangePasscodeViewController` with the selected edit mode.
    /// - Parameter editingMode: The edit mode with which the viewController will open.
    private func pushViewController(with editingMode: ChangePasscodeViewController.EditingMode) {
        let storyboard = UIStoryboard(name: "CreatePasscode", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() as? ChangePasscodeViewController else { return }
        controller.editingMode = editingMode
        navigationController?.pushViewController(controller, animated: true)
    }
    
    /// Configures the display of `turnOnButton` and `turnOffButton`.
    /// If passcode is not set, then it will only be possible to enable it.
    /// If the passcode is enabled, it will be possible to edit and disable it.
    private func configureButtons(){
        if UserDefaults.standard.bool(forKey: "isPasscodeEnabled") {
            turnOnButton.setTitle("Change passcode".localized, for: .normal)
        } else {
            turnOffButton.isHidden = true
        }
    }
}
