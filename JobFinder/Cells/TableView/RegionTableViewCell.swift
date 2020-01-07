//
//  RegionTableViewCell.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class RegionTableViewCell: TableViewCell {
	
	static let height: CGFloat = 44
	
	@IBOutlet private weak var titleLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	// MARK: - Public
	func config(title: String, count: Int) {
		titleLabel.text = "\(title) (\(count))"
	}
}

// MARK: - Custom configs
extension RegionTableViewCell {
	func config(region: Region) {
		config(
			title: region.name,
			count: region.jobs.count
		)
	}
}
