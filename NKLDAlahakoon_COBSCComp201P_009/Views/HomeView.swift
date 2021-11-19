//
//  HomeView.swift
//  NKLDAlahakoon_COBSCComp201P_009
//
//  Created by Lewmina Dilshan on 2021-11-16.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                GridView(Data: homeViewModel.slotLst)
            }
            .navigationTitle("Home")
            .background(Color(.init(white: 0, alpha: 0.05)).ignoresSafeArea())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct GridView : View {
    var Data : [SlotModel]
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    var body: some View{
        LazyVGrid(columns: layout){
            ForEach(Data){SlotModel in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                    VStack{
                        if(SlotModel.isVIP){
                            Image("VIP")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        else{
                            Image("Normal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        HStack{
                            Text("Slot No :")
                            Text(String(SlotModel.slotNo))
                        }
                        if(SlotModel.isBooked)
                        {
                            Text("Reserved")
                            Text(SlotModel.vehicleNo)
                        }
                        else{
                            Text("Available")
                            Spacer()
                        }
                    }
                    .border(SlotModel.isBooked ? Color(.black) : Color.secondary)
                    .background(SlotModel.isBooked ? Color(.red) : Color(.cyan))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius:5, x: 0, y: 5)
                    .padding(.bottom,10)
                }
                
            }
        }
        .padding(.horizontal)
        .padding(.top,25)
    }
}
