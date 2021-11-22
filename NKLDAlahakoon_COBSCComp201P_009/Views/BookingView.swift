//
//  BookingView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-17.
//

import SwiftUI
import UIKit
import CodeScanner

struct BookingView: View {
    @StateObject private var bookingViewModel = BookingViewModel()
    @State var isPerentingScanner = false
    
    var scannerSheet: some View{
        CodeScannerView(codeTypes: [.qr], completion: {
            result in
            if case let .success(code) = result{
                bookingViewModel.bookingModel.SlotID = code
                self.isPerentingScanner = false
                handleAction()
            }
        })
        .alert(isPresented: $bookingViewModel.isSuccess) {
            Alert(title: Text("Success"), message: Text("Slot Reserved"))
        }
    }
    
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
                        Text("Pick a slot")
                            .foregroundColor(.blue)
                        Picker(selection: $bookingViewModel.bookingModel.SlotID, label: Text("Pick a slot")){
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
                        Alert(title: Text("Success"), message: Text("Slot Reserved"))
                    }
                }
                .navigationTitle("Bookings")
                
                VStack{
                    Button("Scan QR code"){
                        self.isPerentingScanner = true
                    }
                    .sheet(isPresented: $isPerentingScanner)
                    {
                        self.scannerSheet
                    }
                }
            }
            .padding()
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
    
    private func handleAction(){
        
        bookingViewModel.saveBooking { success in
            bookingViewModel.isSuccess = success
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
