//
//  CustomActorFormatter.swift
//  Thread TortureTests
//
//  Created by Lucas van Dongen on 02/12/2023.
//

import Foundation

@globalActor
actor CustomActor {
    actor ActorType { }

    static let shared: ActorType = ActorType()
}

@CustomActor
class CustomActorFormatter: FormatterBuilding {
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

@CustomActor
protocol GlobalActorFormatting: FormatterBuilding {
    static var staticFormatter: NumberFormatter { get }

    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String
}

@CustomActor
class ExtensionCustomActorFormatter: Formatting {
    static let staticFormatter = buildFormatter()
}

@CustomActor
protocol CustomActorFormatting: FormatterBuilding {
    static var staticFormatter: NumberFormatter { get }

    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String
}

extension CustomActorFormatting {
    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        let result = Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!

        return result
    }
}

@CustomActor
class FixedExtensionCustomActorFormatter: CustomActorFormatting {
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

@CustomActor
class CustomActorWithFormatterInExtension: FormatterBuilding {
    static let staticFormatter = buildFormatter()
}

extension CustomActorWithFormatterInExtension {
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
// Non-actor type 'ErrorExtensionCustomActorFormatter' cannot conform to the 'Actor' protocol
// Replace 'class' with 'actor'
// @CustomActor
// class ErrorExtensionCustomActorFormatter: ActorFormatting {
//     static let staticFormatter = buildFormatter()
// }
