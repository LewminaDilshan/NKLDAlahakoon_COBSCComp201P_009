//
//  AuthService.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-15.
//

import Foundation
import FirebaseAuth
import Firebase

protocol AuthServiceProtocol{
    func login(credentials: Credentials, completion: @escaping (Result<Bool,  Authentication.AuthenticationError>)->  Void )
}

final class AuthService: AuthServiceProtocol{
    
    let auth = Auth.auth()
    static let shared = AuthService()
    let db = Firestore.firestore()
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.auth.signIn(withEmail: credentials.email, password: credentials.password){ (authResult, error) in
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .operationNotAllowed:
                        completion(.failure(.operationNotAllowed))
                    case .userDisabled:
                        completion(.failure(.userDisabled))
                    case .wrongPassword:
                        completion(.failure(.invalidCredentials))
                    case .invalidEmail:
                        completion(.failure(.invalidEmail))
                    default:
                        completion(.failure(.ukError))
                    }
                }
                else{
                    completion(.success(true))
                }
            }
        }
    }
    
    func signup(credentials: Credentials, userM: UserModel, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if userM.firstName == "" || userM.lastName == "" || userM.NIC == "" || userM.VehicleNo == "" || credentials.email == ""
            {
                completion(.failure(.required))
            }
            else if credentials.password != credentials.confirmPass
            {
                completion(.failure(.invalidCredentials))
            }
            else{
                self.auth.createUser(withEmail: credentials.email, password: credentials.password){ (authResult, error) in
                    if let error = error as NSError? {
                        switch AuthErrorCode(rawValue: error.code) {
                        case .operationNotAllowed:
                            completion(.failure(.operationNotAllowed))
                        case .emailAlreadyInUse:
                            completion(.failure(.emailAlreadyInUse))
                        case .weakPassword:
                            completion(.failure(.weakPassword))
                        default:
                            completion(.failure(.ukError))
                        }
                    } else {
                        let user = Auth.auth().currentUser
                        
                        if let user = user {
                            let userId = user.uid
                            let objUser :[String: Any] = [
                                "UID" : userId,
                                "First Name" : userM.firstName,
                                "Last Name" : userM.lastName,
                                "NIC" : userM.NIC,
                                "VehicleNo" : userM.VehicleNo,
                            ]
                            self.db.collection("UserInfo").document().setData(objUser) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                        }
                        completion(.success(true))
                    }
                }
            }
        }
    }
    
    func forgotPassword(fogotPass: ForgotPasswordModel, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.auth.sendPasswordReset(withEmail: fogotPass.email){(error) in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(.ukError))
                    }
                    else{
                        completion(.success(true))
                    }
                }
                
            }
        }
    }
}
