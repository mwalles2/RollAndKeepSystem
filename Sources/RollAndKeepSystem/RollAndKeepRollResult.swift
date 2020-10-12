//
//  RollAndKeepRollResult.swift
//  
//
//  Created by Micah A. Walles on 4/10/20.
//

import Die
import Foundation
import Roll

struct RollAndKeepRollResult: RollResult {
	private let keep: Int
	private let rollBonus: Int
	private let staticBonus: Int

	private(set) var total: Int
	private(set) var diceResults: [DieResult]

	var diceRolled: String {
		// Will need to update this so that it shows free raises and static addition

		func x(value: Int, description: String?) -> String {
			if value == 0 {
				return ""
			}
			let sign = value > 0 ? "+" : "-"
			let output = " \(sign) \(abs(value))"
			if let description = description {
				return output + " \(description)"
			}
			return output
		}
		let rollBonusDescription = x(value: rollBonus, description: "10k10 bonus")
		let staticBouns = x(value: staticBonus, description: nil)
		return "\(diceResults.count)k\(keep)\(staticBouns)\(rollBonusDescription)"
	}

	var result: String {
		let kept = diceResults.dropLast(diceResults.count - keep).map { $0.result }
		let dropped = diceResults.dropFirst(keep).map { $0.result }
		return "Kept: \(kept.joined(separator: ", "))\nDropped: \(dropped.count > 0 ? dropped.joined(separator: ", ") : "None")"
	}

	init(values: [DieResult], keep: Int, rollBonus: Int, staticBonus: Int) {
		diceResults = values.sorted { $0.total > $1.total }
		total = rollBonus + staticBonus + diceResults.dropLast(diceResults.count - keep).reduce(0) { (result, new) in
			return result + new.total
		}

		self.keep = keep
		self.rollBonus = rollBonus
		self.staticBonus = staticBonus
	}
}
