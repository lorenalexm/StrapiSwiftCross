//
//  FetchRequestTests.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import XCTest
@testable import StrapiSwiftCross

class FetchReqeustTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating a new FetchRequest.
    func testFetchRequest() {
        let request = FetchRequest(contentType: "testing", id: 42)
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "testing")
        XCTAssertEqual(request.path, "/42")
    }
}
