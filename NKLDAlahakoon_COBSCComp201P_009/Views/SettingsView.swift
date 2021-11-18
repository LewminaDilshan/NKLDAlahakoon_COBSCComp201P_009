//
//  SettingsView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-16.
//

import SwiftUI
import UIKit

struct SettingsView: View {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @EnvironmentObject var authentication: Authentication
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack (alignment: .leading){
                    Text("First Name")
                        .foregroundColor(.blue)
                    TextField("First Name", text: $settingsViewModel.userModel.firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    
                    Text("Last name")
                        .foregroundColor(.blue)
                    TextField("Last Name", text: $settingsViewModel.userModel.lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    
                    Text("NIC")
                        .foregroundColor(.blue)
                    TextField("NIC", text: $settingsViewModel.userModel.NIC)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    
                    Text("Registration No")
                        .foregroundColor(.blue)
                    TextField("Registration No", text: $settingsViewModel.userModel.RegNo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                    
                    Text("Vehicle No")
                        .foregroundColor(.blue)
                    TextField("Vehicle No", text: $settingsViewModel.userModel.VehicleNo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                }
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button("Log Out"){
                            authentication.updateValidation(success: false)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
