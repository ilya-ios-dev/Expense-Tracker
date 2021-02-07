//
//  AppSettingsViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.01.2021.
//

import UIKit
import CoreData

final class AppSettingsViewController: UITableViewController {
    
    //MARK: - Properties
    private let appSettings = AppSettings.shared
    private var balance: Balance!
    private var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.container.viewContext
    }()
    private let settingsList = [
        SettingsElement(name: "Currency", description: "Change the currency used in the application.", controller: CurrencyViewController()),
        SettingsElement(name: "Rounding", description: "Change the rounding of numbers.", controller: RoundViewController()),
        SettingsElement(name: "Displaying on Home Screen", description: "Change the items displayed on the home screen.", controller: DisplayingViewController()),
    ]
    private struct SettingsElement {
        let name: String
        let description: String
        let controller: UIViewController
    }
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBalance()
    }
}

//MARK: - Supporting Methods
extension AppSettingsViewController {
    
    ///Gets `balance` from CoreData. If not already created, creates.
    private func fetchBalance() {
        let request: NSFetchRequest = Balance.fetchRequest()
        balance = try? context.fetch(request).first ?? Balance(context: context)
    }
    
    /// Configures the header for the tableView.
    private func configureHeaderStackView(_ view: UIView) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        let label = UILabel()
        label.text = "Change Balance".localized
        label.textColor = UIColor.white
        stackView.addArrangedSubview(label)
        
        let currencyLabel = UILabel()
        currencyLabel.text = appSettings.currency
        currencyLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.text = String(format: appSettings.roundedFormat, balance.totalBalance)
        
        let horizontalStack = UIStackView(arrangedSubviews: [currencyLabel, textField])
        horizontalStack.distribution = .fill
        horizontalStack.alignment = .fill
        horizontalStack.spacing = 5
        stackView.addArrangedSubview(horizontalStack)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension AppSettingsViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let sum = Double(textField.text ?? "") else { return }
        balance.totalBalance = sum
        try? context.save()
    }
}

//MARK: - TableViewDataSource & Delegate
extension AppSettingsViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.backgroundColor
        configureHeaderStackView(view)
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = Colors.backgroundColor
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = settingsList[indexPath.row].name.localized
        cell.detailTextLabel?.text = settingsList[indexPath.row].description.localized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = settingsList[indexPath.row].controller
        navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
