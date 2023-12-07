//
//  CustomGlobalActorTortureTests.swift
//  Thread Torture TestsTests
//
//  Created by Lucas van Dongen on 17/11/2023.
//

import XCTest

// Without the actor
class Actorless {
    private(set) var sum: Int!

    func add() -> Int? {
        sum = nil
        sum = 1
        return sum
    }
}

// Exactly the same, but with the actor on the class
@StateActor
class ActoredClass {
    private(set) var sum: Int!

    func add() -> Int? {
        sum = nil
        sum = 1
        return sum
    }

    func addWithoutActor() -> Int? {
        sum = nil
        sum = 1
        return sum
    }
}

// Exactly the same, but with the actor on the function
class ActoredFunction {
    private(set) var sum: Int!

    @StateActor
    func add() -> Int? {
        sum = nil
        sum = 1
        return sum
    }
}

@globalActor
struct StateActor {
    actor ActorType { }

    static let shared: ActorType = ActorType()
}

final class CustomGlobalActorTortureTests: XCTestCase {
    // This test crashes fairly quickly on nil-unwrapping
    func testActorless() throws {
        let group = DispatchGroup()
        let obj = Actorless()

        for _ in 1...1000 {
            DispatchQueue.global().async {
                _ = obj.add()
            }
        }

        let result = group.wait(timeout: DispatchTime.now() + 5)

        XCTAssert(result == .success)
    }

    // This test passes, but the printed thread numbers are all over the place
    func testActorObjectNonisolated() throws {
        let group = DispatchGroup()

        Task { @StateActor in
            let obj = ActoredClass()

            for _ in 1...1000 {
                DispatchQueue.global().async {
                    let result = obj.add()
                    DispatchQueue.main.async {
                        XCTAssertNotNil(result) // ⚠️ Call to global actor 'StateActor'-isolated instance method 'add()' in a synchronous nonisolated context; this is an error in Swift 6
                    }
                }
            }
        }

        let result = group.wait(timeout: DispatchTime.now() + 5)

        XCTAssert(result == .success)
    }

    // This test also passes and also prints the same thread
    func testActorObject() throws {
        let group = DispatchGroup()

        Task { @StateActor in
            let obj = ActoredClass()

            for _ in 1...1000 {

                DispatchQueue.global().async {
                    Task { @StateActor in
                        let result = obj.add()
                        DispatchQueue.main.async {
                            XCTAssertNotNil(result)
                        }
                    }
                }
            }
        }

        let result = group.wait(timeout: DispatchTime.now() + 5)

        XCTAssert(result == .success)
    }

    // This test also passes and also prints the same thread
    func testActorFunction() throws {
        let group = DispatchGroup()

        Task { @StateActor in
            let obj = ActoredFunction()

            for _ in 1...1000 {

                DispatchQueue.global().async {
                    Task {
                        let result = await obj.add()
                        DispatchQueue.main.sync {
                            XCTAssertNotNil(result)
                        }
                    }
                }
            }
        }

        let result = group.wait(timeout: DispatchTime.now() + 5)

        XCTAssert(result == .success)
    }
}
