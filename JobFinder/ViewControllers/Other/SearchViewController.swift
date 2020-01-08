//
//  SearchViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class SearchViewController: ScrollViewController {
	
	private let textField: UITextField = {
		let textField = UITextField()
		textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
		textField.borderStyle = .line
		textField.placeholder = "Техт за търсене"
		return textField
	}()
	
	private lazy var searchButton: UIButton = {
		let button = UIButton()
		button.heightAnchor.constraint(equalToConstant: 60).isActive = true
		button.setTitle("Търсене", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.setTitleColor(UIColor.systemBlue.highlighted, for: .highlighted)
		button.addTarget(
			self,
			action: #selector(searchButtonTapped),
			for: .touchUpInside
		)
		return button
	}()
	
	private lazy var salaryPickerView: SalaryRangePickerView = {
		let pickerView = SalaryRangePickerView()
		pickerView.config(
			title: "Минимална заплата",
			salaryRange: 0...DataManager.shared.greatestSalary
		)
		return pickerView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = "Търсене"
		scrollSubviewsInsets = UIEdgeInsets(inset: 20)
		
		addScrollSubviews(
			textField,
			salaryPickerView,
			searchButton
		)
	}
	
	// MARK: - Actions
	@objc
	private func searchButtonTapped(_ sender: Any) {
		let filter = Filter(
			text: textField.text,
			minimumSalary: salaryPickerView.minimumSalary
		)
		let results = DataManager.shared.jobs(forFilter: filter)
		
		navigationController?.pushViewController(
			SearchResultsViewController(jobs: results),
			animated: true
		)
	}
}
