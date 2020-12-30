//
//  SettingsViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 23.12.2020.
//

import UIKit

final class SettingsViewController: UITableViewController {
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "settingsTableViewCell")
    }
}

// MARK: - Table view data source
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor(named: "backgroundColor")
        cell.accessoryType = .disclosureIndicator
        if indexPath.row == 0 {
            cell.textLabel?.text = "Passcode".localized
        } else {
            cell.textLabel?.text = "Appearance".localized
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "ConfigurePasscode", bundle: nil)
            guard let controller = storyboard.instantiateInitialViewController() else { return }
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Appearance", bundle: nil)
            guard let controller = storyboard.instantiateInitialViewController() else { return }
            navigationController?.pushViewController(controller, animated: true)
        }
        
    }
}
