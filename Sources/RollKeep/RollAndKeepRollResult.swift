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
	var total: Int

	var diceResults: [DieResult]

	var result: String {
		let kept = diceResults.dropLast(diceResults.count - keep).map { $0.result }
		let dropped = diceResults.dropFirst(keep).map { $0.result }
		return "Kept: \(kept.joined(separator: ", ")), Dropped: \(dropped.joined(separator: ", "))"
	}

	private let keep: Int

	init(values: [DieResult], keep: Int) {
		diceResults = values.sorted { $0.total > $1.total }
		total = diceResults.dropLast(diceResults.count - keep).reduce(0) { (result, new) in
			return result + new.total
		}

		self.keep = keep
	}
}
