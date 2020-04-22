//
//  DieResult.swift
//  
//
//  Created by Micah A. Walles on 4/22/20.
//

import Foundation

public struct DieResult {
	/// The total value of the roll
	public private(set) var total: Int

	/// A `String` representation of the roll. This includes any exploding dice or rerolls
	public private(set) var result: String

	/// The number of sides of the die that was rolled
	public let sides: Int

	public init(values: [Int], sides: Int) {
		total = values.reduce(0) { (result, new) in
			return result + new
		}

		result = values.map { "\($0)" }.joined(separator: " + ")
		self.sides = sides
	}

	public init(value: Int, sides: Int) {
		total = value
		result = "\(value)"
		self.sides = sides
	}

	public mutating func add(_ value: Int) {
		total = total + value
		result = result + " + \(value)"
	}
}
