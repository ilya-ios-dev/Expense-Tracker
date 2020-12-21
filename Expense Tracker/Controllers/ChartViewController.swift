//
//  ChartViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit
import CoreData

final class ChartViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private weak var expenseView: ExpenseView!
    @IBOutlet private weak var incomeView: IncomeView!
    
    
    //MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Int, Date>!
    private var snapshot = NSDiffableDataSourceSnapshot<Int, Date>()
    private var balance: Balance!
    private var searchDate = Date().startOfMonth
    private var observation: NSKeyValueObservation?
    
    //MARK: - Computed Properties
    private lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return (appDelegate?.container.viewContext)!
    }()

    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Data
        setupBalance()
        setupDataSource()
        setupTransactionsObserver()
        //Configure UI
        configureCollectionView()
    }
}

//MARK: - Setup Data
extension ChartViewController {
    ///Adds an `observation` that monitors changes in `transactions`.
    ///Updates `UI` if `transactions` has changes.
    private func setupTransactionsObserver() {
        observation = balance.observe(\Balance.transactions, options: [.initial, .new ]) { (balance, value) in
            self.configureLabels()
            self.setupSnapshot()
            self.configureChartView()
        }
    }
    
    ///Refresh the data in the `ChartView`.
    private func configureChartView(){
        chartView.chartModel = balance.getTransactionsForMonth(searchDate)
        chartView.currentBalance = "$\(balance.totalBalance)"
    }
    
    ///Gets `balance` from CoreData. If not already created, creates.
    private func setupBalance() {
        let request: NSFetchRequest = Balance.fetchRequest()
        balance = try? context.fetch(request).first ?? Balance(context: context)
    }
    
    /// Setup the `NSDiffableDataSourceSnapshot` which displays the current state of the UI.
    private func setupSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<Int, Date>()
        snapshot.appendSections([0])
        snapshot.appendItems(balance.getMonthList() ?? [])
        
        DispatchQueue.main.async {
            self.dataSource?.apply(self.snapshot, animatingDifferences: true)
        }
    }
    
    /// Setup the `UITableViewDiffableDataSource` with a cell provider that sets up the default `collectionView` cells.
    /// Displays Month List.
    private func setupDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Int, Date>(collectionView: collectionView) {
            (collectionView, indexPath, date) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as! MonthCollectionViewCell
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            cell.monthLabel.text = formatter.string(from: date)
            formatter.dateFormat = "YYYY"
            cell.yearLabel.text = formatter.string(from: date)
            return cell
        }
        setupSnapshot()
    }
}

//MARK: - Configure Layouts
extension ChartViewController {
    
    /// Refresh the data in the expense and income labels.
    private func configureLabels() {
        expenseView.transactionAmountLabel.text = "$\(balance.getExpenseForMonth(searchDate) ?? 0)"
        incomeView.transactionAmountLabel.text = "$\(balance.getIncomeForMonth(searchDate) ?? 0)"
    }
    
    /// Register `collectionView` cell. Assigning a delegate. Select current month.
    private func configureCollectionView() {
        collectionView.delegate = self
        let nib = UINib(nibName: "MonthCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "monthCell")
        
        DispatchQueue.main.async {
            let indexPath = self.dataSource.indexPath(for: self.searchDate)
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ChartViewController: UICollectionViewDelegate {
    ///Updates `chartView` and `expenseLabel` with `incomeLabel` depending on the selected `month`.
    ///Update `searchDate`.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        searchDate = item
        self.configureLabels()
        self.configureChartView()
    }
}
