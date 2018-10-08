import XCTest

final class TestsByXCTest: XCTestCase {
    func testExample() throws {
        let expectation: XCTestExpectation? = self.expectation(description: "connected")

        let ws = WebSocket("ws://localhost:3000/websocket")
        ws.event.open = {
            print("opened")
            expectation?.fulfill()
        }
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}


import Nimble
import Quick
import SwiftWebSocket

class TestByQuick:QuickSpec {
    override func spec() {
        describe ("Quick") {
            it ("connect") {
                var connected = false

                let ws = WebSocket("ws://localhost:3000/websocket")
                ws.event.open = {
                    print("opened")
                    connected = true
                }
                ws.event.close = { code, reason, clean in
                    print("close")
                }
                ws.event.error = { error in
                    print("error \(error)")
                }

                expect(connected).toEventually(beTrue(), timeout:5)
            }
        }
    }
}
