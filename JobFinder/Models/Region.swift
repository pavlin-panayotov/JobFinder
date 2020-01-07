//
//  Region.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class Region {
	
	let id: String
	let name: String
	private(set) var jobs: [Job]
	
	init(id: String, name: String, jobs: [Job] = []) {
		self.id = id
		self.name = name
		self.jobs = jobs
	}
	
	// MARK: - Public
	func add(job: Job) {
		jobs.append(job)
	}
}
