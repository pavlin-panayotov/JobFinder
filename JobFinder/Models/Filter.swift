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
	let contractType: ContractType?
	
	// MARK: - Public
	func isJobMatching(_ job: Job) -> Bool {
		if let text = text,
			text.isEmpty == false,
			job.name.range(of: text, options: .caseInsensitive) == nil {
			
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
		
		if let contractType = contractType, job.contractType != contractType {
			return false
		}
		
		return true
	}
}
