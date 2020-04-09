//
//  Roll.swift
//  
//
//  Created by Micah A. Walles on 4/6/20.
//

import Die
import Foundation

public protocol Roll {
	var name: String { get }
	var pool: DicePool { get }

	func roll() -> RollResult
}
