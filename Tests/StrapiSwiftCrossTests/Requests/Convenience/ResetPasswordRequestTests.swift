//
//  ResetPasswordRequestTests.swift
//  
//
//  Created by Alex Loren on 6/19/23.
//

import XCTest
@testable import StrapiSwiftCross

public class ResetPasswordRequestTests: XCTestCase {
    // MARK: - Functions
    
    /// Requests creating a new ResetPasswordRequest.
    func testResetPasswordRequest() {
        let body = """
            { "code": 1234, "password": password, "passwordConfirmation": password }
        """
        
        let request = ResetPasswordRequest(code: "1234", password: "password", passwordConfirmation: "password")
        XCTAssertEqual(request.method, .post)
        XCTAssertEqual(request.contentType, "auth")
        XCTAssertEqual(request.path, "/reset-password")
        XCTAssertEqual(request.body, body)
    }
}
