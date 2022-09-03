//
//  FacilityRulesScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI

struct FacilityRulesScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AddNewUnitViewModel
    //@StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    @State var progress: Float = 0.332
    @State private var valid: Bool = true
    let errorMsg: LocalizedStringKey = "valid_description"
    
    var body: some View {
        
        //MARK: - Title
        
        
        VStack(alignment: .leading, spacing: 24){
            
            Text("Rules of house")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            //MARK: - Pets
            ScrollView {
                AmenityToggle(isOn: $viewModel.facility.rules.petsAllowed, label: "Pets")
                
                if viewModel.facility.rules.petsAllowed {
                    Group {
                        
                        
                        //MARK: - All pets
                        Toggle(isOn: $viewModel.facility.rules.petsAllAllowed) {
                            Text("All pets allowed")
                        }.toggleStyle(Checkbox())
                        
                        
                        //MARK: - Cats
                        Toggle(isOn: $viewModel.facility.rules.petsCatsAllowed) {
                            Text("Cats")
                        }.toggleStyle(Checkbox())
                        
                        
                        //MARK: - Dogs
                        Toggle(isOn: $viewModel.facility.rules.petsDogsAllowed) {
                            Text("Dogs")
                        }.toggleStyle(Checkbox())
                        
                        
                        //MARK: - Rodents
                        VStack(alignment: .leading) {
                            Toggle(isOn: $viewModel.facility.rules.petsRodentsAllowed) {
                                Text("Rodents")
                            }.toggleStyle(Checkbox())
                            
                            Text("Rabbits, hamsters, rats, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        
                        
                        //MARK: - Reptile
                        VStack(alignment: .leading) {
                            Toggle(isOn: $viewModel.facility.rules.petsReptileAllowed) {
                                Text("Reptile")
                            }.toggleStyle(Checkbox())
                            
                            Text("Snakes, iguanas, chameleon, etc   ")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        
                        
                        //MARK: - Big Animals
                        VStack(alignment: .leading) {
                            
                            Toggle(isOn: $viewModel.facility.rules.petsBigAnimalAllowed) {
                                Text("Big Animals")
                            }.toggleStyle(Checkbox())
                            
                            Text("Horses, camels, cows, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                    }.padding(.trailing, 1)
                }
                
                
                //MARK: - Smoke
                AmenityToggle(isOn: $viewModel.facility.rules.smokingAllowed, label: "Allowed to smoke")
                
                
                //MARK: - Additional Rules
                AmenityToggle(isOn: $viewModel.facility.rules.additionalRules, label: "Addtional rules")
                
                if viewModel.facility.rules.additionalRules {
                    MaterialTextField(text: $viewModel.facility.rules.additionalRulesDescription, isValid: $valid, errorMessage: errorMsg, placeHolder: "Additional rules")
                        .padding(.horizontal, 1)
                }
                
                NavigationLink(destination:
                                FacilityLocationScreen().environmentObject(viewModel), isActive: $viewModel.willShowLocationScreen) {
                    EmptyView()
                }
            }
            
            
            //MARK: - Continue Button
            
            FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                viewModel.updateFacilityRules()
            }
            
        }.padding(.horizontal)
            .background(Color.white)
            .toast(isShowing: $viewModel.shallRetry, content: {
                Toast(message: "An error occured. Please try again.", style: .failure)
                
            })
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

struct FacilityRulesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityRulesScreen()
    }
}
