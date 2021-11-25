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
        db.collection("ParkingSlots").order(by: "SlotNo").addSnapshotListener { (querySnapshot, error) in
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
                let dateCurr = Date()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                let reservedTime = formatter.date(from: self.dateFormatTime(date: resTime.dateValue()))
                let currTime = formatter.date(from: self.dateFormatTime(date: dateCurr))
                let diff = Calendar.current.dateComponents([.second], from: reservedTime ?? Date(), to: currTime ?? Date())
                
                let remTime = Int(600 - (diff.second ?? 0))
                
                if(isBooked)
                {
                    _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(remTime), repeats: true, block: { timer in
                        self.updateSlot(slotId: id, timer: timer)
                    })
                }
                
                return SlotModel(id: id, slotNo: slotNo, isVIP: isVIP, isBooked: isBooked, vehicleNo: vehicleNo, ReservedTime: resTime.dateValue(), RemainingTime: remTime)
            }
        }
    }
    
    
    func dateFormatTime(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    func updateSlot(slotId: String, timer: Timer){
        self.db.collection("ParkingSlots").document(slotId).updateData([
            "IsBooked" : false
        ]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                timer.invalidate()
                print("Slot successfully Updated!")
            }
        }
    }
    
    init(){
        //IntialSlotData()
        slotLst.removeAll()
        GetSolts()
    }
}
