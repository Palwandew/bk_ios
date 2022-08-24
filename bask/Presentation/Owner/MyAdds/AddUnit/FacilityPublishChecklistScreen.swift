//
//  FacilityPublishChecklistScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct FacilityPublishChecklistScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    //@EnvironmentObject var viewModel: AddNewUnitViewModel
    @StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    @State var progress: Float = 0.332
    
    private let checkList: [String] = ["Name", "Rooms", "Amenities", "Amenities (paid)", "Rules of house", "Facility Location", "Check-in", "Price", "Description", "Photos"]
    
    @State var showPublish: Bool = false
    
    @State var showProgress: Bool = false
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                
                //MARK: - Title
                
                
                Text("Checklist")
                    .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                
                //MARK: - List
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        ForEach(viewModel.checkList.getChecklistForView().keys.sorted(), id:\.self){ key in
                            ChecklistRow(title: key, isCompleted: value)
                                .padding(.bottom)
                        }
                    }
                }
                
                //MARK: - Continue Button
                
                NavigationLink(destination:
                                PublishFacilityScreen(), isActive: $showPublish) {
                    EmptyView()
                }
                
                Spacer()
                
                
                //MARK: - Create Add Btn
                FilledButton(label: "Create", color: Color(AppColor.DARKEST_BLUE)) {
                    
                    //                    print("tapped")
                    //                    showPublish.toggle()
                    withAnimation {
                        showProgress.toggle()
                    }
                    
                    
                }.padding(.top)
                    .background(Rectangle().fill(Color.white.opacity(0.5)))
                
                
                
                
            }
            .padding(.horizontal)
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            
            
            
            if showProgress {
                UploadProgressView()
            }
        }
    }
}

struct FacilityPublishChecklistScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityPublishChecklistScreen()
        
    }
}



struct ChecklistRow: View {
    
    let title: String
    let isCompleted: Int
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(Font.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            if isCompleted == 1{
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
                
            } else {
                Text("Continue")
                    .font(Font.custom("Poppins-Medium", size: 14))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
            }
        }
        
    }
}

