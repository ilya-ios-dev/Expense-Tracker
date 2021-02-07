//
//  SettingsListViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

final class SettingsListViewController: UITableViewController {
    
    //MARK: - Properties
    private let settings = [
        SettingElement(name: "App Settings", storyboardName: "AppSettings"),
        SettingElement(name: "Passcode", storyboardName: "ConfigurePasscode"),
        SettingElement(name: "Appearance", storyboardName: "Appearance")
    ]
    private struct SettingElement {
        let name: String
        let storyboardName: String
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "settingsTableViewCell")
    }
}

// MARK: - Table view data source
extension SettingsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = Colors.backgroundColor
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = settings[indexPath.row].name.localized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboardName = settings[indexPath.row].storyboardName
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        navigationController?.pushViewController(controller, animated: true)
    }
}
