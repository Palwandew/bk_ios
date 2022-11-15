//
//  AddNewUnitScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/11/2022.
//

import SwiftUI

struct AddNewUnitScreen: View {
    
    @State var creationSteps: [FacilityCreationState] = [.name]
    @State var currentStep: FacilityCreationState = .name
    @State var currentProgress: Float = 1/3
    @StateObject var model: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    
    @StateObject var nameVM: FacilityNameViewModel = FacilityNameViewModel()
    @StateObject var roomsVM: FacilityRoomsViewModel = FacilityRoomsViewModel()
    var body: some View {
        ZStack {
            VStack {
                
                //MARK: - Navigation Bar
                HStack{
                    
                    //MARK: - Back Button
                    if currentStep != .name {
                        
                        generateBackButton()
                        
                        Spacer()
                    } else {
                        generateBackButton()
                            .hidden()
                        
                        Spacer()
                        
                    }
                    
                    
                    //MARK: - Progress Bar
                    LinearProgressIndicator(value: currentProgress)
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
                switch currentStep {
                case .name:
                    //Step one
                    //Text("Name")
                    FacilityNameStep(model: model.facilityNameViewModel)
                    
                case .amenities:
                    //Step two
                    FacilityRoomsStep(model: model.facilityRoomsViewModel)
                case .address:
                    //Step three
                    Text("Address")
                        .onTapGesture {
                            print("OnCreateionSteps -> \(creationSteps)")
                        }
                }
                Spacer()
            
                //MARK: - Continue Button
                    
                FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                    performContinueAction()
                }
                
            }
            .padding(.horizontal)
        }.navigationBarHidden(true)
    }
    
    private func generateBackButton() -> some View {
        return Button {
            performBackAction()
        } label: {
            Image(systemName: "chevron.backward")
        }
    }
    
    private func performContinueAction(){
        if !creationSteps.contains(currentStep.next()) {
            currentStep = currentStep.next()
            creationSteps.append(currentStep)
            currentProgress += 1/3
            model.onContinueTapped(nextStep: currentStep)
        }
    }
    
    private func performBackAction() {
        guard creationSteps.count > 1 else { return }
        creationSteps.removeAll(where: {$0 == currentStep})
        currentStep = currentStep.previous()
        currentProgress -= 1/3
    }
}

struct AddNewUnitScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUnitScreen()
    }
}


enum FacilityCreationState: String, CaseIterable {
    case name = "name"
    case amenities = "amenities"
    case address = "address"
}
