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
	@IBOutlet private weak var contentStackView: UIStackView!
	
	private var title: String?
	private var sliderRange: ClosedRange<Float> = (0...100)
	
	var minimumSalary: Int {
		return Int(slider.value)
	}
	
	// Default `5`.
	var subviewsSpacing: CGFloat {
		get { contentStackView.spacing }
		set { contentStackView.spacing = newValue }
	}
	
	override func initialSetup() {
		super.initialSetup()
		
		subviewsSpacing = 5
		setupSlider()
		
		updateSliderValues()
		updateTitle()
	}
	
	// MARK: - Actions
	@IBAction private func sliderValueChanged(_ sender: Any) {
		updateTitle()
	}
	
	// MARK: - Private
	private func setupSlider() {
		
	}
	
	private func updateTitle() {
		let sliderValue: String = {
			guard slider.value > 0 else {
				return "-"
			}
			
			return String(float: slider.value, precision: 0)
		}()
		
		titleLabel.text = {
			guard let title = title else {
				return sliderValue
			}
			
			return "\(title): \(sliderValue)"
		}()
	}
	
	private func updateSliderValues() {
		slider.minimumValue = sliderRange.lowerBound
		slider.maximumValue = sliderRange.upperBound
		slider.value = slider.minimumValue
	}
	
	// MARK: - Public
	func config(title: String, salaryRange: ClosedRange<Int>) {
		self.title = title
		sliderRange = Float(salaryRange.lowerBound)...Float(salaryRange.upperBound)
		
		updateSliderValues()
		updateTitle()
	}
}
