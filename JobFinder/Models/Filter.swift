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
	let region: String?
	
	// MARK: - Public
	func isJobMatching(_ job: Job) -> Bool {
		if let text = text,
			text.isEmpty == false,
			job.name.contains(text) == false {
			
			return false
		}
		
		if minimumSalary > 0 && minimumSalary > (job.salary ?? 0) {
			return false
		}
		
		if let region = region,
			region.isEmpty == false,
			job.region != region {
			
			return false
		}
		
		return true
	}
}
