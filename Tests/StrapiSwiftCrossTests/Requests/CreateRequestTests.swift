//
//  CreateRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

public final class CreateRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating a new CreateRequest and that the body exists.
    func testCreateRequest() {
        let body = """
            { "data": "request body data" }
        """
        let request = CreateRequest(contentType: "testing", body: body)
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "testing")
        XCTAssertEqual(request.body, body)
    }
}
