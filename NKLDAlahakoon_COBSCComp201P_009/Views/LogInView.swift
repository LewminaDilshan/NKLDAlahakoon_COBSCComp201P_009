//
//  LogInView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-07.
//

import SwiftUI
import UIKit

struct LogInView: View {
    @StateObject private var logInViewModel = LogInViewModel()
    @State var isLoginMode = true
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")){
                        Text("Log In").tag(true)
                        Text("Create Account").tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    if(!isLoginMode){
                        Image(systemName: "person.fill")
                            .font(.system(size: 64)).padding()
                    }
                    
                    Group{
                        if(!isLoginMode){
                            TextField("First Name", text: $logInViewModel.userModel.firstName)
                            TextField("Last Name", text: $logInViewModel.userModel.lastName)
                            TextField("NIC No", text: $logInViewModel.userModel.NIC)
                            TextField("Vehicle No", text: $logInViewModel.userModel.VehicleNo)
                        }
                        TextField("Email", text: $logInViewModel.credentials.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $logInViewModel.credentials.password)
                        
                        if(!isLoginMode){
                            SecureField("Confirm Password", text: $logInViewModel.credentials.confirmPass)
                        }
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button(action: {
                        handleAction()
                    }) {
                        HStack{
                            Spacer()
                            if logInViewModel.showProgressView {
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            }
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .fontWeight(.bold)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }.background(Color.blue)
                    }
                    
                    if(isLoginMode){
                        NavigationLink("Forgot Password?", destination:ForgotPasswordView().environmentObject(authentication))
                    }
                    
                    Spacer()
                    NavigationLink("Terms & Conditions", destination:TermsAndConditionView())
                        .foregroundColor(.black)
                }
                .navigationTitle(isLoginMode ? "Log In" : "Create Account")
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
        if isLoginMode{
            logInViewModel.login { success in
                authentication.updateValidation(success: success)
            }
        } else {
            logInViewModel.signup { success in
                authentication.updateValidation(success: success)
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
