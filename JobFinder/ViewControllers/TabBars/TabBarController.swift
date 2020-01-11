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
			createSearchViewController(),
			createAboutUsController()
		]
	}
	
	// MARK: - Private
	private func createRegionsController() -> UIViewController {
		return NavigationController(
			rootViewController: RegionsViewController()
		)
	}
	
	private func createSearchViewController() -> UIViewController {
		return NavigationController(
			rootViewController: SearchViewController()
		)
	}
	
	private func createAboutUsController() -> UIViewController {
		return NavigationController(
			rootViewController: AboutUsViewController()
		)
	}
}
