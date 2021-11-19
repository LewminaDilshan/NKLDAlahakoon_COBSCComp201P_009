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
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Your email or password are incorrect.Please try again", comment: "")
            default:
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
