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
		case name(title: String, code: String)
		case id(value: String)
		case salary(value: Int?)
		case laborOffice(value: String)
		case region(value: String)
		case municipality(value: String)
		case freePositions(value: Int)
		case workingHoursDuration(value: Int)
		case contractType(value: ContractType)
		case entryInfo(value: String)
		case freeFrom(date: String)
		case expiryDate(value: String)
		
		var data: (title: String, value: String) {
			switch self {
			case let .name(title, code):
				return ("Позиция", "\(code) - \(title)")
			case let .id(value):
				return ("Номер на обявата", value)
			case let .salary(value):
				return ("Заплата", value.map { String($0) } ?? "-")
			case let .laborOffice(value):
				return ("Дирекция \"Бюро по труда\"", value)
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
			case let .entryInfo(value):
				return ("Номер и дата на заявката", "\(value)")
			case let .freeFrom(value):
				return ("Дата, от която работното място е свободно", value)
			case let .expiryDate(value):
				return ("Срок на валидност на заявката", value)
			}
		}
	}
	
	private let job: Job
	private let rows: [Row]
	
	init(job: Job) {
		self.job = job
		rows = [
			.name(title: job.name, code: job.nameCode),
			.id(value: job.id),
			.salary(value: job.salary),
			.laborOffice(value: job.laborOffice),
			.region(value: job.region),
//			.municipality(value: job.municipality),
			.freePositions(value: job.freePositions),
			.workingHoursDuration(value: job.workingHoursDuration),
			.contractType(value: job.contractType),
			.entryInfo(value: job.entryInfo?.formattedString ?? "-"),
			.freeFrom(
				date: DateFormatterManager.shared.displayDateFormatter.string(from: job.freeFromDate)
			),
			.expiryDate(
				value: DateFormatterManager.shared.displayDateFormatter.string(from: job.expiryDate)
			),
		]
		
		super.init()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Описание на позицията"
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Преглед",
			style: .plain,
			target: self,
			action: #selector(openInBrowser)
		)
	}
	
	// MARK: - Overrides
	override func setupTableView() {
		super.setupTableView()
		
		tableView.register(cellType: DetailsTableViewCell.self)
	}
	
	// MARK: - Actions
	@objc
	private func openInBrowser() {
		UIApplication.shared.open(job.url, options: [:], completionHandler: nil)
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
