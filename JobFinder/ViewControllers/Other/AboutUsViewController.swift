//
//  AboutUsViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class AboutUsViewController: TableViewController {
	
	private enum Row {
		case credits
		case jobsSource
		case version
		
		var title: String {
			switch self {
			case .credits:
				return "Credits"
			case .jobsSource:
				return "Източник на информацията"
			case .version:
				return "Версия"
			}
		}
		
		var value: String? {
			switch self {
			case .credits, .jobsSource:
				return nil
			case .version:
				return "1.0"
			}
		}
	}
	
	private let dataSource: [Row] = [
		.jobsSource,
		.credits,
		.version
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "За нас"
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: DetailsTableViewCell.self)
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return dataSource.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as DetailsTableViewCell
		
		if let row = dataSource[safe: indexPath.row] {
			cell.config(
				title: row.title,
				value: row.value
			)
			
			cell.selectionStyle = {
				switch row {
				case .credits, .jobsSource:
					return .default
				case .version:
					return .none
				}
			}()
		}
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let row = dataSource[safe: indexPath.row] else {
			return
		}
		
		switch row {
		case .credits:
			break
		case .jobsSource:
			UIApplication.shared.open(
				Constant.Url.jobsSource,
				options: [:],
				completionHandler: nil
			)
			
		case .version:
			break
		}
	}
}
