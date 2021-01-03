//
//  CurrencyTableViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 01.01.2021.
//

import UIKit

final class CurrencyTableViewController: UITableViewController {
    
    //MARK: - Properties
    private var appSettings = AppSettings.shared
    private let currencyList = [
        Currency(symbol: "$", ISO: "USD"),
        Currency(symbol: "₴", ISO: "UAH"),
        Currency(symbol: "₽", ISO: "RUB"),
        Currency(symbol: "€", ISO: "EUR"),
        Currency(symbol: "£", ISO: "GBP")
    ]
    
    private struct Currency {
        let symbol: String
        let ISO: String
    }

    //MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            guard let index = self.currencyList.firstIndex(where: {$0.symbol == self.appSettings.currency}) else { return }
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

//MARK: - TableView DataSource & Delegate
extension CurrencyTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = Colors.backgroundColor
        cell.selectionStyle = .none
        cell.tintColor = .label
        cell.textLabel?.text = currencyList[indexPath.row].ISO
        cell.detailTextLabel?.text = currencyList[indexPath.row].symbol
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appSettings.currency = currencyList[indexPath.row].symbol
        navigationController?.popViewController(animated: true)
    }
}
