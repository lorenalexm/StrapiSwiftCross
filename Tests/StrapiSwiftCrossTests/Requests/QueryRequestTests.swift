//
//  QueryRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class QueryRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating a new QueryRequest.
    func testQueryRequest() {
        let request = QueryRequest(contentType: "testing")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "testing")
    }
    
    /// Tests creating a new QueryRequest with a filter.
    func testQueryRequestWithFilters() {
        let request = QueryRequest(contentType: "testing")
        request.addFilter(type: .isNotNull, onField: "test", forValue: "testing")
        
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "testing")
        XCTAssertEqual(request.filters!.count, 1)
        XCTAssertEqual(request.filters![0].type, "$notNull")
    }
}
