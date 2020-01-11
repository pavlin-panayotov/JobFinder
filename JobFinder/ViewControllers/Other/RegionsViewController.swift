//
//  RegionsViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class RegionsViewController: TableViewController {
	
	private var regions: [Region] {
		return DataManager.shared.regions
	}
	
	override init() {
		super.init()
		
		title = "Области"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: RegionTableViewCell.self)
		tableView.rowHeight = RegionTableViewCell.height
		tableView.estimatedRowHeight = RegionTableViewCell.height
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return regions.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as RegionTableViewCell
		
		if let region = regions[safe: indexPath.row] {
			cell.config(region: region)
		}
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let region = regions[safe: indexPath.row] else {
			return
		}
		
		navigationController?.pushViewController(
			RegionViewController(region: region),
			animated: true
		)
	}
}

