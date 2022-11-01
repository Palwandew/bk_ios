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
    
    @State var progress: Float = 0.166 // total 12 steps therefore each one is 0.083
    @State var length: String = ""
    @State var isValid: Bool = true
    @State var moving: Bool = false
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 32.0) {
            
            //MARK: - Title
            
            Text("Rooms")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            
            ScrollView {
                
                
                //MARK: - Facility Size Input
                
                RoomSizeView(label: "Size of facility", length: $addNewUnitViewModel.facilityRoomsViewModel.facilityLength, width: $addNewUnitViewModel.facilityRoomsViewModel.facilityWidth, validLength: $addNewUnitViewModel.facilityRoomsViewModel.validLength, validWidth: $addNewUnitViewModel.facilityRoomsViewModel.validWidth)
                    .padding(.horizontal, 1)
                    .offset(x: moving ? 5 : 0)
                    .animation(.interpolatingSpring(stiffness: 5000, damping: 20), value: moving)
                
                
                
                //MARK: - Living Rooms Counter
                
                AmenityCounterView(counter: $addNewUnitViewModel.facilityRoomsViewModel.livingRoomsCount, label: "Living rooms"){
                    UIApplicationHelper.dimissKeyboard()
                    addNewUnitViewModel.decreaseCount(of: .livingRoom)
                } onIncrease: {
                    addNewUnitViewModel.increaseCount(of: .livingRoom)
                }
                
                
                //MARK: - Kitchen Counter
                AmenityCounterView(counter: $addNewUnitViewModel.facilityRoomsViewModel.kitchensCount, label: "Kitchen") {
                    addNewUnitViewModel.decreaseCount(of: .kitchen)
                } onIncrease: {
                    addNewUnitViewModel.increaseCount(of: .kitchen)
                }.padding(.bottom)
                
                
                
                //MARK: - Bathroom Counter
                AmenityCounterView(counter: $addNewUnitViewModel.facilityRoomsViewModel.bathroomsCount, label: "Bathroom") {
                    addNewUnitViewModel.decreaseCount(of: .bathroom)
                } onIncrease: {
                    addNewUnitViewModel.increaseCount(of: .bathroom)
                }.padding(.bottom)
                
                
                
                //MARK: - Shower counter
                AmenityCounterView(counter: $addNewUnitViewModel.facilityRoomsViewModel.showersCount, label: "Shower") {
                    addNewUnitViewModel.decreaseCount(of: .shower)
                } onIncrease: {
                    addNewUnitViewModel.increaseCount(of: .shower)
                }.padding(.bottom)
                
                
                
                //MARK: - Capacity counter
                AmenityCounterView(counter: $addNewUnitViewModel.facilityRoomsViewModel.personCapacity, label: "Capacity") {
                    addNewUnitViewModel.decreaseCount(of: .personCapacity)
                } onIncrease: {
                    addNewUnitViewModel.increaseCount(of: .personCapacity)
                }.padding(.bottom)
                    .offset(x: moving ? 5 : 0)
                    .animation(.interpolatingSpring(stiffness: 5000, damping: 20), value: moving)
                
                
                NavigationLink(destination:
                                FacilityFreeAmenitiesScreen()
                                .environmentObject(addNewUnitViewModel),
                               isActive: $addNewUnitViewModel.facilityRoomsViewModel.shallNavigate) {
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
            
            
            //MARK: - Continue Button
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                addNewUnitViewModel.onContinueTapped()
                
                
            }.padding(.top, -24)
            
        }
        .padding(.horizontal)
        .background(Color(AppColor.BACKGROUND))
        .toast(isShowing: $addNewUnitViewModel.facilityRoomsViewModel.toast.willShow, content: {
            Toast(message: addNewUnitViewModel.facilityRoomsViewModel.toast.message, style: addNewUnitViewModel.facilityRoomsViewModel.toast.style)
            
        })
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
                    .onTapGesture {
                        UIApplicationHelper.popToRootView()
                    }
                
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

//struct FacilityRoomsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FacilityRoomsScreen()
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
