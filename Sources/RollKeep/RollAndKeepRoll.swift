//
//  RollAndKeepRoll.swift
//  
//
//  Created by Micah A. Walles on 4/6/20.
//

import Die
import Roll
import Foundation

struct RollAndKeepRoll: Roll {
	var name: String

	var pool: DicePool

	func roll() -> RollResult {
		let dice = pool.roll()
		return RollResult(values: dice)
	}
}
