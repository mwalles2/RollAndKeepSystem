import XCTest
//@testable import RollKeep
@testable import RollAndKeepSystem
@testable import Die

final class RollKeepTests: XCTestCase {
	func test5k3Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 5, keep: 3)
		XCTAssertEqual(pool.pool.dice.count, 5)
		XCTAssertEqual(pool.diceActuallyKept, 3)
		XCTAssertEqual(pool.rollBonus, 0)
	}

	func test10k10Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 10, keep: 10)
		XCTAssertEqual(pool.pool.dice.count, 10)
		XCTAssertEqual(pool.diceActuallyKept, 10)
		XCTAssertEqual(pool.rollBonus, 0)
	}

	func test11k4Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 11, keep: 4)
		XCTAssertEqual(pool.pool.dice.count, 10)
		XCTAssertEqual(pool.diceActuallyKept, 4)
		XCTAssertEqual(pool.rollBonus, 0)
	}

	func test14k4Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 14, keep: 4)
		XCTAssertEqual(pool.pool.dice.count, 10)
		XCTAssertEqual(pool.diceActuallyKept, 6)
		XCTAssertEqual(pool.rollBonus, 0)
	}

	func test13k9Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 13, keep: 9)
		XCTAssertEqual(pool.pool.dice.count, 10)
		XCTAssertEqual(pool.diceActuallyKept, 10)
		XCTAssertEqual(pool.rollBonus, 2)
	}

	func test10k12Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 10, keep: 12)
		XCTAssertEqual(pool.pool.dice.count, 10)
		XCTAssertEqual(pool.diceActuallyKept, 10)
		XCTAssertEqual(pool.rollBonus, 4)
	}

	func test16k12Pool() {
		let pool = RollAndKeepRoll(name: "Test Roll", roll: 16, keep: 12)
		XCTAssertEqual(pool.pool.dice.count, 10)
		XCTAssertEqual(pool.diceActuallyKept, 10)
		XCTAssertEqual(pool.rollBonus, 16)
	}

	static var allTests = [
        ("test5k3Pool", test5k3Pool),
//		test10k10Pool
//		test11k4Pool
//		test14k4Pool
//		test13k9Pool
//		test16k12Pool
    ]
}
