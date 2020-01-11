//
//  DateFormatter.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 11.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

struct DateFormatterManager {
	
	static let shared = DateFormatterManager()
	
	let responseDateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter
	}()
	
	let displayDateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.yyyy г."
		return dateFormatter
	}()
}
