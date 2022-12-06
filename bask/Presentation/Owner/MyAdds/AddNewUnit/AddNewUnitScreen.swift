//
//  AddNewUnitScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/11/2022.
//

import SwiftUI

struct AddNewUnitScreen: View {
    
    @State var showPublishScreen: Bool = false
    @StateObject var model: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    
    var body: some View {
        ZStack {
            VStack {
                
                //MARK: - Navigation Bar
                HStack{
                    
                    //MARK: - Back Button
                    if model.currentStep != .name {
                        
                        renderBackButton()
                        
                        Spacer()
                    } else {
                        renderBackButton()
                            .hidden()
                        
                        Spacer()
                        
                    }
                    
                    
                    //MARK: - Progress Bar
                    LinearProgressIndicator(value: model.currentProgress)
                        .frame(width: UIScreen.main.bounds.width/2,height: UIScreen.main.bounds.height/100)
                    
                    Spacer()
                    
                    //MARK: - Exit Button
                    Text("Exit")
                        .font(Font.custom("Poppins-Light", size: 16.0))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        .onTapGesture {
                            UIApplicationHelper.popToRootView()
                        }
                    
                }
                
                //MARK: - Navigation Title
                HStack{
                    Text(model.title)
                        .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Spacer()
                }
                
                //MARK: - Step Screens
                switch model.currentStep {
                case .name:
                    FacilityNameStep(model: model.facilityNameViewModel)
                    
                case .rooms:
                    FacilityRoomsStep(model: model.facilityRoomsViewModel)
                    
                case .rules:
                    FacilityRulesStep(model: model.facilityRulesViewModel)
                    
                case .amenities:
                    FreeAmenitiesStep(model: model.facilityAmenitiesViewModel)
                    
                case .address:
                    FacilityAddressStep(model: model.facilityLocationViewModel)
                    
                case .map:
                    FacilityMapCoordinatesStep(model: model.facilityLocationViewModel)
                        .padding(.horizontal, -16)
                    
                case .checkInTime:
                    FacilityCheckInTimeStep(model: model.checkInCheckOutViewModel)
                    
                case .price:
                    FacilityPriceStep(model: model.facilityPriceViewModel)
                case .description:
                    FacilityDescriptionStep(model: model.facilityDescriptionViewModel)
                    
                case .pictures:
                    FacilityPicturesStep(model: model.photosService)
                }
                
                Spacer()
                
                NavigationLink(destination:
                                PublishFacilityScreen(), isActive:$showPublishScreen) {
                    EmptyView()
                }
                
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    model.onContinueButtonTapped()
                }
                
            }
            .padding(.horizontal)
        }.navigationBarHidden(true)
    }
    
    private func renderBackButton() -> some View {
        return Button {
            model.onBackButtonTapped()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
    
//    private func performContinueAction(){
//        if !creationSteps.contains(currentStep.next()) {
//            currentStep = currentStep.next()
//            creationSteps.append(currentStep)
//            updateProgressBar()
//            model.onContinueTapped(nextStep: currentStep)
//        }
//    }
//
//    private func performBackAction() {
//        guard creationSteps.count > 1 else { return }
//        creationSteps.removeAll(where: {$0 == currentStep})
//        currentStep = currentStep.previous()
//        updateProgressBar(increase: false)
//        model.onBackTapped(previousStep: currentStep)
//    }
//
//    private func updateProgressBar(increase: Bool = true){
//
//        let steps: Float = 1/10
//
//        if increase{
//            currentProgress += steps
//        } else {
//            currentProgress -= steps
//        }
//    }
}

struct AddNewUnitScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUnitScreen()
    }
}


enum FacilityCreationState: String, CaseIterable {
    case name = "name"
    case rooms = "rooms"
    case amenities = "amenities"
    case rules = "rules"
    case address = "address"
    case map = "Coordinates"
    case checkInTime = "checkInTime"
    case price = "price"
    case description = "description"
    case pictures = "pictures"
    
}
