//
//  NKLDAlahakoon_COBSCComp201P_009App.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-07.
//

import SwiftUI
import Firebase

@main
struct NKLDAlahakoon_COBSCComp201P_009App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            LogInView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Setting up Firebase")
        FirebaseApp.configure()
        return true
    }
}
