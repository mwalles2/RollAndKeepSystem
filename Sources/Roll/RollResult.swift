//
//  RollResult.swift
//  
//
//  Created by Micah A. Walles on 4/8/20.
//

import Die
import Foundation

public struct RollResult {
	/// <#Description#>
	public let total: Int

	public let diceResults: [DieResult]

	/// <#Description#>
	public var result: String {
		return diceResults.map { $0.result }.joined(separator: ", ")
	}

	public init(values: [DieResult]) {
		total = values.reduce(0) { (result, new) in
			return result + new.total
		}

		diceResults = values
	}
}
