//
//  DicePool.swift
//  
//
//  Created by Micah A. Walles on 4/5/20.
//

import Foundation

public struct DicePool: Codable {
	var dice: [Die]

	public init(dice: [Die]) {
		self.dice = dice
	}

	public func rollDice() -> [DieResult] {
		return dice.map { die in
			die.roll()
		}
	}
}
