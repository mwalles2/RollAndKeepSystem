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
		return RollAndKeepRollResult(values: pool.rollDice(),
									 keep: diceActuallyKept,
									 rollBonus: rollBonus,
									 staticBonus: bonus ?? 0)
	}

	public init(name: String,
				roll diceToRoll: Int,
				keep diceToKeep: Int,
				bonus: Int? = nil,
				explodeOn9: Bool = false,
				emphasis: Bool = false) {
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

		let d10 = Die.d10()
		self.name = name
		pool = DicePool(dice: (1 ... roll).map { _ in
			let die: Die
			if explodeOn9 {
				die = d10.explode(on: [.indefinatly(9), .indefinatly(10)])
			} else {
				die = d10.exploding()
			}

			if emphasis {
				return die.reroll(on: [.firstRoll(1)])
			} else {
				return die
			}
		})
		self.diceToRoll = diceToRoll
		self.diceToKeep = diceToKeep
		self.bonus = bonus
	}

	public func rollRepresentation() -> String {
		if let bonus = bonus {
			if bonus > 0 {
				return "\(diceToRoll)k\(diceToKeep) + \(bonus)"
			} else if bonus < 0 {
				return "\(diceToRoll)k\(diceToKeep) - \(abs(bonus))"
			}
		}
		return "\(diceToRoll)k\(diceToKeep)"
	}
}
