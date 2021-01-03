//
//  RoundingTableViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.01.2021.
//

import UIKit

final class RoundingTableViewController: UITableViewController {

    private var appSettings = AppSettings.shared
    private let roundedList = ["%.0f", "%.1f", "%.2f", "%.3f", "%.4f"]
    
    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            guard let index = self.roundedList.firstIndex(of: self.appSettings.roundedFormat) else { return }
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Colors.backgroundColor
    }
}

extension RoundingTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roundedList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = Colors.backgroundColor
        cell.selectionStyle = .none
        cell.tintColor = .label
        let number = 123.12345
        cell.textLabel?.text = String(format: roundedList[indexPath.row], number)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appSettings.roundedFormat = roundedList[indexPath.row]
        navigationController?.popViewController(animated: true)
    }
}
