//
//  RegionViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class RegionViewController: TableViewController {
	
	private let region: Region
	
	init(region: Region) {
		self.region = region
		
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = region.name
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: JobTableViewCell.self)
	}
	
	// MARK: - UITableViewDataSource
	override func tableView(
		_ tableView: UITableView,
		numberOfRowsInSection section: Int) -> Int {
		
		return region.jobs.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as JobTableViewCell
		
		if let job = region.jobs[safe: indexPath.row] {
			cell.config(job: job)
		}
		
		return cell
	}
	
	// MARK: - UITableViewDelegate
	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		guard let job = region.jobs[safe: indexPath.row] else {
			return
		}
		
		
	}
}
