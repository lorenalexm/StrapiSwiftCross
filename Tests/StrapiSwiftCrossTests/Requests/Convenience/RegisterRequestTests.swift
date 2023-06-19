//
//  RegisterRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

class RegisterRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Tests createing the RegisterRequest.
    func testRegisterRequest() {
        let body = """
            { "username": username, "email": email@test.com, "password": password }
        """
        
        let request = RegisterRequest(username: "username", email: "email@test.com", password: "password")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "auth")
        XCTAssertEqual(request.path, "/local/register")
        XCTAssertEqual(request.body, body)
    }
}
