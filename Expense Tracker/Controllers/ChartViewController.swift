//
//  ChartViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 03.12.2020.
//

import UIKit

final class ChartViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var chartView: ChartView!
    @IBOutlet private var statisticsViews: [UIView]! {
        didSet {
            statisticsViews.forEach { (view) in
                view.layer.cornerRadius = 9
            }
        }
    }
    @IBOutlet private var roundedBackgrounds: [UIView]! {
        didSet {
            roundedBackgrounds.forEach { (view) in
                view.layer.cornerRadius = view.frame.height / 2
            }
        }
    }
    @IBOutlet private weak var expenseLabel: UILabel!
    @IBOutlet private weak var incomeLabel: UILabel!
    
    
    //MARK: - Properties
    private let chartModel = ChartModel(
        balance: "$2945.24",
        points: [
            GraphModel(progress: 0, step: 1),
            GraphModel(progress: 1, step: 2),
            GraphModel(progress: 0, step: 3),
            GraphModel(progress: 2, step: 4),
            GraphModel(progress: 1, step: 5),
            GraphModel(progress: 2, step: 6),
            GraphModel(progress: 0, step: 7),
            GraphModel(progress: 2, step: 8),
            GraphModel(progress: 4, step: 9),
            GraphModel(progress: 3, step: 11),
            GraphModel(progress: 3, step: 12),
            GraphModel(progress: 3, step: 13)
        ])
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        chartView.chartModel = chartModel
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = false
        let nib = UINib(nibName: "MonthCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "monthCell")
    }
}



//MARK: - UICollectionViewDataSource

extension ChartViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 200
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as! MonthCollectionViewCell
        return cell
    }
}
