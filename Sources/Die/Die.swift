//
//  Die.swift
//  
//
//  Created by Micah A. Walles on 4/4/20.
//

import Foundation

public struct Die: Codable  {
	/// Number of sides the die has
	public let sides: Int

	/// What values to explode on
	public let explodeOn: [Int]

	public let explodeOnce: Bool

	/// What values to reroll on
	public let rerollOn: [Int]

	public let multipleRerolls: Bool

	private var range:ClosedRange<Int> {
		return 1 ... sides
	}

	public init(sides: Int,
		 explodeOn: [Int] = [Int](),
		 explodeOnce: Bool = false,
		 rerollOn: [Int] = [Int](),
		 multipleRerolls: Bool = false) {
		self.sides = sides
		self.explodeOn = explodeOn
		self.explodeOnce = explodeOnce
		self.rerollOn = rerollOn
		self.multipleRerolls = multipleRerolls
	}

	/// Rolls the die
	/// - Returns: <#description#>
	public func roll() -> DieResult {
		var rolls = [Int]()
		var firstRoll = Int.random(in: range)
		while rerollOn.contains(firstRoll) {
			firstRoll = Int.random(in: range)
		}
		rolls.append(firstRoll)
		var keepRolling = !explodeOn.isEmpty && explodeOn.contains(firstRoll)

		while keepRolling {
			let roll = Int.random(in: range)
			rolls.append(roll)
			keepRolling = explodeOn.contains(roll) && !explodeOnce
		}

		return DieResult(values: rolls, sides: sides)
	}
}

extension Die {
	public func explode(on explodeOn: [Int]) -> Die {
		return Die(sides: sides,
				   explodeOn: explodeOn,
				   explodeOnce: explodeOnce,
				   rerollOn: rerollOn,
				   multipleRerolls: multipleRerolls)
	}

	public func exploding() -> Die {
		return Die(sides: sides,
				   explodeOn: [sides],
				   explodeOnce: explodeOnce,
				   rerollOn: rerollOn,
				   multipleRerolls: multipleRerolls)
	}
}
