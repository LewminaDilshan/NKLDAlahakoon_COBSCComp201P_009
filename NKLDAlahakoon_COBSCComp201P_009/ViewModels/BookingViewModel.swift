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
    let db = Firestore.firestore()
    
}
