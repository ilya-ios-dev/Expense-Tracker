//
//  TabBarViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let index = viewControllers!.count / 2
        viewControllers?.insert(UIViewController(), at: index)
    }
        
    /// Present the add screen by pressing the center button.
    private func centerButtonTapped() {
        let storyboard = UIStoryboard(name: "SelectingTypeOfTransactionViewController", bundle: nil)
        guard let controller = storyboard.instantiateInitialViewController() else { return }
        present(controller, animated: true, completion: nil)
    }
    
}

//MARK: - UITabBarControllerDelegate
extension TabBarViewController: UITabBarControllerDelegate {
    /// Checks for the index of pressing.
    /// If pressing the center button, then pressing is ignored.
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let viewControllers = viewControllers else { return true }
        let middleIndex = viewControllers.count / 2
        if viewControllers[middleIndex] == viewController {
            centerButtonTapped()
            return false
        }
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let count = tabBar.items?.count else { return }
        let middleIndex = count / 2
        if tabBar.items?.firstIndex(of: item) == middleIndex {
            centerButtonTapped()
        }
    }
}
