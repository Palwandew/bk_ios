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
    @StateObject var addNewUnitViewModel: AddNewUnitViewModel = AddNewUnitViewModel()
    
    @State var progress: Float = 0.249 // total 12 steps therefore each one is 0.083
    @State var isWifiOn: Bool = false
    @State var isParkingOn: Bool = true
    @State var indoorSwimmingPools: Int = 0
    @State var outdoorSwimmingPools: Int = 0
    @State var length: String = ""
    @State var isValid: Bool = true
    
    @State var isOn: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            
            
            //MARK: - Title
            
            
            Text("Amenities (paid)")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                //MARK: - Wifi
                
                AmenityToggle(isOn: $isWifiOn, label: "Wifi")
                
                if isWifiOn {
                    AmenityPriceDecriptionInputView()
                }
                
                
                //MARK: - Parking
                
                AmenityToggle(isOn: $isParkingOn, label: "Parking")
                
                if isParkingOn {
                    AmenityPriceDecriptionInputView()
                }
                
                //MARK: - Indoor Pools
                
                AmenityCounterView(counter: $indoorSwimmingPools, label: "Indoor swimming pool") {
                    if indoorSwimmingPools > 0 {
                        indoorSwimmingPools -= 1
                    }
                } onIncrease: {
                    indoorSwimmingPools += 1
                }
                
                LazyVStack(alignment: .leading){
                    ForEach(0..<indoorSwimmingPools, id:\.self) { index in
                        
                        AmenityPriceLengthInputView()
                        
                    }
                }
                
                
                //MARK: - Outdoor Pools
                
                AmenityCounterView(counter: $outdoorSwimmingPools, label: "Outdoor swimming pool") {
                    if outdoorSwimmingPools > 0 {
                        outdoorSwimmingPools -= 1
                    }
                } onIncrease: {
                    outdoorSwimmingPools += 1
                }
                
                LazyVStack(alignment: .leading){
                    ForEach(0..<outdoorSwimmingPools, id:\.self) { index in
                        
                        AmenityPriceLengthInputView()
                        
                    }
                }
                
                
                //MARK: - Outdoor Sitting
                Group {
                    Toggle(isOn: $addNewUnitViewModel.facility.outdoorSitting) {
                        Text("Outdoor sitting")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $addNewUnitViewModel.facility.bbq) {
                        Text("Barbeque area")
                    }.toggleStyle(Checkbox())
                    
                    
                    Toggle(isOn: $addNewUnitViewModel.facility.gym) {
                        Text("Gym")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $addNewUnitViewModel.facility.gamesRoom) {
                        Text("Games room")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $addNewUnitViewModel.facility.garden) {
                        Text("Garden")
                    }.toggleStyle(Checkbox())
                    
                    Toggle(isOn: $addNewUnitViewModel.facility.playingField) {
                        Text("Playing field")
                    }.toggleStyle(Checkbox())
                    
                    if addNewUnitViewModel.facility.playingField {
                        AmenityPriceLengthInputView()
                            .padding(.bottom, 2)
                    }
                }.padding(.trailing, 1)
                
                //AmenityPaidCounter()
                
            })
            
            
            //MARK: - Continue Button
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                addNewUnitViewModel.onContinueTapped()
                
                
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
