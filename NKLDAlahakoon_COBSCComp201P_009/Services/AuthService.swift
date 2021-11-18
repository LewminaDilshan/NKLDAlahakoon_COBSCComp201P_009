//
//  AuthService.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-15.
//

import Foundation
import FirebaseAuth
import Firebase

class AuthService{
    let auth = Auth.auth()
    static let shared = AuthService()
    let db = Firestore.firestore()
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.auth.signIn(withEmail: credentials.email, password: credentials.password){ (authResult, error) in
                if let error = error as NSError? {
                    completion(.failure(.invalidCredentials))
                    print("Authentication error...")
                }
                else{
                    completion(.success(true))
                    print("Something wrong...")
                }
            }
        }
    }
    
    func signup(credentials: Credentials, userM: UserModel, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if credentials.password != credentials.confirmPass
            {
                completion(.failure(.invalidCredentials))
            }
            else{
                self.auth.createUser(withEmail: credentials.email, password: credentials.password){ (authResult, error) in
                    if let error = error as NSError? {
                        completion(.failure(.invalidCredentials))
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
}
