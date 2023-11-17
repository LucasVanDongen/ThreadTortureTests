//
//  Thread_Torture_TestsTests.swift
//  Thread Torture TestsTests
//
//  Created by Lucas van Dongen on 17/11/2023.
//

import XCTest

@globalActor
actor CustomActor {
    actor ActorType { }

    static let shared: ActorType = ActorType()
}

protocol Formatter {
    static var staticFormatter: NumberFormatter { get }

    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String
}

extension Formatter {
    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        Self.staticFormatter.numberStyle = .currency
        Self.staticFormatter.decimalSeparator = ","

        return Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!
    }
}

class NonActorFormatter: Formatter {
    static let staticFormatter = NumberFormatter()
}

actor ActorFormatter: Formatter {
    static let staticFormatter = NumberFormatter()
}

class GlobalActorFormatter {
    static let staticFormatter = NumberFormatter()

    @CustomActor
    func format(
        money: Decimal,
        currencySymbol: String
    ) -> String {
        Self.staticFormatter.currencySymbol = currencySymbol
        Self.staticFormatter.numberStyle = .currency
        Self.staticFormatter.decimalSeparator = ","

        return Self.staticFormatter.string(from: NSDecimalNumber(decimal: money))!
    }
}

final class ThreadTortureTests: XCTestCase {
    let iterations = 999

    func testNonActorFormatter() throws {
        XCTExpectFailure("About 1/3 of these calls should fail")
        torture(formatter: NonActorFormatter())
    }

    func testActorFormatter() throws {
        XCTExpectFailure("About 1/3 of these calls should fail")
        torture(formatter: ActorFormatter())
    }

    func testGlobalActorFormatter() throws {
        torture(formatter: GlobalActorFormatter())
    }

    private func torture(
        formatter: Formatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...iterations).forEach { value in
            Task {
                let currencySymbol = switch value % 4 {
                case 0: "$"
                case 1: "€"
                case 2: "POUND"
                case 3: "YEN"
                default: "ERROR"
                }
                let money = Decimal(value)
                let expected = "\(currencySymbol)\u{00a0}\(value),00"
                let result = formatter.format(money: money, currencySymbol: currencySymbol)

                DispatchQueue.main.sync {
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if value == iterations {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: GlobalActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...iterations).forEach { value in
            Task {
                let currencySymbol = switch value % 4 {
                case 0: "$"
                case 1: "€"
                case 2: "POUND"
                case 3: "YEN"
                default: "ERROR"
                }
                let money = Decimal(value)
                let expected = "\(currencySymbol)\u{00a0}\(value),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)
                XCTAssertEqual(
                    expected,
                    result,
                    "Your banking license got revoked because of a compliance issue",
                    file: file,
                    line: line
                )

                if value == iterations {
                    exp.fulfill()
                }
            }
        }

        wait(for: [exp])
    }
}
