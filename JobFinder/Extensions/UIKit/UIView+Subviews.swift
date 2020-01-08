//
//  UIView+Subviews.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 8.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import UIKit

extension UIView {
	
	// MARK: - Add
	func addFullSizedSubview(_ view: UIView) {
		addSubview(view)
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(
			view.leadingAnchor.constraint(equalTo: leadingAnchor),
			view.trailingAnchor.constraint(equalTo: trailingAnchor),
			view.bottomAnchor.constraint(equalTo: bottomAnchor),
			view.topAnchor.constraint(equalTo: topAnchor)
		)
	}
	
	// MARK: - Remove
	func removeSubviews() {
		subviews.forEach { $0.removeFromSuperview() }
	}
}
