//
//  SalaryRangePickerView.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 8.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

final class SalaryRangePickerView: NibView {
	
	@IBOutlet private weak var slider: UISlider!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var salaryTextField: UITextField!
	@IBOutlet private weak var contentStackView: UIStackView!
	
	private var sliderRange: ClosedRange<Float> = (0...100)
	
	var minimumSalary: Int {
		return Int(slider.value)
	}
	
	var title: String? {
		get { titleLabel.text }
		set { titleLabel.text = newValue }
	}
	
	var placeholder: String? {
		get { salaryTextField.placeholder }
		set { salaryTextField.placeholder = newValue }
	}
	
	// Default `5`.
	var subviewsSpacing: CGFloat {
		get { contentStackView.spacing }
		set { contentStackView.spacing = newValue }
	}
	
	override func initialSetup() {
		super.initialSetup()
		
		subviewsSpacing = 5
		salaryTextField.keyboardType = .numberPad
		salaryTextField.textAlignment = .right
		salaryTextField.delegate = self
		
		updateSliderValues()
		updateInput()
	}
	
	// MARK: - Actions
	@IBAction private func sliderValueChanged(_ sender: Any) {
		updateInput()
	}
	
	@IBAction func salaryTextFieldEditingChanged(_ sender: Any) {
		guard
			let inputString = salaryTextField.text,
			let inputNumber = Float(inputString) else {
				return
		}
		
		slider.value = min(inputNumber, slider.maximumValue)
	}
	
	// MARK: - Private
	private func updateInput() {
		salaryTextField.text = String(float: slider.value, precision: 0)
	}
	
	private func updateSliderValues() {
		slider.minimumValue = sliderRange.lowerBound
		slider.maximumValue = sliderRange.upperBound
		slider.value = slider.minimumValue
	}
	
	// MARK: - Public
	func config(salaryRange: ClosedRange<Int>) {
		sliderRange = Float(salaryRange.lowerBound)...Float(salaryRange.upperBound)
		
		updateSliderValues()
		updateInput()
	}
}

// MARK: - UITextFieldDelegate
extension SalaryRangePickerView: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateInput()
	}
}
