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

}
//{
//		return diceResults.map { $0.result }.joined(separator: ", ")
//	}
//
//}
