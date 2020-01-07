//
//  DataManager.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

final class DataManager {
	
	static let shared = DataManager()
	
	private var jobs: [Job] = []
	private(set) var regions: [Region] = []
	
	init() {
		loadData()
	}
	
	// MARK: - Private
	private func loadData() {
		guard
			let path = Bundle.main.path(forResource: "jobs", ofType: "json"),
			let jsonString = try? String(contentsOfFile: path, encoding: .utf8),
			let jsonData = jsonString.data(using: .utf8),
			let json = try? JSONSerialization.jsonObject(with: jsonData) as? JSON,
			let jobVacancies = json["JobVacancies"] as? [JSON],
			let jobs = jobVacancies.first?["JobVacancy"] as? [JSON]
			else {
				return
		}
		
		self.jobs = jobs.compactMap { Job(data: $0) }
		self.jobs.forEach { (job) in
			if let region = regions.first(where: { $0.id == job.regionId }) {
				region.add(job: job)
				return
			}
			
			let region = Region(
				id: job.regionId,
				name: job.region,
				jobs: [job]
			)
			regions.append(region)
		}
		regions.sort(by: { $0.name < $1.name })
	}
	
	// MARK: - Public
	func jobs(forFilter filter: Filter) -> [Job] {
		return jobs.filter(filter.isJobMatching)
	}
}
