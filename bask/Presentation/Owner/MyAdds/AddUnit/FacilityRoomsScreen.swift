//
//  FacilityRoomsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct FacilityRoomsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var addNewUnitViewModel: AddNewUnitViewModel
//    = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    @State var progress: Float = 0.166 // total 12 steps therefore each one is 0.083
    @State var length: String = ""
    @State var isValid: Bool = true
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0) {
            
            Text("Rooms")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
          
            
            ScrollView {
                RoomSizeView(label: "Size of facility", length: $addNewUnitViewModel.facility.length, width: $addNewUnitViewModel.facility.width, validLength: $isValid, validWidth: $isValid)
                    .padding(.horizontal, 1)
                
                
                
                AmenityCounterView(counter: $addNewUnitViewModel.roomsCount, label: "Living rooms"){
                    addNewUnitViewModel.removeRoom()
                } onIncrease: {
                    addNewUnitViewModel.addRoom()
                }
                
                //if !addNewUnitViewModel.rooms.isEmpty {
                //ScrollView{
                LazyVStack(alignment: .leading){
                    ForEach(addNewUnitViewModel.rooms.indices, id:\.self) { index in
                        
                        RoomSizeView(label: "Living room \(index + 1)", length: $addNewUnitViewModel.rooms[index].length, width: $addNewUnitViewModel.rooms[index].width, validLength: $addNewUnitViewModel.rooms[index].validLength, validWidth: $addNewUnitViewModel.rooms[index].validWidth)
                            .padding([.top, .leading, .trailing], 2)
                            .padding(.bottom)
                        
                    }
                }
                //}        //.background(Color(AppColor.BACKGROUND))
                //}
                
                
                
                AmenityCounterView(counter: $addNewUnitViewModel.facility.kitchen, label: "Kitchen") {
                    addNewUnitViewModel.decreaseKitchenCount()
                } onIncrease: {
                    addNewUnitViewModel.increaseKitchenCount()
                }.padding(.bottom)
                
                //ScrollView{
                LazyVStack(alignment: .leading){
                    ForEach(addNewUnitViewModel.kitchen.indices, id:\.self) { index in
                        
                        RoomSizeView(label: "Kitchen \(index)", length: $length, width: $length, validLength: $isValid, validWidth: $isValid)
                            .padding([.top, .leading, .trailing], 2)
                            .padding(.bottom)
                        
                    }
                }
                //}.background(Color(AppColor.BACKGROUND))
                
                AmenityCounterView(counter: $addNewUnitViewModel.facility.bathrooms, label: "Bathroom") {
                    addNewUnitViewModel.decreaseBathroomCount()
                } onIncrease: {
                    addNewUnitViewModel.increaseBathroomCount()
                }.padding(.bottom)
                
                AmenityCounterView(counter: $addNewUnitViewModel.facility.showers, label: "Shower") {
                    addNewUnitViewModel.decreaseShowersCount()
                } onIncrease: {
                    addNewUnitViewModel.increaseShowersCount()
                }.padding(.bottom)
                
                AmenityCounterView(counter: $addNewUnitViewModel.facility.capacity, label: "Capacity") {
                    addNewUnitViewModel.decreaseCapacityCount()
                } onIncrease: {
                    addNewUnitViewModel.increaseCapacityCount()
                }.padding(.bottom)
                
                
                NavigationLink(destination:
                                FacilityFreeAmenitiesScreen()
                                .environmentObject(addNewUnitViewModel), isActive: $addNewUnitViewModel.willShowFreeAmenitiesScreen) {
                    EmptyView()
                }
                
                HStack {
                    Text("How many peole can be\nhosted in a facility ")
                    
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .lineLimit(2)
                    Spacer()
                }
                
            }
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                addNewUnitViewModel.onContinueTapped()
                
                
            }.padding(.top, -24)
            
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading:
                Button(action : {
                    print("Back button tapped")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(AppColor.GREY))
                    
                },
            trailing: Button(action : {
                print("Back button tapped")
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Exit")
                    .font(Font.custom("Poppins-Light", size: 16.0))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                
            })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                HStack{
                    
                    LinearProgressBar(value: $progress)
                        .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/100)
                    
                }
            }
        }
        
    }
}

struct FacilityRoomsScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityRoomsScreen()
    }
}

struct RoomSizeView: View {
    
    let label: String
    @Binding var length: String
    @Binding var width: String
    @Binding var validLength: Bool
    @Binding var validWidth: Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(label)
                .font(Font.custom("Poppins-Regular", size: 16.0))
            
            HStack {
                MaterialLengthField(text: $length, isValid: $validLength, errorMessage: "valid_room_length", placeHolder: "x-meters")
                
                Image(systemName: "multiply")
                
                MaterialLengthField(text: $width, isValid: $validWidth, errorMessage: "valid_room_length", placeHolder: "y-meters")
            }
        }
    }
}
