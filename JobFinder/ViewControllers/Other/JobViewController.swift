//
//  JobViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class JobViewController: TableViewController {
	
	private enum Row {
		case name(value: String)
		case salary(value: Int?)
		case region(value: String)
		case municipality(value: String)
		case freePositions(value: Int)
		case workingHoursDuration(value: Int)
		case contractType(value: ContractType)
		
		var data: (title: String, value: String) {
			switch self {
			case let .name(value):
				return ("Позиция", value)
			case let .salary(value):
				return ("Заплата", value.map { String($0) } ?? "-")
			case let .region(value):
				return ("Област", value)
			case let .municipality(value):
				return ("Община", value)
			case let .freePositions(value):
				return ("Отворени позиции", String(value))
			case let .workingHoursDuration(value):
				return ("Работни часове", String(value))
			case let .contractType(value):
				return ("Тип на договора", value.title)
			}
		}
	}
	
	private let job: Job
	private let rows: [Row]
	
	init(job: Job) {
		self.job = job
		rows = [
			.name(value: job.name),
			.salary(value: job.salary),
			.region(value: job.region),
			.municipality(value: job.municipality),
			.freePositions(value: job.freePositions),
			.workingHoursDuration(value: job.workingHoursDuration),
			.contractType(value: job.contractType)
		]
		
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Описание на позицията"
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
		
		return rows.count
	}
	
	override func tableView(
		_ tableView: UITableView,
		cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell() as DetailsTableViewCell
		cell.selectionStyle = .none
		
		if let row = rows[safe: indexPath.row] {
			let rowData = row.data
			cell.config(
				title: rowData.title,
				value: rowData.value
			)
		}
		
		return cell
	}
}
