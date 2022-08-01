//
//  FacilityRoomsScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct FacilityRoomsScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addNewUnitViewModel: AddNewUnitViewModel = AddNewUnitViewModel()
    @State var progress: Float = 0.166 // total 12 steps therefore each one is 0.083
    @State var length: String = ""
    @State var isValid: Bool = true
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0){
            
            Text("Rooms")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Size of facility")
                .font(Font.custom("Poppins-Medium", size: 16.0))
                .padding(.bottom, -16)
            
            
            RoomSizeView(length: $length, width: $length, validLength: $isValid, validWidth: $isValid)
            
            Spacer()
            

            NavigationLink(destination:
                            CancellationPolicyScreen(), isActive: $addNewUnitViewModel.willShowAddRoomsScreen) {
                    EmptyView()
                }
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                print("tapped")
                addNewUnitViewModel.isFacilityNameValid()

                
            }
            
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
    
    @Binding var length: String
    @Binding var width: String
    @Binding var validLength: Bool
    @Binding var validWidth: Bool
   
    
    var body: some View {
        HStack {
            MaterialLengthField(text: $length, isValid: $validLength, errorMessage: "valid_room_length", placeHolder: "x-meters")
            
            Image(systemName: "multiply")
            
            MaterialLengthField(text: $length, isValid: $validWidth, errorMessage: "valid_room_length", placeHolder: "y-meters")
        }
    }
}
