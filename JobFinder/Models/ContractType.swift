//
//  ContractType.swift
//  JobFinder
//
//  Created by Pavlin Panayotov on 7.01.20.
//  Copyright © 2020 Pavlin Panayotov. All rights reserved.
//

import Foundation

enum ContractType: String, CaseIterable {
	case unlimited = "безсрочен"
	case limited = "срочен"
	case civil = "граждански договор"
	
	var title: String {
		return rawValue
	}
}
