//
//  ContentView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-07.
//

import SwiftUI

struct ContentView : View {
    @StateObject var authentication = Authentication()
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            if(authentication.isValidated)
            {
                BookingView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Bookings")
                    }
                
                SettingsView()
                    .environmentObject(authentication)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            else {
                
                LogInView()
                    .environmentObject(authentication)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Bookings")
                    }
                
                LogInView()
                    .environmentObject(authentication)
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            
        }.background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
