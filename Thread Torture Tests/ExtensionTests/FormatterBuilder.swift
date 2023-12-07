//
//  FormatterBuilder.swift
//  Thread TortureTests
//
//  Created by Lucas van Dongen on 02/12/2023.
//

import Foundation

let dutchLocale = Locale(identifier: "nl_NL")

protocol FormatterBuilding {
    static func buildFormatter() -> NumberFormatter
}

extension FormatterBuilding {
    static func buildFormatter() -> NumberFormatter {
        let formatter =  NumberFormatter()
        formatter.numberStyle = .currency
        formatter.decimalSeparator = ","
        formatter.currencyDecimalSeparator = ","
        formatter.locale = dutchLocale
#if os(macOS)
        formatter.hasThousandSeparators = false
#else
        formatter.groupingSeparator = ""
        formatter.usesGroupingSeparator = false
        formatter.currencyGroupingSeparator = ""
#endif

        return formatter
    }
}
