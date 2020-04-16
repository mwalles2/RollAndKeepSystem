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
	public let name: String
	public let diceToRoll: Int
	public let diceToKeep: Int
	public var pool: DicePool

	public func roll() -> RollResult {
		return RollAndKeepRollResult(values: pool.rollDice(), keep: diceToKeep)
	}

	public init(name: String, roll: Int, keep: Int) {
		self.name = name
		pool = DicePool(dice: (1 ... roll).map { _ in Die.d10().exploding()})
		diceToRoll = roll
		diceToKeep = keep
	}

	public func rollRepresentation() -> String {
		return "\(diceToRoll)k\(diceToKeep)"
	}
}
