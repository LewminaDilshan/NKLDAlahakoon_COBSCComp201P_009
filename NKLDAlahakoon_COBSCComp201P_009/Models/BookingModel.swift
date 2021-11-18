//
//  BookingModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-17.
//

import Foundation

struct BookingModel : Codable{
    var UID: String = ""
    var RegNo: String = ""
    var VehicleNo: String = ""
    var SlotNo: String = ""
    var BookingDate: Date? = nil
    var BookingTime: Date? = nil
}
