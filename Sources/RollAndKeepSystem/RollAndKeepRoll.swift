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

	fileprivate struct ActualRoll {
		let diceToRoll: Int
		let diceToKeep: Int
		let bonus: Int
	}

	// This is from the sidebar on page 77 of the L5R 4th ed Core
	private static let rollBonusModifier = 2

	internal let rollBonus: Int
	internal let diceActuallyKept: Int

	public let diceToRoll: Int
	public let diceToKeep: Int
	public let bonus: Int?
	public let explodeOn9: Bool
	public let emphasis: Bool

	internal var pool: DicePool

	public func roll() -> RollResult {
		return RollAndKeepRollResult(values: pool.rollDice(),
									 keep: diceActuallyKept,
									 rollBonus: rollBonus,
									 staticBonus: bonus ?? 0)
	}

	fileprivate static func determinRoll(baseRoll diceToRoll: Int, baseKeep diceToKeep: Int) -> ActualRoll {
		let diceActuallyRolled: Int
		let diceActuallyKept: Int
		let rollBonus: Int

		if diceToRoll > 10 && diceToKeep > 10 {
			diceActuallyKept = 10
			diceActuallyRolled = 10
			rollBonus = ((diceToKeep - 10) + (diceToRoll - 10)) * rollBonusModifier
		} else {
			let keep: Int
			var extra = 0

			if diceToRoll > 10 {
				diceActuallyRolled = 10
				keep = diceToKeep + ((diceToRoll - 10) / 2)
				if keep >= 10 && 10 - diceToKeep > 0 {
					let x = (10 - diceToKeep) * 2
					if diceToRoll - x > 0 {
						extra = (diceToRoll - 10 - x) * rollBonusModifier
					}
				}
			} else {
				diceActuallyRolled = diceToRoll
				keep = diceToKeep
			}

			if keep > 10 {
				diceActuallyKept = 10
				rollBonus = (keep - 10) * rollBonusModifier + extra
			} else {
				diceActuallyKept = keep
				rollBonus = extra
			}
		}
		return ActualRoll(diceToRoll: diceActuallyRolled,
				 diceToKeep: diceActuallyKept,
				 bonus: rollBonus)
	}

	fileprivate static func dicePool(diceToRoll: Int, explodeOn9: Bool, emphasis: Bool) -> DicePool {
		let d10 = Die.d10()
		return DicePool(dice: (1 ... diceToRoll).map { _ in
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
	}

	public init(roll diceToRoll: Int,
				keep diceToKeep: Int,
				bonus: Int? = nil,
				explodeOn9: Bool = false,
				emphasis: Bool = false) {

		let data = RollAndKeepRoll.determinRoll(baseRoll: diceToRoll, baseKeep: diceToKeep)

		pool = RollAndKeepRoll.dicePool(diceToRoll: data.diceToRoll, explodeOn9: explodeOn9, emphasis: emphasis)
		self.diceToRoll = diceToRoll
		self.diceToKeep = diceToKeep
		self.bonus = bonus
		self.explodeOn9 = explodeOn9
		self.emphasis = emphasis
		diceActuallyKept = data.diceToKeep
		rollBonus = data.bonus
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

extension RollAndKeepRoll: Codable {

	enum CodingKeys: String, CodingKey {
		case diceToRoll
		case diceToKeep
		case bonus
		case explodeOn9
		case emphasis
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		diceToRoll = try values.decode(Int.self, forKey: .diceToRoll)
		diceToKeep = try values.decode(Int.self, forKey: .diceToKeep)
		bonus = try values.decode(Int.self, forKey: .bonus)
		explodeOn9 = try values.decode(Bool.self, forKey: .explodeOn9)
		emphasis = try values.decode(Bool.self, forKey: .emphasis)

		let data = RollAndKeepRoll.determinRoll(baseRoll: diceToRoll, baseKeep: diceToKeep)

		pool = RollAndKeepRoll.dicePool(diceToRoll: data.diceToRoll, explodeOn9: explodeOn9, emphasis: emphasis)
		diceActuallyKept = data.diceToKeep
		rollBonus = data.bonus
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(diceToRoll, forKey: .diceToRoll)
		try container.encode(diceToKeep, forKey: .diceToKeep)
		try container.encode(bonus, forKey: .bonus)
		try container.encode(explodeOn9, forKey: .explodeOn9)
		try container.encode(emphasis, forKey: .emphasis)
	}
}
