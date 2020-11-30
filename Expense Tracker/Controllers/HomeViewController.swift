//
//  ViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, ExpenseModel>!
    private var snapshot = NSDiffableDataSourceSnapshot<Int, ExpenseModel>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        createSampleData()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {
             (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let spacing: CGFloat = 10
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(83))
            let itemCount = layoutEnvironment.container.effectiveContentSize.width >= 780 ? 2 : 1
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: itemCount)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            section.interGroupSpacing = spacing
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Int, ExpenseModel>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let recentNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
            let cellRegistration =  UICollectionView.CellRegistration<HomeCollectionViewCell, ExpenseModel>(cellNib: recentNib) { (cell, indexPath, identifier) in
                cell.titleLabel.text = item.title
            }
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
    
    private func createSampleData(){
        snapshot.appendSections([0])
        snapshot.appendItems(ExpenseModel.getSampleData(), toSection: 0)
        dataSource.apply(snapshot)
    }
    
}
