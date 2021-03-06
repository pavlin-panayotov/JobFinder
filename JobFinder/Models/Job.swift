//
//  Job.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

struct Job {
	
	struct EntryInfo {
		let entryDate: Date
		let entryNumber: String
		
		private var formattedEntryDate: String {
			return DateFormatterManager.shared.displayDateFormatter.string(from: entryDate)
		}
		
		var formattedString: String {
			return "\(entryNumber) - \(formattedEntryDate)"
		}
		
		init?(data: JSON) {
			guard
				let entryDateString = Job.getStringValue(for: "vhdate", from: data),
				let entryDate = DateFormatterManager.shared.responseDateFormatter.date(from: entryDateString),
				let entryNumber = Job.getStringValue(for: "vhn", from: data)
				else {
					return nil
			}
			
			self.entryDate = entryDate
			self.entryNumber = entryNumber
		}
	}
	
	let id: String
	let name: String
	let nameCode: String
	let freePositions: Int
	let salary: Int?
	let workingHoursDuration: Int
	let url: URL
	let contractType: ContractType
	
	let entryInfo: EntryInfo?
	let expiryDate: Date
	let freeFromDate: Date
	
	let laborOffice: String
	let laborOfficeCode: String
	let region: String
	let regionId: String
	let municipality: String
	let municipalityId: String
	
	init?(data: JSON) {
		guard
			let id = Self.getStringValue(for: "id", from: data),
			let name = Self.getStringValue(for: "nkpdname", from: data),
			let nameCode = Self.getStringValue(for: "nkpd", from: data),
			let freePositions = Self.getIntValue(for: "freepositions", from: data),
			let workingHoursDuration = Self.getIntValue(for: "workhoursduration", from: data),
			let urlString = Self.getStringValue(for: "url", from: data),
			let url = URL(string: urlString),
			let contractTypeString = Self.getStringValue(for: "contracttype", from: data),
			let contractType = ContractType(rawValue: contractTypeString.lowercased()),
			let expiryDateString = Self.getStringValue(for: "expdate", from: data),
			let expiryDate = DateFormatterManager.shared.responseDateFormatter.date(from: expiryDateString),
			let freeFromDateString = Self.getStringValue(for: "freefrom", from: data),
			let freeFromDate = DateFormatterManager.shared.responseDateFormatter.date(from: freeFromDateString),
			let laborOffice = Self.getStringValue(for: "dbtname", from: data),
			let laborOfficeCode = Self.getStringValue(for: "dbtcode", from: data),
			let region = Self.getStringValue(for: "region", from: data),
			let regionId = Self.getStringValue(for: "regionid", from: data),
			let municipality = Self.getStringValue(for: "muni", from: data),
			let municipalityId = Self.getStringValue(for: "muniid", from: data)
			else {
				assert(false, "Value not parsed.")
				return nil
		}
		
		self.id = id
		self.name = name
		self.nameCode = nameCode
		self.freePositions = freePositions
		self.salary = Self.getIntValue(for: "salary", from: data)
		self.workingHoursDuration = workingHoursDuration
		self.url = url
		self.contractType = contractType
		
		self.entryInfo = EntryInfo(data: data)
		self.expiryDate = expiryDate
		self.freeFromDate = freeFromDate
		
		self.laborOffice = laborOffice
		self.laborOfficeCode = laborOfficeCode
		self.region = region
		self.regionId = regionId
		self.municipality = municipality
		self.municipalityId = municipalityId
	}
	
	// MARK: - Static Private
	static private func getStringValue(for key: String, from json: JSON) -> String? {
		guard let array = json[key] as? [JSON] else {
			return nil
		}
		
		return array.first?["_"] as? String
	}
	
	static private func getIntValue(for key: String, from json: JSON) -> Int? {
		guard let stringValue = getStringValue(for: key, from: json) else {
			return nil
		}
		
		return Int(stringValue)
	}
}
