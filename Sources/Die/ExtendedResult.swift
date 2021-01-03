//
//  ExtendedResult.swift
//  Die
//
//  Created by Micah A. Walles on 10/26/20.
//

import Foundation

public enum ExtendedResult {
	indirect case reroll(DieResult)
	indirect case explode(DieResult)
}
