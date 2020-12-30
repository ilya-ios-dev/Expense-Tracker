//
//  TabBarViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    //MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let startColor: UIColor = UIColor(hex: UserDefaults.standard.string(forKey: "startColor") ?? "") ?? #colorLiteral(red: 0.5490196078, green: 0.2980392157, blue: 0.831372549, alpha: 1)
        let endColor: UIColor = UIColor(hex: UserDefaults.standard.string(forKey: "endColor") ?? "") ?? #colorLiteral(red: 0.3450980392, green: 0.2117647059, blue: 0.7333333333, alpha: 1)
        tabBar.tintColor = [startColor, endColor].averageColor()
        guard let interfaceStyle = UIUserInterfaceStyle(rawValue: UserDefaults.standard.integer(forKey: "UIUserInterfaceStyle")) else { return }
        overrideUserInterfaceStyle = interfaceStyle
    }
    
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
