//
//  Die+Sides.swift
//  
//
//  Created by Micah A. Walles on 4/6/20.
//

import Foundation

extension Die {
	public static func d4() -> Die {
		return Die(sides: 4)
	}

	public static func d6() -> Die {
		return Die(sides: 6)
	}

	public static func d8() -> Die {
		return Die(sides: 8)
	}

	public static func d10() -> Die {
		return Die(sides: 10)
	}

	public static func d12() -> Die {
		return Die(sides: 12)
	}

	public static func d20() -> Die {
		return Die(sides: 20)
	}
}
