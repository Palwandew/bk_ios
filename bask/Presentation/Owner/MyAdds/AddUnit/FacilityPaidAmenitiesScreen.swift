//
//  FacilityPaidAmenitiesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 03/08/2022.
//

import SwiftUI

struct FacilityPaidAmenitiesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var addNewUnitViewModel: AddNewUnitViewModel
    @StateObject var addNewUnitViewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))

    @State var progress: Float = 0.249 // total 12 steps therefore each one is 0.083
    @State var isWifiOn: Bool = false
    @State var isParkingOn: Bool = true
    @State var indoorSwimmingPools: Int = 0
    @State var outdoorSwimmingPools: Int = 0
    @State var length: String = ""
    @State var isValid: Bool = true
    @State var isOn: Bool = false
    
    @State var showRules: Bool = false 
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            
            //MARK: - Title
            
            
            Text("Amenities (paid)")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                //MARK: - Wifi
                
                AmenityToggle(isOn: $addNewUnitViewModel.facility.paidAmenities.wifi, label: "Wifi")
                
                if addNewUnitViewModel.facility.paidAmenities.wifi {
                    AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.wifiService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.wifiService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.wifiService.description)
                }
                
                
                //MARK: - Parking
                
                AmenityToggle(isOn: $addNewUnitViewModel.facility.paidAmenities.parking, label: "Parking")
                
                if addNewUnitViewModel.facility.paidAmenities.parking {
                    AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.parkingService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.parkingService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.parkingService.description)
                }
                
                //MARK: - Indoor Pools
                
                AmenityCounterView(counter: $addNewUnitViewModel.facility.paidAmenities.indoorPools, label: "Indoor swimming pool") {
                    UIApplicationHelper.dimissKeyboard()
                    addNewUnitViewModel.removePaidIndoorSwimmingPool()
                    
                } onIncrease: {
                    addNewUnitViewModel.addPaidIndoorSwimmingPool()
                }
                
                LazyVStack(alignment: .leading){
                    ForEach($addNewUnitViewModel.facility.paidAmenities.indoorSwimmingPools) { $pool in
                        
                        AmenityPriceLengthInputView(text: $pool.price, isValid: $pool.validPrice, length: $pool.length, width: $pool.width, validLength: $pool.validLength, validWidth: $pool.validWidth)
                            .padding(.trailing, 1)
                        
                    }
                }
                
                
                //MARK: - Outdoor Pools
                
                AmenityCounterView(counter: $addNewUnitViewModel.facility.paidAmenities.outdoorPools, label: "Outdoor swimming pool") {
                    UIApplicationHelper.dimissKeyboard()
                    addNewUnitViewModel.removePaidOutdoorSwimmingPool()
                } onIncrease: {
                    addNewUnitViewModel.addPaidOutdoorSwimmingPool()
                }
                
                LazyVStack(alignment: .leading){
                    ForEach($addNewUnitViewModel.facility.paidAmenities.outdoorSwimmingPools) { $pool in
                        
                        AmenityPriceLengthInputView(text: $pool.price, isValid: $pool.validPrice, length: $pool.length, width: $pool.width, validLength: $pool.validLength, validWidth: $pool.validWidth)
                            .padding(.trailing, 1)
                        
                        
                    }
                }
                
                //MARK: - Pets
                
                AmenityToggle(isOn: $addNewUnitViewModel.facility.paidAmenities.pets, label: "Pets")

                if addNewUnitViewModel.facility.paidAmenities.pets {
                    Group {
                        
                        Toggle(isOn: $addNewUnitViewModel.facility.paidAmenities.cats) {
                            Text("Cats")
                        }.toggleStyle(Checkbox())
                        
                        if addNewUnitViewModel.facility.paidAmenities.cats{
                            AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.catsService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.catsService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.catsService.description)
                        }
                        
                        
                        Toggle(isOn: $addNewUnitViewModel.facility.paidAmenities.dogs) {
                            Text("Dogs")
                        }.toggleStyle(Checkbox())
                        
                        if addNewUnitViewModel.facility.paidAmenities.dogs{
                            AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.dogsService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.dogsService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.dogsService.description)
                        }
                        
                        VStack(alignment: .leading) {
                            Toggle(isOn: $addNewUnitViewModel.facility.paidAmenities.rodents) {
                                Text("Rodents")
                            }.toggleStyle(Checkbox())
                            
                            Text("Rabbits, hamsters, rats, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            
                            if addNewUnitViewModel.facility.paidAmenities.rodents{
                                AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.rodentsService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.rodentsService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.rodentsService.description)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Toggle(isOn: $addNewUnitViewModel.facility.paidAmenities.reptiles) {
                                Text("Reptile")
                            }.toggleStyle(Checkbox())
                            
                            Text("Snakes, iguanas, chameleon, etc   ")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            
                            if addNewUnitViewModel.facility.paidAmenities.reptiles{
                                AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.reptilesService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.reptilesService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.reptilesService.description)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            
                            Toggle(isOn: $addNewUnitViewModel.facility.paidAmenities.bigAnimals) {
                                Text("Big Animals")
                            }.toggleStyle(Checkbox())
                            
                            Text("Horses, camels, cows, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                            
                            if addNewUnitViewModel.facility.paidAmenities.bigAnimals{
                                AmenityPriceDecriptionInputView(text: $addNewUnitViewModel.facility.paidAmenities.bigAnimalsService.price, isValid: $addNewUnitViewModel.facility.paidAmenities.bigAnimalsService.validPrice, description: $addNewUnitViewModel.facility.paidAmenities.bigAnimalsService.description).padding(.bottom)
                            }
                        }
                    }
                }
                
                //AmenityPaidCounter()
                
                
            })
            
            
            //MARK: - Continue Button
            VStack {
                NavigationLink(destination:
                                FacilityRulesScreen(), isActive: $addNewUnitViewModel.willShowRulesScreen) {
                    EmptyView()
                }
                
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    
    //                print("tapped")
    //                showRules.toggle()
                    addNewUnitViewModel.validatePaidAmenities()
                    
                    
                }
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

struct FacilityPaidAmenitiesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPaidAmenitiesScreen()
    }
}
