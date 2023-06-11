//
//  StrapiRequestTests.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import XCTest
@testable import StrapiSwiftCross

final class StrapiRequestTests: XCTestCase {
    /// Tests creating a request with no filters
    func testRequestWithNoFilters() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        XCTAssertEqual(request.filters!.count, 0)
    }
    
    /// Tests creating a request with a single filter
    func testRequestWithAFilter() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        request.addFilter(type: .equalTo, onField: "test", forValue: "testing")
        XCTAssertEqual(request.filters!.count, 1)
        XCTAssertEqual(request.filters![0].type, FilterType.equalTo.rawValue)
        XCTAssertEqual(request.filters![0].field, "test")
        XCTAssertEqual(request.filters![0].value, "testing")
    }
    
    /// Tests creating a request with multiple filters
    func testRequestWithMultipleFilters() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        request.addFilter(type: .equalTo, onField: "test", forValue: "testing")
        XCTAssertEqual(request.filters!.count, 1)
        XCTAssertEqual(request.filters![0].type, FilterType.equalTo.rawValue)
        XCTAssertEqual(request.filters![0].field, "test")
        XCTAssertEqual(request.filters![0].value, "testing")
        
        request.addFilter(type: .notIncludedIn, onField: "array", forValue: "others")
        XCTAssertEqual(request.filters!.count, 2)
        XCTAssertEqual(request.filters![1].type, FilterType.notIncludedIn.rawValue)
        XCTAssertEqual(request.filters![1].field, "array")
        XCTAssertEqual(request.filters![1].value, "others")
        
        request.addFilter(type: .greaterThan, onField: "number", forValue: "4")
        XCTAssertEqual(request.filters!.count, 3)
        XCTAssertEqual(request.filters![2].type, FilterType.greaterThan.rawValue)
        XCTAssertEqual(request.filters![2].field, "number")
        XCTAssertEqual(request.filters![2].value, "4")
    }
    
    /// Tests creating a request that cannot support having a filter applied.
    func testRequestIncapableOfFilter() {
        let request = StrapiRequest(method: .post, contentType: "test")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        request.addFilter(type: .equalTo, onField: "test", forValue: "testing")
        XCTAssertEqual(request.filters!.count, 0)
    }
    
    /// Tests creating a request that cannot support having a body.
    func testRequestIncapableOfBody() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        let body = """
            { "data": "A random string."}
        """
        
        request.setBody(to: body)
        XCTAssertNil(request.body)
    }
    
    /// Tests creating a PUT request with a body.
    func testRequestWithPutBody() {
        let request = StrapiRequest(method: .put, contentType: "test")
        XCTAssertEqual(request.method, .put)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        let body = """
            { "data": "A random string."}
        """
        
        request.setBody(to: body)
        XCTAssertEqual(request.body, body)
    }
    
    /// Tests creating a POST request with a body.
    func testRequestWithPostBody() {
        let request = StrapiRequest(method: .post, contentType: "test")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        let body = """
            { "data": "A random string."}
        """
        
        request.setBody(to: body)
        XCTAssertEqual(request.body, body)
    }
    
    /// Tests creating a request with relations populated.
    func testRequestWithPopulation() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        request.populate(relation: "*")
        XCTAssertEqual(request.filters![0].type, "populate")
        XCTAssertEqual(request.filters![0].field, "*")
    }
    
    /// Tests creating a request that sorts a field.
    func testRequestWithSorting() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        request.sort(field: "id", byDirection: .ascending)
        XCTAssertEqual(request.filters![0].type, "sort")
        XCTAssertEqual(request.filters![0].field, "id")
        XCTAssertEqual(request.filters![0].value, SortDirection.ascending.rawValue)
    }
    
    /// Tests creating a request that randomly sorts results.
    func testRequestWithRandomSorting() {
        let request = StrapiRequest(method: .get, contentType: "test")
        XCTAssertEqual(request.method, .get)
        XCTAssertEqual(request.contentType, "test")
        XCTAssertEqual(request.path, "")
        
        request.randomize()
        XCTAssertEqual(request.filters![0].type, "randomSort")
        XCTAssertEqual(request.filters![0].value, "true")
    }
}
