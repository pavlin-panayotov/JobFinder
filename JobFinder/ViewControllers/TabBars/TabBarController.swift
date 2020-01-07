//
//  TabBarController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = [
			createViewController(tag: 0),
			createViewController(tag: 1),
			createViewController(tag: 2)
		]
	}
	
	// MARK: - Private
	private func createViewController(tag: Int) -> UIViewController {
		let viewController = UIViewController()
		viewController.view.backgroundColor = .white
		let navigationController = NavigationController(
			rootViewController: viewController
		)
		navigationController.tabBarItem = UITabBarItem(
			tabBarSystemItem: .favorites,
			tag: tag
		)
		return navigationController
	}
}
