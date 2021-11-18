//
//  LogInViewModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-07.
//

import Foundation
import FirebaseAuth
import Firebase

class LogInViewModel : ObservableObject{
    
    let auth = Auth.auth()
    @Published var userModel = UserModel()
    @Published var credentials = Credentials()
    @Published var loggedIn = false
    @Published var showProgressView = false
    @Published var error: Authentication.AuthenticationError?
    
    var isLoggedIn: Bool{
        return auth.currentUser != nil
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        AuthService.shared.login(credentials: credentials){[unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                userModel = UserModel()
                error = authError
                completion(false)
            }
        }
    }
    
    func signup(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        AuthService.shared.signup(credentials: credentials, userM: userModel){[unowned self](result:Result<Bool, Authentication.AuthenticationError>) in
            showProgressView = false
            switch result {
            case .success:
                completion(true)
            case .failure(let authError):
                userModel = UserModel()
                error = authError
                completion(false)
            }
        }
    }
}
