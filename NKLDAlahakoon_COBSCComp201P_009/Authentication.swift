//
//  Authentication.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-15.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case invalidEmail
        case userDisabled
        case ukError
        case emailAlreadyInUse
        case weakPassword
        case operationNotAllowed
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self {
            case .operationNotAllowed:
                return NSLocalizedString("Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.", comment: "")
            case .userDisabled:
                return NSLocalizedString("The user account has been disabled by an administrator.", comment: "")
            case .invalidCredentials:
                return NSLocalizedString("Your email or password are incorrect.Please try again", comment: "")
            case .invalidEmail:
                return NSLocalizedString("Email is invalid.", comment: "")
            case .emailAlreadyInUse:
                return NSLocalizedString("Email Address already used.", comment: "")
            case .weakPassword:
                return NSLocalizedString("The password is week.", comment: "")
            case .ukError:
                return NSLocalizedString("Something wrong...", comment: "")
            }
        }
    }
    
    
    func updateValidation(success: Bool) {
        withAnimation{
            isValidated = success
        }
    }
}
