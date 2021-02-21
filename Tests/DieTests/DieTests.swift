//
//  DieTests.swift
//  
//
//  Created by Micah A. Walles on 10/27/20.
//

import Foundation
import XCTest
@testable import Die

typealias RandomType = (ClosedRange<Int>) -> Int

final class DieTests: XCTestCase {
	func testRerollOnesOnce() {
		let die = Die.d10()
		var random1Values = [1,3,2]

		let random1: RandomType = { _ in
			if random1Values.count > 0 {
				return random1Values.removeFirst()
			}
			return 0
		}

		let result = die.roll(random1)
		XCTAssertEqual(result.total, 3)
	}

	static var allTests = [
		("testRerollOnesOnce",testRerollOnesOnce)
	]
}
