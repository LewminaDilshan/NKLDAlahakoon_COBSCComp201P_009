//
//  LogInView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-07.
//

import SwiftUI
import UIKit

struct LogInView: View {
    @StateObject var userModel = UserModel()
    @StateObject var logInViewModel = LogInViewModel()
    @State var isLoginMode = true
    @State private var showingAlert = false
    
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
                        TextField("First Name", text: $userModel.firstName)

                        TextField("Last Name", text: $userModel.lastName)
                        }
                        TextField("Email", text: $userModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $userModel.password)
                        
                        if(!isLoginMode){
                            SecureField("Confirm Password", text: $userModel.confirmPass)
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
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Invalid username / password"), dismissButton: .default(Text("Got it!")))
                    }
                    
                    if(isLoginMode){
                        Button(action: {}, label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color.blue)
                                .fontWeight(.light)
                        })
                    }
                    
                    Spacer()
                    Button(action: {}, label: {
                        Text("Terms & Conditions")
                            .foregroundColor(Color.black)
                    })
                }
                .navigationTitle(isLoginMode ? "Log In" : "Create Account")
                .navigationBarBackButtonHidden(false)
            }
            .padding()
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
    private func handleAction(){
        if isLoginMode{
            showingAlert = logInViewModel.HandleLogIn(user : userModel)
        } else {
            showingAlert = logInViewModel.HandleSignUp(userM : userModel)
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
