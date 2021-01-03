//
//  ExtendedDieOptions.swift
//  Die
//
//  Created by Micah A. Walles on 10/26/20.
//

import Foundation

public enum ExtendedDieOptions {
	case firstRoll(Int)
	case indefinatly(Int)

	func value() -> Int {
		switch self {
		case .firstRoll(let value),
			 .indefinatly(let value):
			return value
		}
	}
}

extension ExtendedDieOptions: Codable {

	enum Key: CodingKey {
		case rawValue
		case associatedValue
	}

	enum CodingError: Error {
		case unknownValue
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Key.self)
		let rawValue = try container.decode(String.self, forKey: .rawValue)
		switch rawValue {
		case "firstRoll":
			let value = try container.decode(Int.self, forKey: .associatedValue)
			self = .firstRoll(value)
		case "indefinatly":
			let value = try container.decode(Int.self, forKey: .associatedValue)
			self = .indefinatly(value)
		default:
			throw CodingError.unknownValue
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: Key.self)
		switch self {
		case .firstRoll(let value):
			try container.encode("firstRoll", forKey: .rawValue)
			try container.encode(value, forKey: .associatedValue)
		case .indefinatly(let value):
			try container.encode("indefinatly", forKey: .rawValue)
			try container.encode(value, forKey: .associatedValue)
		}
	}

}
