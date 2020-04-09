import Die
import Foundation

struct RollAndKeepPool: DicePool {
	let dice: [Die]
	let keep: Int

	init(roll: Int, keep: Int) {
		// need to add if it has an emphasis, if it doesn't explode, if it explode on other values
		self.keep = keep
		dice = (1 ... roll).map { _ in Die.d10().exploding()}
	}

	func roll() -> [DieResult ] {
		var result = rollDice()
		result.sort { $0.total < $1.total }
		result.removeLast(result.count - keep)
		return result
	}
}
