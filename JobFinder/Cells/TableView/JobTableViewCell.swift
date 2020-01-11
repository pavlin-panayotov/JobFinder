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
	@IBOutlet private weak var contentStackView: UIStackView!
	
	// Default `5`.
	var textsSpacing: CGFloat {
		get { contentStackView.spacing }
		set { contentStackView.spacing = newValue }
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		textsSpacing = 5
		nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		salaryLabel.font = UIFont.systemFont(ofSize: 16)
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
