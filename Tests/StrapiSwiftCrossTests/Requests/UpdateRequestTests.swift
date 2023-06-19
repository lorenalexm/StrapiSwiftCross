//
//  File.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class UpdateRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating a new UpdateRequest and that body exists.
    func testUpdateRequest() {
        let body = """
            { "data": "request body data" }
        """
        let request = UpdateRequest(contentType: "testing", id: 42, body: body)
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.contentType, "testing")
        XCTAssertEqual(request.path, "/42")
        XCTAssertEqual(request.body, body)
    }
}
