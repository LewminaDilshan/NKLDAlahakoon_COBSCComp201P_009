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
    
    @Published var loggedIn = false
    @Published var showProgressView = false
    
    var isLoggedIn: Bool{
           return auth.currentUser != nil
       }
    
    func HandleLogIn(user : UserModel) -> Bool {
        var IsError = false
        showProgressView = true
        auth.signIn(withEmail: user.email, password: user.password){ [unowned self](authResult, error) in
            showProgressView = false
            if let error = error as NSError? {
                IsError = true
              switch AuthErrorCode(rawValue: error.code) {
                  case .operationNotAllowed:
                    print("Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
                  case .userDisabled:
                    print("Error: The user account has been disabled by an administrator.")
                  case .wrongPassword:
                    print("Error: The password is invalid or the user does not have a password.")
                  case .invalidEmail:
                    print("Error: Indicates the email address is malformed.")
                  default:
                      print("Error: \(error.localizedDescription)")
                  }
            }
            else {
                DispatchQueue.main.async {
                    print("User signs in successfully")
                    self.loggedIn = true
                }
            }
        }
        return IsError
    }
    
    func HandleSignUp(userM : UserModel) -> Bool {
        showProgressView = true
        let db = Firestore.firestore()
    var IsError = false
    Auth.auth().createUser(withEmail: userM.email, password: userM.password){ [unowned self](authResult, error) in
        showProgressView = false
            if let error = error as NSError? {
                IsError = true
              switch AuthErrorCode(rawValue: error.code) {
                  case .operationNotAllowed:
                    print("Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.")
                  case .emailAlreadyInUse:
                    print("Error: Email Address already used.")
                  case .weakPassword:
                    print("Error: The password is week.")
                  default:
                      print("Error: \(error.localizedDescription)")
                  }
            } else {
                let user = Auth.auth().currentUser
                
                if let user = user {
                    let userId = user.uid
                    let objUser :[String: Any] = [
                        "UserID" : userId,
                        "First Name" : userM.firstName,
                        "Last Name" : userM.lastName,
                    ]
                    db.collection("UserInfo").document(userId).setData(objUser) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
            }
        }
        return IsError
    }
}
