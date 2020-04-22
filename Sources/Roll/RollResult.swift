//
//  RollResult.swift
//  
//
//  Created by Micah A. Walles on 4/8/20.
//

import Die
import Foundation

public protocol RollResult {
	/// <#Description#>
	var total: Int { get }

	var diceResults: [DieResult] { get }

	/// <#Description#>
	var result: String { get }

	var diceRolled: String { get }
}

extension RollResult {
	var diceRolled: String {
		var dice = [Int: Int]()
		for result in diceResults {
			if let value = dice[result.sides] {
				dice[result.sides] = value + 1
			} else {
				dice[result.sides] = 1
			}
		}
		let numberOfDice = dice.map { (sides: Int, number: Int) in
			return "\(number)d\(sides)"
		}
		return numberOfDice.joined(separator: ", ")
	}
}
