//
//  FacilityPublishChecklistScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct FacilityPublishChecklistScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var photosViewModel: PhotosViewModel
    @EnvironmentObject var viewModel: AddNewUnitViewModel
//    = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))
    @State var progress: Float = 0.332
    
    
    @State var showPublish: Bool = false
    
    
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
//                        ForEach($viewModel.checkList.items){ $item in
//                            ChecklistRow(title: item.title, isCompleted: item.status)
//                                .padding(.bottom)
//
//                        }
                    }
                }
                
                //MARK: - Continue Button
                
//                NavigationLink(destination:
//                                PublishFacilityScreen().environmentObject(viewModel), isActive: $photosViewModel.showPublishAdScreen) {
//                    EmptyView()
//                }.isDetailLink(false)
                
                Spacer()
                
                
                //MARK: - Create Add Btn
                FilledButton(label: "Create", color: Color(AppColor.DARKEST_BLUE)) {
                    
                    //                    print("tapped")
                                        //showPublish.toggle()
//                    withAnimation {
//                        showProgress.toggle()
//                    }
//                    photosViewModel.onCreateTapped(facilityID: viewModel.facility.id)
                    //showPublish.toggle()
                    
                    
                }.padding(.top)
                    .background(Rectangle().fill(Color.white.opacity(0.5)))
                
                
                
                
            }
            .padding(.horizontal)
            .background(Color.white)
            .toast(isShowing: $viewModel.shallRetry, content: {
                Toast(message: "An error occured. Please try again.", style: .failure)
                
            })
            .navigationBarBackButtonHidden(false)
            
            
            
//            if photosViewModel.showProgress {
//                UploadProgressView(progress: $photosViewModel.progress, successful: $photosViewModel.uploadingCompleted)
//            }
            
        }.onAppear {
            
            print("on appear")
            //viewModel.getChecklist()
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
    let isCompleted: Int?
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(Font.custom("Poppins-Regular", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .unredacted()
            
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
        }.redacted(reason: isCompleted == nil ? .placeholder : [])
        
    }
}

