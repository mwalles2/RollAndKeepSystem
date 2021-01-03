//
//  Roll.swift
//  
//
//  Created by Micah A. Walles on 4/6/20.
//

import Die
import Foundation

public protocol Roll: Codable {

	func roll() -> RollResult

	func rollRepresentation() -> String
}
