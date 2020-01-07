//
//  JobTableViewCell.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class JobTableViewCell: TableViewCell {
	
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var salaryLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		
	}
	
	// MARK: - Public
	func config(name: String, salary: Int?) {
		let salaryValue = salary.map { "\($0)" } ?? "-"
		
		nameLabel.text = name
		salaryLabel.text = "Заплата: \(salaryValue)"
	}
}

// MARK: - Custom configs
extension JobTableViewCell {
	func config(job: Job) {
		config(
			name: job.name,
			salary: job.salary
		)
	}
}
