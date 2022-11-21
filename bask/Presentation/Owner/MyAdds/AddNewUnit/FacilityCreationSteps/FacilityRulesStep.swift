//
//  FaciityRulesStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/11/2022.
//

import SwiftUI

struct FacilityRulesStep: View {
    
    @ObservedObject var model: FacilityRulesViewModel
    
    private let errorMsg: LocalizedStringKey = LocalizedStringKey("")
    @State private var isValid: Bool = true
    
    var body: some View {
        
        //MARK: - Title
        
        
        VStack(alignment: .leading, spacing: 24){
            
            
            //MARK: - Pets
            ScrollView {
                
                
                AmenityToggleView(isOn: $model.petsAllowed, label: "Pets")
                
                if model.petsAllowed {
                    Group {
                        
                        //MARK: - All pets
                        Toggle(isOn: $model.allPetsAllowed) {
                            Text("All pets allowed")
                        }.toggleStyle(Checkbox())
                        
                        
                        //MARK: - Cats
                        Toggle(isOn: $model.cats) {
                            Text("Cats")
                        }.toggleStyle(Checkbox())
                        
                        
                        //MARK: - Dogs
                        Toggle(isOn: $model.dogs) {
                            Text("Dogs")
                        }.toggleStyle(Checkbox())
                        
                        
                        //MARK: - Rodents
                        VStack(alignment: .leading) {
                            Toggle(isOn: $model.rodents) {
                                Text("Rodents")
                            }.toggleStyle(Checkbox())
                            
                            Text("Rabbits, hamsters, rats, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        
                        
                        //MARK: - Reptile
                        VStack(alignment: .leading) {
                            Toggle(isOn: $model.reptile) {
                                Text("Reptile")
                            }.toggleStyle(Checkbox())
                            
                            Text("Snakes, iguanas, chameleon, etc   ")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                        
                        
                        //MARK: - Big Animals
                        VStack(alignment: .leading) {
                            
                            Toggle(isOn: $model.bigAnimals) {
                                Text("Big Animals")
                            }.toggleStyle(Checkbox())
                            
                            Text("Horses, camels, cows, etc")
                                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        }
                    }.padding(.trailing, 1)
                }
                
                
                //MARK: - Smoke
                AmenityToggleView(isOn: $model.allowedToSmoke, label: "Allowed to smoke")
                
                
                //MARK: - Additional Rules
                AmenityToggleView(isOn: $model.additonalRules, label: "Addtional rules")
                
                if model.additonalRules {
                    MaterialTextField(text: $model.additionalRulesDescription, isValid: $isValid, errorMessage: errorMsg, placeHolder: "Additional rules")
                        .padding(.horizontal, 1)
                }
                
            }
            
        }   .background(Color.white)
    }
}

