//
//  BookingViewModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-18.
//

import Foundation
import FirebaseAuth
import Firebase
import CoreLocation

class BookingViewModel : ObservableObject{
    @Published var bookingModel = BookingModel()
    @Published var slotLst = [SlotModel]()
    @Published var showProgressView = false
    @Published var isSuccess: Bool = false
    @Published var isError: Bool = false
    let db = Firestore.firestore()
    let locationSer = LocationService()
    
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
        db.collection("ParkingSlots").whereField("IsBooked", isEqualTo: false).addSnapshotListener { (querySnapshot, error) in
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
                let resTime = data["ReservedTime"] as? Timestamp ?? Timestamp()
                
                return SlotModel(id: id, slotNo: slotNo, isVIP: isVIP, isBooked: isBooked, vehicleNo: vehicleNo, ReservedTime: resTime.dateValue(), RemainingTime: 0)
            }
            self.bookingModel.SlotID = self.slotLst.first?.id ?? ""
        }
    }
    
    func saveBooking(completion: @escaping (Bool) -> Void) {
        showProgressView = true
        if(GetDistance() < 1){
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
        else{
            self.showProgressView = false
            print("Not in range")
            completion(false)
        }
    }
    
    func GetDistance() -> Double{
        let Location_NIBM = CLLocation(latitude: 6.9065, longitude: 79.8707)
        
        let userLocationInRange = CLLocation(latitude: 6.9027, longitude: 79.8688)
        
        let userLocationOutOfRange = CLLocation(latitude: 6.8911, longitude: 79.8668)
        
        _ = CLLocation(latitude:Double(locationSer.location?.latitude ?? 0), longitude: Double(locationSer.location?.longitude ?? 0))
        
        let distance = Location_NIBM.distance(from: userLocationInRange)/1000
        //let distance = Location_NIBM.distance(from: userLocationOutOfRange)/1000
        
        print("Distance difference : ", distance)
        
        return distance
    }
    
    init(){
        slotLst.removeAll()
        GetSoltsForPicker()
        setBookingInfo()
    }
}
