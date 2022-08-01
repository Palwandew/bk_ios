//
//  FacilityNameScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 01/08/2022.
//

import SwiftUI

struct FacilityNameScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var addNewUnitViewModel: AddNewUnitViewModel = AddNewUnitViewModel()
    @State var progress: Float = 0.083 // total 12 steps therefore each one is 0.083
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0){
            
            Text("Name of the facility")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            VStack(alignment: .trailing) {
                MaterialTextField(text: $addNewUnitViewModel.facilityName, isValid: $addNewUnitViewModel.isValidName, errorMessage: "Please enter a name", placeHolder: "Name").keyboardType(.default)
                
                Text("\(addNewUnitViewModel.facilityName.count) / 50")
                    .font(Font.custom("Poppins-Light", size: 12.0))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            }
            
            Spacer()
            
            NavigationLink(destination:
                            FacilityRoomsScreen(), isActive: $addNewUnitViewModel.willShowAddRoomsScreen) {
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
                    
                })
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                HStack{
                    
                    LinearProgressBar(value: $progress)
                        .frame(width: UIScreen.main.bounds.width/2,height: (UIScreen.main.bounds.height * 1)/100)
                    
                }
            }
        }
    }
}

struct FacilityNameScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityNameScreen()
    }
}
