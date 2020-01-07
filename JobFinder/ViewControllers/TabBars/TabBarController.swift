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
			createRegionsController(),
			createViewController(tag: 1),
			createAboutUsController()
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
	
	private func createRegionsController() -> UIViewController {
		let navigationController = NavigationController(
			rootViewController: RegionsViewController()
		)
		navigationController.tabBarItem = UITabBarItem(
			tabBarSystemItem: .favorites,
			tag: 0
		)
		return navigationController
	}
	
	private func createAboutUsController() -> UIViewController {
		let navigationController = NavigationController(
			rootViewController: AboutUsViewController()
		)
		navigationController.tabBarItem = UITabBarItem(
			tabBarSystemItem: .favorites,
			tag: 2
		)
		return navigationController
	}
}
