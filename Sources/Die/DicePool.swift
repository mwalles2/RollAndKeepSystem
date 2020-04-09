//
//  DicePool.swift
//  
//
//  Created by Micah A. Walles on 4/5/20.
//

import Foundation

public protocol DicePool {
	var dice: [Die] { get }
	func roll() -> [DieResult]
}

extension DicePool {
	public func rollDice() -> [DieResult] {
		return dice.map { die in
			die.roll()
		}
	}
}
