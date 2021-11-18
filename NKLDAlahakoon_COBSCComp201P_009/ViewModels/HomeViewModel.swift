//
//  HomeViewModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-16.
//

import Foundation
import FirebaseAuth
import Firebase

class HomeViewModel : ObservableObject{
    @Published var slotLst = [SlotModel]()
    let db = Firestore.firestore()
    
/*    func getParkingSlots(){
        db.collection("ParkingSlots").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    var slot = Slot()
                    slot.slotNo = data["SlotNo"] as! Int
                    slot.isVIP = data["SlotNo"] as! Bool
                    slot.isBooked = data["SlotNo"] as! Bool
                    self.slotLst.append(slot)
                }
            }
        }
    }*/
    
    
    func IntialSlotData() {
        for n in 1...20 {
            db.collection("ParkingSlots").document().setData([
                "SlotNo": n,
                "IsVIP": false,
                "IsBooked": false
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func GetSolts(){
        slotLst.removeAll()
        db.collection("ParkingSlots").addSnapshotListener { (querySnapshot, error) in
                 guard let documents = querySnapshot?.documents else {
                     print("No documents")
                     return
                 }
                 self.slotLst = documents.map { (queryDocumentSnapshot) -> SlotModel in
                     let data = queryDocumentSnapshot.data()
                     let id = queryDocumentSnapshot.documentID
                     let slotNo = data["SlotNo"] as? Int ?? 0
                     let isVIP = data["IsVIP"] as? Bool ?? false
                     let isBooked = data["IsBooked"] as? Bool ?? false
                    return SlotModel(id: id, slotNo: slotNo, isVIP: isVIP, isBooked: isBooked)
                 }
             }
    }
    
    init(){
        //IntialSlotData()
        GetSolts()
    }
}
