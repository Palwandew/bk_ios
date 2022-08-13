//
//  FacilityFreeAmenitiesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/08/2022.
//

import SwiftUI

struct FacilityFreeAmenitiesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var addNewUnitViewModel: AddNewUnitViewModel
    @StateObject var addNewUnitViewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    
    @State var progress: Float = 0.249 // total 12 steps therefore each one is 0.083
    @State var isWifiOn: Bool = false
    @State var isParkingOn: Bool = true
    @State var indoorSwimmingPools: Int = 0
    @State var length: String = ""
    @State var isValid: Bool = true
    @State var showPaid: Bool = false
    @State var isOn: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            
            
            //MARK: - Title
            
            
            Text("Amenities (free)")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                //MARK: - Wifi
                
                AmenityToggle(isOn: $addNewUnitViewModel.facility.wifi, label: "Wifi")
                
                
                //MARK: - Parking
                
                AmenityToggle(isOn: $addNewUnitViewModel.facility.parking, label: "Parking")
                
                
                //MARK: - Indoor Pools
                
                AmenityCounterView(counter: $indoorSwimmingPools, label: "Indoor swimming pool") {
                    addNewUnitViewModel.removeIndoorSwimmingPool()
                } onIncrease: {
                    addNewUnitViewModel.addIndoorSwimmingPool()
                }
                
                LazyVStack(alignment: .leading){
                    ForEach($addNewUnitViewModel.facility.freeIndoorSwimmingPools) { $pool in
                        
                        RoomSizeView(label: "Indoor pool", length: $pool.length, width: $pool.width, validLength: $pool.validLength, validWidth: $pool.validWidth)
                            .padding([.top, .leading, .trailing], 2)
                            .padding(.bottom)
                        
                    }
                }
                
                
                //MARK: - Outdoor Pools
                
                AmenityCounterView(counter: $indoorSwimmingPools, label: "Outdoor swimming pool") {
                    addNewUnitViewModel.removeOutdoorSwimmingPool()
                } onIncrease: {
                    addNewUnitViewModel.addOutdoorSwimmingPool()
                }
                
                LazyVStack(alignment: .leading){
                    ForEach($addNewUnitViewModel.facility.freeOutdoorSwimmingPools) { $pool in
                        
                        RoomSizeView(label: "Outdoor pool", length: $pool.length, width: $pool.width, validLength: $pool.validLength, validWidth: $pool.validWidth)
                            .padding([.top, .leading, .trailing], 2)
                            .padding(.bottom)
                        
                    }
                }
                
                
                //MARK: - Checkboxes
                
                Group {
                    Toggle(isOn: $isOn) {
                        Text("Outdoor sitting")
                    }.toggleStyle(Checkbox())
                        
                    
                    Toggle(isOn: $isOn) {
                        Text("Barbeque area")
                    }.toggleStyle(Checkbox())
                    
                    
                    Toggle(isOn: $isOn) {
                        Text("Gym")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $isOn) {
                        Text("Games room")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $isOn) {
                        Text("Garden")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $isOn) {
                        Text("Playing field")
                    }.toggleStyle(Checkbox())
                }.padding(.trailing, 1)
                    .padding(.bottom)
                
                NavigationLink(destination:
                                FacilityPaidAmenitiesScreen(), isActive: $showPaid) {
                    EmptyView()
                }
                
            })
            
            //MARK: - Continue Button
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
//                print("tapped")
//                showPaid.toggle()
                addNewUnitViewModel.validateFreeAmenities()
                
                
            }//.padding(.top, -24)
        
        }.padding(.horizontal)
            .background(Color(AppColor.BACKGROUND))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action : {
                        print("Back button tapped")
                        //self.dismiss.callAsFunction()
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(AppColor.GREY))
                        
                    },
                trailing: Button(action : {
                    print("Back button tapped")
                    self.presentationMode.wrappedValue.dismiss()
//                    self.dismiss.callAsFunction()
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

struct FacilityFreeAmenitiesScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        FacilityFreeAmenitiesScreen()
    }
}

struct AmenityToggle: View {
    
    @Binding var isOn: Bool
    let label: String
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(label)
                .font(Font.custom("Poppins-Regular", size: 16))
                .fontWeight(.regular)
        }.toggleStyle(AccentGreen())
    }
}
