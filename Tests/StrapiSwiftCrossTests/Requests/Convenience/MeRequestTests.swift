//
//  MeRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class MeRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating a MeRequest.
    func testMeRequest() {
        let request = MeRequest()
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "users")
        XCTAssertEqual(request.path, "/me")
    }
}
