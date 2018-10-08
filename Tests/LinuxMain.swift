import XCTest

import websocketTests

var tests = [XCTestCaseEntry]()
tests += websocketTests.allTests()
XCTMain(tests)