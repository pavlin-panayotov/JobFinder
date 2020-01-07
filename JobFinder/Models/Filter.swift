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
	
	// MARK: - Public
	func isJobMatching(_ job: Job) -> Bool {
		if let textUnwrapped = text, job.name.contains(textUnwrapped) == false {
			return false
		}
		
		return true
	}
}
