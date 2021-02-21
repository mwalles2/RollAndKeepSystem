//
//  Die.swift
//  
//
//  Created by Micah A. Walles on 4/4/20.
//

import Foundation

public struct Die: Codable {
	/// Number of sides the die has
	public let sides: Int

	/// What values to explode on
	public let explodeOn: [ExtendedDieOptions]

	/// What values to reroll on
	public let rerollOn: [ExtendedDieOptions]

	private var range:ClosedRange<Int> {
		return 1 ... sides
	}

	public init(sides: Int,
		 explodeOn: [ExtendedDieOptions] = [ExtendedDieOptions](),
		 rerollOn: [ExtendedDieOptions] = [ExtendedDieOptions]()) {
		self.sides = sides
		self.explodeOn = explodeOn
		self.rerollOn = rerollOn
	}

	/// Rolls the die
	/// - Returns: <#description#>
//	public func roll(_ random: (ClosedRange<Int>) -> Int = Int.random) -> DieResult {
	public func roll() -> DieResult {
		let roll = Int.random(in: range)
		func extendRoll() -> DieResult {
			let die = Die(sides: sides,
						  explodeOn: explodeOn.filter({
							switch $0 {
							case .firstRoll(_):
								return false
							case .indefinatly(_):
								return true
							}
						  }),
						  rerollOn: rerollOn.filter({
							switch $0 {
							case .firstRoll(_):
								return false
							case .indefinatly(_):
								return true
							}
						  })
			)
			return die.roll()
		}
		let extendedResult: ExtendedResult?
		if rerollOn.contains(where: { $0.value() == roll }) {
			extendedResult = .reroll(extendRoll())
		} else if explodeOn.contains(where: { $0.value() == roll }) {
			extendedResult = .explode(extendRoll())
		} else {
			extendedResult = nil
		}

		return DieResult(value: roll, sides: sides, extendedResult: extendedResult)
	}
}

extension Die {
	public func explode(on explodeOn: [ExtendedDieOptions]) -> Die {
		return Die(sides: sides,
				   explodeOn: explodeOn,
				   rerollOn: rerollOn)
	}

	public func exploding() -> Die {
		return Die(sides: sides,
				   explodeOn: [.indefinatly(sides)],
				   rerollOn: rerollOn)
	}

	public func reroll(on rerollOn: [ExtendedDieOptions]) -> Die {
		return Die(sides: sides,
				   explodeOn: explodeOn,
				   rerollOn: rerollOn)
	}
}
