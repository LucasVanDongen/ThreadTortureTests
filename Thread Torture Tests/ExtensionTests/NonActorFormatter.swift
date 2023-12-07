//
//  NonActorFormatter.swift
//  Thread TortureTests
//
//  Created by Lucas van Dongen on 03/12/2023.
//

import Foundation

class NonActorFormatter: FormatterBuilding {
    static let staticFormatter = buildFormatter()

    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        let result = Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!

        return result
    }
}

protocol Formatting: FormatterBuilding {
    static var staticFormatter: NumberFormatter { get }

    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String
}

extension Formatting {
    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        let result = Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!

        return result
    }
}
