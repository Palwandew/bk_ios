//
//  FacilityRoomsStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/11/2022.
//

import SwiftUI

struct FacilityRoomsStep: View {
    
    @ObservedObject var model: FacilityRoomsViewModel
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 32.0) {
            
//            //MARK: - Title
//
//            Text("Rooms")
//                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
//                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            
            ScrollView {
                
                
                //MARK: - Facility Size Input
                
                RoomSizeView(label: "Size of facility", length: $model.facilityLength, width: $model.facilityWidth, validLength: $model.validLength, validWidth: $model.validWidth)
                    .padding(.horizontal, 1)
//                    .offset(x: moving ? 5 : 0)
//                    .animation(.interpolatingSpring(stiffness: 5000, damping: 20), value: moving)
//
                
                
                //MARK: - Living Rooms Counter
                
                AmenityCounterView(counter: $model.livingRoomsCount, label: "Living rooms"){
                    UIApplicationHelper.dimissKeyboard()
                    //addNewUnitViewModel.decreaseCount(of: .livingRoom)
                } onIncrease: {
                    //addNewUnitViewModel.increaseCount(of: .livingRoom)
                }
                
                
                //MARK: - Kitchen Counter
                AmenityCounterView(counter: $model.kitchensCount, label: "Kitchen") {
                    //addNewUnitViewModel.decreaseCount(of: .kitchen)
                } onIncrease: {
                    //addNewUnitViewModel.increaseCount(of: .kitchen)
                }.padding(.bottom)
                
                
                
                //MARK: - Bathroom Counter
                AmenityCounterView(counter: $model.bathroomsCount, label: "Bathroom") {
  //                  addNewUnitViewModel.decreaseCount(of: .bathroom)
                } onIncrease: {
  //                  addNewUnitViewModel.increaseCount(of: .bathroom)
                }.padding(.bottom)
                
                
                
                //MARK: - Shower counter
                AmenityCounterView(counter: $model.showersCount, label: "Shower") {
   //                 addNewUnitViewModel.decreaseCount(of: .shower)
                } onIncrease: {
   //                 addNewUnitViewModel.increaseCount(of: .shower)
                }.padding(.bottom)
                
                
                
                //MARK: - Capacity counter
                AmenityCounterView(counter: $model.personCapacity, label: "Capacity") {
    //                addNewUnitViewModel.decreaseCount(of: .personCapacity)
                } onIncrease: {
    //                addNewUnitViewModel.increaseCount(of: .personCapacity)
                }.padding(.bottom)
//                    .offset(x: moving ? 5 : 0)
//                    .animation(.interpolatingSpring(stiffness: 5000, damping: 20), value: moving)
                
                HStack {
                    Text("How many peole can be\nhosted in a facility ")
                    
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .lineLimit(2)
                    Spacer()
                }
                
            }
            
        }
        .background(Color.white)
//        .toast(isShowing: $model.toast.willShow, content: {
//            Toast(message: model.toast.message, style: model.toast.style)
//
//        })
        .navigationBarBackButtonHidden(true)
    }
}

//struct FacilityRoomsStep_Previews: PreviewProvider {
//    static var previews: some View {
//        FacilityRoomsStep()
//    }
//}
