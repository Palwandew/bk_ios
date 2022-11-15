//
//  FacilityLocationScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct FacilityLocationScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AddNewUnitViewModel
    //@StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))

    @State var progress: Float = 0.5
    
    //@State var text: String = ""
    @State var valid: Bool = true
    let errorMsg: LocalizedStringKey = "valid_description"
    @State var showMap: Bool = false
    @State var showCountries: Bool = false
    
    var body: some View {
        
        //MARK: - Title
        
        
        VStack(alignment: .leading, spacing: 24){
            
            Text("Facility location")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Before booking, guests can't see your exact address")
                .lineLimit(2)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .padding(.top, -16)
            
            
            //ScrollView {
            
            //MARK: - Country
            
            MaterialTextSelector(text: $viewModel.facilityLocationViewModel.location.country, placeHolder: "Country")
                .frame(height: 55)
            
            
            //MARK: - City
            
            MaterialTextField(text: $viewModel.facilityLocationViewModel.location.city, isValid: $viewModel.facilityLocationViewModel.location.validCity, errorMessage: errorMsg, placeHolder: "City")
                .padding([.top, .horizontal], 1)
            
            //}
            
            //MARK: - Address
            
            MaterialTextField(text: $viewModel.facilityLocationViewModel.location.street, isValid: $viewModel.facilityLocationViewModel.location.validStreet, errorMessage: errorMsg, placeHolder: "Address")
                .padding([.top, .horizontal], 1)
            
            Spacer()
            
            
            NavigationLink(destination:
                            FacilityMapScreen().environmentObject(viewModel), isActive: $viewModel.facilityLocationViewModel.shallShowMap) {
                EmptyView()
            }
            
            //MARK: - Continue Button
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                
                viewModel.facilityLocationViewModel.onContinueTapped()
            }
            
            
            //MARK: - Navigation bar item
            
        }
        .fullScreenCover(isPresented: $showCountries, content: {
            CountriesListScreen()
        })
        .padding(.horizontal)
        .background(Color.white)
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

struct FacilityLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityLocationScreen()
    }
}
