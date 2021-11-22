//
//  AuthServiceSpec.swift
//  NKLDAlahakoon_COBSCComp201P_009Tests
//
//  Created by Lewmina Dilshan on 2021-11-22.
//

import XCTest

@testable import NKLDAlahakoon_COBSCComp201P_009

class AuthServiceSpec: XCTestCase {
    
    var viewModel : LogInViewModel!
    var mockAuthService : AuthServiceMock!
    
    override func setUp() {
        mockAuthService = AuthServiceMock()
        viewModel = .init(authSerive: mockAuthService)
    }
    
    func testSignInWithCorrectDetails(){
        viewModel.login{success in}
        XCTAssertTrue(viewModel.isLoggedIn)
    }
}

