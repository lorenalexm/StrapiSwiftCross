//
//  LoginRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class LoginRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests creating the LoginRequest.
    func testLoginRequest() {
        let body = """
            { "identifier": "username", "password": "password" }
        """
        
        let request = LoginRequest(identifier: "username", password: "password")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "auth")
        XCTAssertEqual(request.path, "/local")
        XCTAssertEqual(request.body, body)
    }
}
