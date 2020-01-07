//
//  DetailsTableViewCell.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 27.12.19.
//  Copyright © 2019 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class DetailsTableViewCell: TableViewCell {
	
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var valueLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		
	}
	
	// MARK: - Public
	func config(title: String?, value: String?) {
		titleLabel.text = title
		valueLabel.text = value
		
		titleLabel.isHidden = titleLabel.text?.isEmpty != false
		valueLabel.isHidden = valueLabel.text?.isEmpty != false
	}
}
