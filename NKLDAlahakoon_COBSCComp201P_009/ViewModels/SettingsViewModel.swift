//
//  SettingsViewModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-16.
//

import Foundation
import FirebaseAuth
import Firebase

class SettingsViewModel : ObservableObject{
    @Published var userModel = UserModel()
    let db = Firestore.firestore()
    
    func setUserInfo(){
        let user = Auth.auth().currentUser
        let docRef = db.collection("UserInfo").whereField("UID", isEqualTo: user!.uid)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.userModel.firstName = data["First Name"] as! String
                    self.userModel.lastName = data["Last Name"] as! String
                    self.userModel.NIC = data["NIC"] as! String
                    self.userModel.UID = data["UID"] as! String
                    self.userModel.VehicleNo = data["VehicleNo"] as! String
                    self.userModel.RegNo = document.documentID
                }
            }
        }
    }
    
    init(){
        setUserInfo()
    }
}
