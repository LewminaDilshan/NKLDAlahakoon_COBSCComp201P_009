//
//  BookingView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-17.
//

import SwiftUI
import UIKit

struct BookingView: View {
    @StateObject private var bookingViewModel = BookingViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (alignment: .leading){
                    Group{
                        Text("Registration No")
                            .foregroundColor(.blue)
                        TextField("First Name", text: $bookingViewModel.bookingModel.RegNo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                        
                        Text("Vehicle No")
                            .foregroundColor(.blue)
                        TextField("Last Name", text: $bookingViewModel.bookingModel.VehicleNo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                        
                        Spacer()
                        Spacer()
                        Divider()
                        Spacer()
                        Text("Pic a slot")
                            .foregroundColor(.blue)
                        Picker(selection: $bookingViewModel.bookingModel.SlotID, label: Text("Pic a slot")){
                            ForEach(bookingViewModel.slotLst){SlotModel in
                                HStack{
                                    Text(String(SlotModel.slotNo))
                                    if(SlotModel.isVIP)
                                    {
                                        Text(" - VIP")
                                            .foregroundColor(.purple)
                                    }
                                }
                            }
                        }.pickerStyle(WheelPickerStyle())
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
                    }
                    
                    Button(action: {
                        handleAction()
                    }) {
                        HStack{
                            Spacer()
                            if (bookingViewModel.showProgressView) {
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            }
                            Text("Book")
                                .fontWeight(.bold)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 10)
                            Spacer()
                        }.background(Color.blue)
                    }
                    .alert(isPresented: $bookingViewModel.isSuccess) {
                        Alert(title: Text("Success"), message: Text(bookingViewModel.isSuccess ? "Slot Reserved" : "Something wrong..."))
                    }
                    
                }
                .navigationTitle("Bookings")
            }
            .padding()
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
    
    private func handleAction(){
        
        bookingViewModel.setBooking { success in
            bookingViewModel.isSuccess = success
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
