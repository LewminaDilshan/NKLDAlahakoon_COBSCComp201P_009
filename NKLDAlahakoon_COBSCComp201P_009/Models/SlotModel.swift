//
//  SlotModel.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-16.
//

import Foundation

struct SlotModel : Identifiable, Codable{
    var id : String
    var slotNo: Int
    var isVIP: Bool
    var isBooked: Bool
    var vehicleNo: String
    var ReservedTime: Date?
    var RemainingTime: Int
}
