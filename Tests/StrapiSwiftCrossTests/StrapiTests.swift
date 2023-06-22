//
//  File.swift
//  
//
//  Created by Alex Loren on 6/10/23.
//

import XCTest
import Mocker
@testable import StrapiSwiftCross

final class StrapiTests: XCTestCase {
    // MARK: - Properties
    
    var strapi: Strapi?
    
    // MARK: - Functions
    
    /// Sets properties before each test.
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        
        strapi = Strapi(host: "http://localhost", urlSession: urlSession)
    }
    
    /// Releases properties after each test.
    override func tearDown() {
        strapi = nil
    }
    
    /// Tests executing a request and returning mocked data.
    func testExecutingARequest() async throws {
        let queryRequest = QueryRequest(contentType: "testing")
        let url = URL(string: strapi!.buildURL(from: queryRequest))!
        
        let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [
            .get: MockedData.jsonWithoutErrors.data(using: .utf8)!
        ])
        mock.register()
        
        let result = try await strapi?.execute(queryRequest)
        XCTAssertEqual(result, MockedData.jsonWithoutErrors)
    }
    
    /// Tests executing a request that returns an error from the Strapi host.
    func testExecutingAFailingRequest() async throws {
        let queryRequest = QueryRequest(contentType: "testing")
        let url = URL(string: strapi!.buildURL(from: queryRequest))!
        
        let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [
            .get: MockedData.jsonWithForbiddenError.data(using: .utf8)!
        ])
        mock.register()
        
        var didFailWithError: Error?
        do {
            let _ = try await strapi?.execute(queryRequest)
        } catch {
            didFailWithError = error
            XCTAssertEqual(error.localizedDescription, "The server returned an error 403 with the message: Forbidden")
        }
        XCTAssertNotNil(didFailWithError)
    }
    
    /// Tests executing a request that returns a decoded object.
    func testExecutingAndDecodingARequest() async throws {
        let queryRequest = QueryRequest(contentType: "testing")
        let url = URL(string: strapi!.buildURL(from: queryRequest))!
        
        let mock = Mock(url: url, dataType: .json, statusCode: 200, data: [
            .get: MockedData.jsonWithoutErrors.data(using: .utf8)!
        ])
        mock.register()
        
        do {
            let title: QueryTestResponse = try await strapi!.executeAndDecode(queryRequest)
            XCTAssertEqual(title.data.count, 1)
            XCTAssertEqual(title.data[0].id, 1)
            XCTAssertEqual(title.data[0].title, "Surprising Title")
        }
    }
    
    /// Tests building a URLRequest for later use.
    func testBuildingURLRequest() {
        let queryRequest = QueryRequest(contentType: "testing")
        let request = try? strapi?.buildURLRequest(from: queryRequest, withAuthToken: "")
        XCTAssertEqual(request?.url?.absoluteString, "http://localhost/testing")
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Content-Type"), "application/json; charset=utf8")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), nil)
    }
    
    /// Tests building a URLRequest with an authentication token for later use.
    func testBuildingURLRequestWithToken() {
        let queryRequest = QueryRequest(contentType: "testing")
        let request = try? strapi?.buildURLRequest(from: queryRequest, withAuthToken: "1234-5678")
        XCTAssertEqual(request?.url?.absoluteString, "http://localhost/testing")
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Content-Type"), "application/json; charset=utf8")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Accept"), "application/json")
        XCTAssertEqual(request?.value(forHTTPHeaderField: "Authorization"), "Bearer 1234-5678")
    }
    
    /// Tests building a basic URL from a request.
    func testBuildingURL() {
        let request = FetchRequest(contentType: "testing", id: 1)
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing/1")
    }
    
    /// Tests building a URL with a filter from a request.
    func testBuildingURLWithOneFilter() {
        let request = QueryRequest(contentType: "testing")
        request.addFilter(type: .lessThan, onField: "number", forValue: "500")
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?filters[number][$lt]=500")
    }
    
    /// Tests building a URL with multiple filters from a request.
    func testBuildingURLWithMultipleFilters() {
        let request = QueryRequest(contentType: "testing")
        request.addFilter(type: .lessThan, onField: "number", forValue: "500")
        request.addFilter(type: .isNotNull, onField: "name", forValue: "")
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?filters[number][$lt]=500&filters[name][$notNull]")
    }
    
    /// Tests building a URL with IncludedIn filters from a request.
    func testBulidingURLWithIncludedInFilter() {
        let request = QueryRequest(contentType: "testing")
        request.addFilter(type: .includedIn, onField: "id", forValue: "3")
        request.addFilter(type: .includedIn, onField: "id", forValue: "6")
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?filters[id][$in][0]=3&filters[id][$in][1]=6")
    }
    
    /// Tests building a URL with NotIncludedIn filters from a request.
    func testBulidingURLWithNotIncludedInFilter() {
        let request = QueryRequest(contentType: "testing")
        request.addFilter(type: .notIncludedIn, onField: "id", forValue: "3")
        request.addFilter(type: .notIncludedIn, onField: "id", forValue: "6")
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?filters[id][$notIn][0]=3&filters[id][$notIn][1]=6")
    }
    
    /// Tests building a URL with sorting from a request.
    func testBuildingURLWithSorting() {
        let request = QueryRequest(contentType: "testing")
        request.sort(field: "id", byDirection: .descending)
        request.sort(field: "name", byDirection: .ascending)
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?sort[0]=id:desc&sort[1]=name:asc")
    }
    
    /// Tests building a URL with population from a request.
    func testBuildingURLWithPopulation() {
        let request = QueryRequest(contentType: "testing")
        request.populate(relation: "friends")
        request.populate(relation: "family")
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?populate[0]=friends&populate[1]=family")
    }
    
    /// Tests buliding a URL with randomization from a request.
    func testBuildingURLWithRandomization() {
        let request = QueryRequest(contentType: "testing")
        request.randomize()
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?randomSort=true")
    }
    
    /// Tests building a URL with an offset and return limit from a request.
    func testBuildingURLWithOffsetAndLimit() {
        let request = QueryRequest(contentType: "testing")
        request.offset(by: 10)
        request.limit(to: 3)
        let url = strapi?.buildURL(from: request)
        XCTAssertEqual(url, "http://localhost/testing?pagination[start]=10&pagination[limit]=3")
    }
}
