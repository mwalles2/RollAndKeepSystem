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

	private let rollBonusModifier = 5

	public let name: String
	public let diceToRoll: Int
	public let diceToKeep: Int
	private let diceActuallyKept: Int
	public let bonus: Int?
	private let rollBonus: Int
	public var pool: DicePool

	public func roll() -> RollResult {
		// emphasis Bool
		// freeRaises: Int
		// calledRaises: Int
		return RollAndKeepRollResult(values: pool.rollDice(), keep: diceActuallyKept, rollBonus: rollBonus)
	}

	public init(name: String,
				roll diceToRoll: Int,
				keep diceToKeep: Int,
				bonus: Int? = nil,
				explodeOn9: Bool = false,
				emphasis: Bool = false) {
		let roll: Int
		let keep: Int

		if diceToRoll > 10 {
			roll = 10
			keep = diceToKeep + ((diceToRoll - 10) / 2)
		} else {
			roll = diceToRoll
			keep = diceToKeep
		}

		if keep > 10 {
			diceActuallyKept = 10
			rollBonus = (keep - 10) * rollBonusModifier
		} else {
			diceActuallyKept = keep
			rollBonus = 0
		}

		let d10 = Die.d10()
		self.name = name
		pool = DicePool(dice: (1 ... roll).map { _ in
			let die: Die
			if explodeOn9 {
				die = d10.explode(on: [9, 10])
			} else {
				die = d10.exploding()
			}

			if emphasis {
				return die.reroll(on: [1])
			} else {
				return die
			}
		})
		self.diceToRoll = diceToRoll
		self.diceToKeep = diceToKeep
		self.bonus = bonus
	}

	public func rollRepresentation() -> String {
		return "\(diceToRoll)k\(diceToKeep)"
	}
}
