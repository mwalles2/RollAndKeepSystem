//
//  RollAndKeepRoll.swift
//  
//
//  Created by Micah A. Walles on 4/6/20.
//

import Die
import Roll
import Foundation

public struct RollAndKeepRoll: Roll {

	// This is from the sidebar on page 77 of the L5R 4th ed Core
	private let rollBonusModifier = 2

	internal let rollBonus: Int
	internal let diceActuallyKept: Int

	public let name: String
	public let diceToRoll: Int
	public let diceToKeep: Int
	public let bonus: Int?
	public var pool: DicePool

	public func roll() -> RollResult {
		// emphasis Bool
		// freeRaises: Int
		// calledRaises: Int
		return RollAndKeepRollResult(values: pool.rollDice(), keep: diceActuallyKept, rollBonus: rollBonus)
	}

	public init(name: String, roll diceToRoll: Int, keep diceToKeep: Int, bonus: Int? = nil) {
		let roll: Int
		var extra = 0

		if diceToRoll > 10 && diceToKeep > 10 {
			diceActuallyKept = 10
			roll = 10
			rollBonus = ((diceToKeep - 10) + (diceToRoll - 10)) * rollBonusModifier
		} else {
			let keep: Int
			if diceToRoll > 10 {
				roll = 10
				keep = diceToKeep + ((diceToRoll - 10) / 2)
				if keep >= 10 && 10 - diceToKeep > 0 {
					let x = (10 - diceToKeep) * 2
					if diceToRoll - x > 0 {
						extra = (diceToRoll - 10 - x) * rollBonusModifier
					}
				}
			} else {
				roll = diceToRoll
				keep = diceToKeep
			}

			if keep > 10 {
				diceActuallyKept = 10
				rollBonus = (keep - 10) * rollBonusModifier + extra
			} else {
				diceActuallyKept = keep
				rollBonus = 0 + extra
			}
		}

		self.name = name
		pool = DicePool(dice: (1 ... roll).map { _ in Die.d10().exploding()})
		self.diceToRoll = diceToRoll
		self.diceToKeep = diceToKeep
		self.bonus = bonus
	}

	public func rollRepresentation() -> String {
		return "\(diceToRoll)k\(diceToKeep)"
	}
}
