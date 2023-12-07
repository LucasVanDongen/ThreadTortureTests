//
//  ActorFormatter.swift
//  Thread TortureTests
//
//  Created by Lucas van Dongen on 02/12/2023.
//

import Foundation

actor ActorFormatter: FormatterBuilding {
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

actor ExtensionActorFormatter: Formatting {
    static let staticFormatter = buildFormatter()
}

protocol ActorFormatting: Actor, FormatterBuilding {
    static var staticFormatter: NumberFormatter { get }

    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String
}

actor FixedExtensionActorFormatter: ActorFormatting {
    static let staticFormatter = buildFormatter()
}

extension ActorFormatting {
    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        let result = Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!

        return result
    }
}

actor ActorWithFormatterInExtension: FormatterBuilding {
    static let staticFormatter = buildFormatter()
}

extension ActorWithFormatterInExtension {
    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        let result = Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!

        return result
    }
}
// Actor-based protocols cannot be used on Custom Global Actor based classes and vice versa
//
// Actor 'ErrorExtensionActorFormatter' cannot conform to global actor isolated protocol 'CustomActorFormatting'
// actor ErrorExtensionActorFormatter: CustomActorFormatting {
//     static let staticFormatter = buildFormatter()
// }
