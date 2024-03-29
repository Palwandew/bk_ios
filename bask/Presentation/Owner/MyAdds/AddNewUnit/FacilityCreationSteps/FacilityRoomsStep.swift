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
                    model.decreaseCount(of: .livingRoom)
                } onIncrease: {
                    model.increaseCount(of: .livingRoom)
                }
                
                
                //MARK: - Kitchen Counter
                AmenityCounterView(counter: $model.kitchensCount, label: "Kitchen") {
                    model.decreaseCount(of: .kitchen)
                } onIncrease: {
                    model.increaseCount(of: .kitchen)
                }.padding(.bottom)
                
                
                
                //MARK: - Bathroom Counter
                AmenityCounterView(counter: $model.bathroomsCount, label: "Bathroom") {
                    model.decreaseCount(of: .bathroom)
                } onIncrease: {
                    model.increaseCount(of: .bathroom)
                }.padding(.bottom)
                
                
                
                //MARK: - Shower counter
                AmenityCounterView(counter: $model.showersCount, label: "Shower") {
                    model.decreaseCount(of: .shower)
                } onIncrease: {
                    model.increaseCount(of: .shower)
                }.padding(.bottom)
                
                
                
                //MARK: - Capacity counter
                AmenityCounterView(counter: $model.personCapacity, label: "Capacity") {
                    model.decreaseCount(of: .personCapacity)
                } onIncrease: {
                    model.increaseCount(of: .personCapacity)
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
        .toast(isShowing: $model.toast.willShow, content: {
            Toast(message: model.toast.message, style: model.toast.style)
                .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
            

        })
        .navigationBarBackButtonHidden(true)
    }
}

//struct FacilityRoomsStep_Previews: PreviewProvider {
//    static var previews: some View {
//        FacilityRoomsStep()
//    }
//}
struct RoomSizeView: View {
    
    let label: String
    @Binding var length: String
    @Binding var width: String
    @Binding var validLength: Bool
    @Binding var validWidth: Bool
    let errorMessage: LocalizedStringKey = "valid_description"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(label)
                .font(Font.custom("Poppins-Regular", size: 16.0))
            
            HStack {
                MaterialLengthField(text: $length, isValid: $validLength, errorMessage: errorMessage, placeHolder: "x-meters")
                
                Image(systemName: "multiply")
                
                MaterialLengthField(text: $width, isValid: $validWidth, errorMessage: errorMessage, placeHolder: "y-meters")
            }
        }
    }
}
