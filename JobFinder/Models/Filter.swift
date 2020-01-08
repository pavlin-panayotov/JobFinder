//
//  Filter.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

struct Filter {
	
	let text: String?
	let minimumSalary: Int
	
	// MARK: - Public
	func isJobMatching(_ job: Job) -> Bool {
		if let textUnwrapped = text,
			textUnwrapped.isEmpty == false,
			job.name.contains(textUnwrapped) == false {
			
			return false
		}
		
		if minimumSalary > 0 && minimumSalary > (job.salary ?? 0) {
			return false
		}
		
		return true
	}
}
