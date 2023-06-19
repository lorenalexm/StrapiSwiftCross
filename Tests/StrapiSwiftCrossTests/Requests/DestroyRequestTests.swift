//
//  File.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class DestroyRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creeateing a new DestroyRequest.
    func testDestroyRequest() {
        let request = DestroyRequest(contentType: "testing", id: 42)
        XCTAssertEqual(request.method, .delete)
        XCTAssertEqual(request.contentType, "testing")
        XCTAssertEqual(request.path, "/42")
    }
}
