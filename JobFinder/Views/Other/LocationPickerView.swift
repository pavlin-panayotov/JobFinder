//
//  LocationPickerView.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 9.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class LocationPickerView: NibView {
	
	@IBOutlet private weak var contentStackView: UIStackView!
	@IBOutlet private weak var regionsDropdown: Dropdown!
	
	var regions: [String] = [] {
		didSet {
			regionsChanged()
		}
	}
	
	var selectedRegion: String? {
		return regionsDropdown.selectedOption
	}
	
	override func initialSetup() {
		super.initialSetup()
		
		setupRegionsDropdown()
	}
	
	// MARK: - Private
	private func setupRegionsDropdown() {
		regionsDropdown.title = "Област"
		regionsDropdown.placeholder = "Избери"
	}
	
	private func regionsChanged() {
		regionsDropdown.options = regions
	}
}
