//
//  AuthServiceMock.swift
//  NKLDAlahakoon_COBSCComp201P_009Tests
//
//  Created by Lewmina Dilshan on 2021-11-22.
//

import Foundation
@testable import NKLDAlahakoon_COBSCComp201P_009

final class AuthServiceMock : AuthServiceProtocol{
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
       //completion(.success(()))
    }
}
