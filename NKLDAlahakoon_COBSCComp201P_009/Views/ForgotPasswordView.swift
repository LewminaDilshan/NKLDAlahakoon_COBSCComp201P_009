//
//  ForgotPasswordView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-19.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var logInViewModel = LogInViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16) {
                    TextField("Please enter your email..", text: $logInViewModel.fogotPassModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(12)
                        .background(Color.white)
                    
                    Button(action: {
                        handleAction()
                    }) {
                        HStack{
                            Spacer()
                            if (logInViewModel.showProgressView) {
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            }
                            Text("Send the link")
                                .fontWeight(.bold)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }.background(Color.blue)
                    }
                }
                .navigationTitle("Forgot Password")
                .navigationBarBackButtonHidden(false)
                .alert(item: $logInViewModel.error) {error in
                    Alert(title: Text("Error"), message: Text(error.localizedDescription))
                }
            }
            .padding()
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
    private func handleAction(){
        
        logInViewModel.forgotPass{ success in
            authentication.updateValidation(success: false)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
