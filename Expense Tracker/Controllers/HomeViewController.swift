//
//  ViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 30.11.2020.
//

import UIKit

final class HomeViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var currencyLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    @IBOutlet private weak var incomeAmountLabel: UILabel!
    @IBOutlet private weak var expenseAmountLabel: UILabel!
    @IBOutlet private weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewControllerHeight: NSLayoutConstraint!
    
    
    //MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Int, ExpenseModel>!
    private var snapshot = NSDiffableDataSourceSnapshot<Int, ExpenseModel>()
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        collectionView.collectionViewLayout = createLayout()
        configureDataSource()
        createSampleData()
        collectionView.delegate = self
    }
}



//MARK: - Layouts

extension HomeViewController {
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.setGradientBackground(colors: [#colorLiteral(red: 0.5607843137, green: 0.3058823529, blue: 0.8392156863, alpha: 1), #colorLiteral(red: 0.3176470588, green: 0.2, blue: 0.7176470588, alpha: 1)], startPoint: .bottomLeft, endPoint: .topRight)
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "$ ", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0),
                                                    NSAttributedString.Key.baselineOffset: 2])
        navTitle.append(NSMutableAttributedString(string: "32,465", attributes:[
                                                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))
        navLabel.attributedText = navTitle
        navigationItem.titleView = navLabel
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
}



//MARK: - DataSource

extension HomeViewController {
    
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



//MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){

        // if scrollView bounces off the bottom
        guard !scrollView.isBouncingBottom else { return }
        // if scrollView bounces off the top
        guard !scrollView.isBouncingTop else {
            topViewConstraint.constant = 0
            return
        }
        
        let visibilityHeight: CGFloat = view.frame.height * 0.4
        
        if scrollView.contentOffset.y < visibilityHeight {
            topViewConstraint.constant = scrollView.contentOffset.y * -1
            UIView.animate(withDuration: 0.3) {
                self.navigationController?.navigationBar.alpha = 0
            }
        } else {
            self.navigationController?.navigationBar.isHidden = false
            topViewConstraint.constant = -visibilityHeight
            UIView.animate(withDuration: 0.3) {
                self.navigationController?.navigationBar.alpha = 1
            }
        }
    }
}
