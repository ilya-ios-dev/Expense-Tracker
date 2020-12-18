//
//  TabBarViewController.swift
//  Expense Tracker
//
//  Created by isEmpty on 18.12.2020.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let index = viewControllers!.count / 2
        viewControllers?.insert(UIViewController(), at: index)
        configureCenterButton()
    }
    
    /// Configure a center button.
    private func configureCenterButton() {
        let centerButton = UIButton(type: .custom)
        centerButton.backgroundColor = UIColor(named: "TopGradientStart")
        centerButton.setImage(UIImage(systemName: "plus"), for: .normal)
        centerButton.tintColor = .white
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(centerButton)
        NSLayoutConstraint.activate([
            centerButton.heightAnchor.constraint(equalToConstant: tabBar.frame.height * 1.2),
            centerButton.widthAnchor.constraint(equalTo: centerButton.heightAnchor),
            centerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centerButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
        
        centerButton.layer.shadowColor = centerButton.backgroundColor?.cgColor
        centerButton.layer.shadowRadius = 8
        centerButton.layer.shadowOpacity = 0.5
        centerButton.layer.shadowOffset = .zero
        centerButton.layer.cornerRadius = tabBar.frame.height * 1.2 / 2
        DispatchQueue.main.async {
            centerButton.layer.shadowPath = UIBezierPath(roundedRect: centerButton.bounds, cornerRadius: centerButton.bounds.height / 2).cgPath
        }

        centerButton.addTarget(self, action: #selector(centerButtonTapped(_:)), for: .touchUpInside)
    }
    
    
    /// Present the add screen by pressing the center button.
    @objc private func centerButtonTapped(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Adding", bundle: nil)
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
            return false
        }
        return true
    }
}
