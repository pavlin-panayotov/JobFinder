//
//  SearchViewController.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class SearchViewController: ScrollViewController {
	
	private let contractTypePicker = Dropdown()
	private let locationPickerView = LocationPickerView()
	
	private lazy var positionNameTextField: UITextField = {
		let textField = UITextField()
		textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
		textField.borderStyle = .roundedRect
		textField.returnKeyType = .done
		textField.delegate = self
		textField.placeholder = "Позиция"
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
		pickerView.title = "Минимална заплата:"
		pickerView.config(salaryRange: 0...DataManager.shared.greatestSalary)
		return pickerView
	}()
	
	private lazy var keyboardBlockingGesture: UITapGestureRecognizer = {
		let tapGestureRecognizer = UITapGestureRecognizer()
		tapGestureRecognizer.addTarget(self, action: #selector(keyboardBlockingViewTapped))
		return tapGestureRecognizer
	}()
	
	private lazy var keyboardBlockingView: UIView = {
		let blockingView = UIView()
		blockingView.addGestureRecognizer(keyboardBlockingGesture)
		return blockingView
	}()
	
	override init() {
		super.init()
		
		title = "Търсене"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollSubviewsInsets = UIEdgeInsets(inset: 20)
		
		setupLocationPickerView()
		setupContractTypeDropdown()
		
		addScrollSubviews(
			positionNameTextField,
			salaryPickerView,
			contractTypePicker,
			locationPickerView,
			searchButton
		)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillShow),
			name: UIViewController.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(keyboardWillHide),
			name: UIViewController.keyboardWillHideNotification,
			object: nil
		)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		NotificationCenter.default.removeObserver(
			self,
			name: UIViewController.keyboardWillShowNotification,
			object: nil
		)
		NotificationCenter.default.removeObserver(
			self,
			name: UIViewController.keyboardWillHideNotification,
			object: nil
		)
	}
	
	// MARK: - Actions
	@objc
	private func searchButtonTapped(_ sender: Any) {
		hideKeyboard()
		
		let filter = Filter(
			text: positionNameTextField.text,
			minimumSalary: salaryPickerView.minimumSalary,
			region: locationPickerView.selectedRegion,
			contractType: ContractType(
				optionalRawValue: contractTypePicker.selectedOption
			)
		)
		let results = DataManager.shared.jobs(forFilter: filter)
		
		navigationController?.pushViewController(
			SearchResultsViewController(jobs: results),
			animated: true
		)
	}
	
	@objc
	private func keyboardBlockingViewTapped(_ sender: Any) {
		hideKeyboard()
	}
	
	// MARK: - Private
	private func setupLocationPickerView() {
		locationPickerView.regions = [""] + DataManager.shared.regions.map { $0.name }
	}
	
	private func setupContractTypeDropdown() {
		contractTypePicker.title = "Тип на договора"
		contractTypePicker.placeholder = "Избери"
		contractTypePicker.options = [""] + ContractType.allCases.map { $0.title }
	}
	
	private func showKeyboardBlockingView() {
		hideKeyboardBlockingView()
		
		view.addFullSizedSubview(
			keyboardBlockingView,
			bottomPadding: scrollView.contentInset.bottom
		)
	}
	
	private func hideKeyboardBlockingView() {
		keyboardBlockingView.removeFromSuperview()
	}
	
	// MARK: - Notifications
	@objc
	private func keyboardWillShow(_ notificaiton: Notification) {
		guard
			let rawKeyboardFrame = notificaiton.userInfo?[UIResponder.keyboardFrameEndUserInfoKey],
			let keyboardFrame = (rawKeyboardFrame as? NSValue)?.cgRectValue
			else {
				return
		}
		
		scrollView.contentInset.bottom = keyboardFrame.height - (tabBarController?.tabBar.bounds.height ?? 0)
		scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
		showKeyboardBlockingView()
	}
	
	@objc
	private func keyboardWillHide(_ notificaiton: Notification) {
		scrollView.contentInset.bottom = 0
		scrollView.verticalScrollIndicatorInsets.bottom = scrollView.contentInset.bottom
		hideKeyboardBlockingView()
	}
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		hideKeyboard()
		return true
	}
}
