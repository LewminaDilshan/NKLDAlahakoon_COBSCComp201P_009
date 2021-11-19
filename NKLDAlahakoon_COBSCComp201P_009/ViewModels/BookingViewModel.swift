//
//  BookingViewModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-18.
//

import Foundation
import FirebaseAuth
import Firebase

class BookingViewModel : ObservableObject{
    @Published var bookingModel = BookingModel()
    @Published var slotLst = [SlotModel]()
    @Published var showProgressView = false
    @Published var isSuccess: Bool = false
    let db = Firestore.firestore()
    
    func setBookingInfo(){
        let user = Auth.auth().currentUser
        let docRef = db.collection("UserInfo").whereField("UID", isEqualTo: user!.uid)
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    self.bookingModel.UID = data["UID"] as! String
                    self.bookingModel.VehicleNo = data["VehicleNo"] as! String
                    self.bookingModel.RegNo = document.documentID
                }
            }
        }
    }
    
    func GetSoltsForPicker(){
        db.collection("ParkingSlots").whereField("IsBooked", isEqualTo: false).order(by: "SlotNo").addSnapshotListener { (querySnapshot, error) in
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
                let vehicleNo = data["VehicleNo"] as? String ?? ""
                return SlotModel(id: id, slotNo: slotNo, isVIP: isVIP, isBooked: isBooked, vehicleNo: vehicleNo)
            }
        }
    }
    
    func setBooking(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        let objBooking :[String: Any] = [
            "UID" : bookingModel.UID,
            "SlotID" : bookingModel.SlotID,
            "VehicleNo" : bookingModel.VehicleNo,
            "RegNo" : bookingModel.RegNo,
            "ReservedTime": FieldValue.serverTimestamp()
        ]
        self.db.collection("Bookings").document().setData(objBooking) { err in
            self.showProgressView = false
            if let err = err {
                print("Error writing document: \(err)")
                completion(false)
            } else {
                print("Document successfully written!")
                self.db.collection("ParkingSlots").document(self.bookingModel.SlotID).updateData([
                    "IsBooked" : true,
                    "VehicleNo" : self.bookingModel.VehicleNo,
                    "ReservedTime": FieldValue.serverTimestamp()
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        completion(false)
                    } else {
                        print("Slot successfully Updated!")
                        completion(true)
                    }
                }
            }
        }
    }
    
    init(){
        slotLst.removeAll()
        setBookingInfo()
        GetSoltsForPicker()
    }
}
