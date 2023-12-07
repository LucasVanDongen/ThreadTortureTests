//
//  Thread_Torture_TestsTests.swift
//  Thread Torture TestsTests
//
//  Created by Lucas van Dongen on 17/11/2023.
//

import XCTest

final class ThreadTortureTests: XCTestCase, @unchecked Sendable {
    let lastIteration = 1000

    func testNonActorFormatter() throws {
        XCTExpectFailure("About 1/10 of these calls are expected to fail")
        torture(formatter: NonActorFormatter())
    }

    func testActorFormatter() throws {
        torture(formatter: ActorFormatter())
    }

    func testCustomActorFormatter() async throws {
        let formatter = await CustomActorFormatter()
        torture(formatter: formatter)
    }

    func testExtensionActorFormatter() throws {
        torture(formatter: ExtensionActorFormatter())
    }

    func testExtensionCustomActorFormatter() async throws {
        let formatter = await ExtensionCustomActorFormatter()
        XCTExpectFailure("About 1/10 of these calls are expected to fail")
        torture(formatter: formatter)
    }

    func testFixedExtensionActorFormatter() throws {
        torture(formatter: FixedExtensionActorFormatter())
    }

    func testFixedExtensionCustomActorFormatter() async throws {
        let formatter = await FixedExtensionCustomActorFormatter()
        torture(formatter: formatter)
    }

    private func torture(
        formatter: NonActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                let amount = self.amount(for: iteration)

                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = formatter.format(money: money, currencySymbol: currencySymbol)

                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if iteration == self.lastIteration {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: ActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                let amount = self.amount(for: iteration)

                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)

               Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if iteration == lastIteration {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: CustomActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                let amount = self.amount(for: iteration)
                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)

                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if iteration == lastIteration {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: ExtensionActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                let amount = self.amount(for: iteration)
                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)

                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if iteration == lastIteration {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: FixedExtensionActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                let amount = self.amount(for: iteration)
                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)

                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if iteration == lastIteration {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: ExtensionCustomActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                let amount = self.amount(for: iteration)
                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)

                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )

                    if iteration == lastIteration {
                        exp.fulfill()
                    }
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: FixedExtensionCustomActorFormatter,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                // CustomActorClassFormatter.staticFormatter.currencySymbol = "WRONG"
                let amount = self.amount(for: iteration)
                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)
                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )
                }

                if iteration == lastIteration {
                    exp.fulfill()
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: ActorWithFormatterInExtension,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        print("starting")
        (0...lastIteration).forEach { iteration in
            print("iteration \(iteration)")
            Task {
                print("task \(iteration)")
                let currencySymbol = self.currencySymbol(for: iteration)
                // CustomActorFunctionFormatter.staticFormatter.currencySymbol = "WRONG"
                let amount = self.amount(for: iteration)

                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)
                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )
                }

                if iteration == lastIteration {
                    exp.fulfill()
                }
            }
        }

        wait(for: [exp])
    }

    private func torture(
        formatter: CustomActorWithFormatterInExtension,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait until all are ran")
        (0...lastIteration).forEach { iteration in
            Task {
                let currencySymbol = self.currencySymbol(for: iteration)
                // CustomActorFunctionFormatter.staticFormatter.currencySymbol = "WRONG"
                let amount = self.amount(for: iteration)

                let money = Decimal(amount + iteration)
                let expected = "\(currencySymbol)\u{00a0}\(amount + iteration),00"
                let result = await formatter.format(money: money, currencySymbol: currencySymbol)
                Task { @MainActor in
                    XCTAssertEqual(
                        expected,
                        result,
                        "Your banking license got revoked because of a compliance issue",
                        file: file,
                        line: line
                    )
                }

                if iteration == lastIteration {
                    exp.fulfill()
                }
            }
        }

        wait(for: [exp])
    }

    // 1s on my machine, not so good
    func testCreateNumberFormatterOverAndOver() {
        let money = NSDecimalNumber(10.0)
        let formattedMoney = "€\u{00a0}10,00"
        measure {
            for _ in 1...1000 {
                let formatter = NumberFormatter()
                formatter.currencySymbol = "€"
                formatter.numberStyle = .currency
                formatter.currencyDecimalSeparator = ","
                formatter.locale = dutchLocale
                let result = formatter.string(from: money)
                XCTAssertEqual(result, formattedMoney)
            }
        }
    }

    // 0.5s on my machine, much better
    func testCreateNumberFormatterOnceSetupOverAndOver() {
        let money = NSDecimalNumber(10.0)
        let formattedMoney = "€\u{00a0}10,00"
        let formatter = NumberFormatter()
        measure {
            for _ in 1...1000 {
                formatter.currencySymbol = "€"
                formatter.numberStyle = .currency
                formatter.currencyDecimalSeparator = ","
                formatter.locale = dutchLocale
                let result = formatter.string(from: money)
                XCTAssertEqual(result, formattedMoney)
            }
        }
    }

    // 0.3s on my machine
    func testCreateAndSetupNumberFormatterOnlyOnce() {
        let money = NSDecimalNumber(10.0)
        let formattedMoney = "€\u{00a0}10,00"
        let formatter = NumberFormatter()
        formatter.currencySymbol = "€"
        formatter.numberStyle = .currency
        formatter.currencyDecimalSeparator = ","
        formatter.locale = dutchLocale
        measure {
            for _ in 1...1000 {
                let result = formatter.string(from: money)
                XCTAssertEqual(result, formattedMoney)
            }
        }
    }

    // 1s on my machine, not so good
    func testCreateDateFormatterOverAndOver() {
        let date = Date(timeIntervalSince1970: 0)
        let formattedDate = "1970"
        measure {
            for _ in 1...1000 {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY"
                formatter.locale = Locale.current
                let result = formatter.string(from: date)
                XCTAssertEqual(result, formattedDate)
            }
        }
    }

    // 0.5s on my machine, much better
    func testCreateDateFormatterOnceSetupOverAndOver() {
        let date = Date(timeIntervalSince1970: 0)
        let formattedDate = "1970"
        let formatter = DateFormatter()
        measure {
            for _ in 1...1000 {
                formatter.dateFormat = "YYYY"
                formatter.locale = Locale.current
                let result = formatter.string(from: date)
                XCTAssertEqual(result, formattedDate)
            }
        }
    }

    // 0.3s on my machine
    func testCreateAndSetupDateFormatterOnlyOnce() {
        let date = Date(timeIntervalSince1970: 0)
        let formattedDate = "1970"
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        formatter.locale = Locale.current
        measure {
            for _ in 1...1000 {
                let result = formatter.string(from: date)
                XCTAssertEqual(result, formattedDate)
            }
        }
    }

    private func currencySymbol(for iteration: Int) -> String {
        return switch iteration % 4 {
        case 0: "$"
        case 1: "€"
        case 2: "£"
        case 3: "¥"
        default: "ERROR"
        }
    }

    private func amount(for iteration: Int) -> Int {
        return switch iteration % 4 {
        case 0: 1000
        case 1: 925
        case 2: 875
        case 3: 150000
        default: 10000
        }
    }

//    @CustomActor
//    func testActorMutateFormatter() throws {
//        XCTExpectFailure("About 1/10 of these calls are expected to fail")
//        let formatter = StaticActorFormatter()
//        StaticActorFormatter.staticFormatter = NumberFormatter()
//        torture(formatter: formatter)
//    }
}
