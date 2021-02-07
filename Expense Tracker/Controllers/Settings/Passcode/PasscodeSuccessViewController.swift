//
//  PasscodeSuccessViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 25.12.2020.
//

import UIKit

final class PasscodeSuccessViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var doneButton: RoundedGradientButton!
    @IBOutlet private weak var passcodeSuccessfullyView: PasscodeSuccessfullyView!
    
    //MARK: - Properties
    public var editingMode: EditPasscodeViewController.EditingMode!
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch editingMode {
        case .create: titleLabel.text = "Passcode successfully created".localized
        case .disable: titleLabel.text = "Passcode successfully disabled".localized
        case .edit: titleLabel.text = "Passcode successfully edited".localized
        case .none: break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.backBarButtonItem?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        passcodeSuccessfullyView.setNeedsDisplay()
    }
    
    //MARK: - Actions
    @IBAction private func doneTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
