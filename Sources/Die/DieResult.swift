//
//  DieResult.swift
//  
//
//  Created by Micah A. Walles on 4/22/20.
//

import Foundation

public struct DieResult {
	/// The total value of the roll
	public var total: Int {
		guard let extendedResult = extendedResult else {
			return value
		}

		switch extendedResult {
		case .reroll(let result):
			return result.total
		case .explode(let result):
			return value + result.total
		}
	}

	/// A `String` representation of the roll. This includes any exploding dice or rerolls
	public var result: String {
		guard let extendedResult = extendedResult else {
			return "\(value)"
		}

		switch extendedResult {
		case .reroll(let result):
			return "(\(value) rerolled) " + result.result
		case .explode(let result):
			return "\(value) + " + result.result
		}
	}
	/// The number of sides of the die that was rolled
	public let sides: Int

	let value: Int
	let extendedResult: ExtendedResult?

	public init(value: Int, sides: Int, extendedResult: ExtendedResult?) {
		self.sides = sides
		self.extendedResult = extendedResult
		self.value = value
	}
}
