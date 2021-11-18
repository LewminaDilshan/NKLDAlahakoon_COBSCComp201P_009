//
//  BookingView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-17.
//

import SwiftUI

struct BookingView: View {
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
                }
            }
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
