//
//  PublishFacilityScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/08/2022.
//

import SwiftUI

struct PublishFacilityScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AddNewUnitViewModel
    //@StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: PublishFacilityUseCase(repository: FacilityRepositoryImpl()))
    @State private var show: Bool = false
    @State private var toastShow = false
    @State private var showUploadingView: Bool = false
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            Text(viewModel.publishFacilityViewModel.title)
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
            
            //MARK: - Uploading Views
            
            if showUploadingView {
                UploadingFacilityDataView(publishFacilityVM: viewModel.publishFacilityViewModel)
                
            } else {
                PublishFacilityDefaultView(model: viewModel.publishFacilityViewModel, loadingIndicator: $showUploadingView, facilityName: viewModel.facilityNameViewModel.englishName)
            }
        }
        .padding(.horizontal)
        .background(Color.white)
        //        .toast(isShowing: $viewModel.showToast, content: {
        //
        //            switch viewModel.toastStyle {
        //            case .failure:
        //                Toast(message: "An error occured while publishing your ad. Please try again.", style: .failure)
        //            case .success:
        //                Toast(message: "Your ad has been published successfully.", style: .success)
        //            }
        //
        //        })
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
            trailing:
                Button{} label:{
                    Text("Show ad")
                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        .padding(.top)
                }
        )
    }
    
    private struct UploadingFacilityDataView: View {
        @ObservedObject var publishFacilityVM: PublishFacilityViewModel
        
        var body: some View {
            Text("Please wait while your data is being upload to our system.")
                .multilineTextAlignment(.leading)
                .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            UploadStatusView(status: publishFacilityVM.dataStatus, label: "Facility name, rooms, and other stuff.")
            
            if publishFacilityVM.showPhotosIndicator {
                UploadStatusView(status: publishFacilityVM.photosStatus, label: "Facility photos.")
            }
            Spacer()
            
            if publishFacilityVM.status == .uploading {
                Spinner()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Spacer()
            
            if publishFacilityVM.status == .error{
                FilledButton(label: "Retry", color: Color(AppColor.DARKEST_BLUE), endIcon: "repeat") {
                    publishFacilityVM.retryOperation()
                    
                }.padding(.vertical)
            }
            
            if publishFacilityVM.status == .success {
                FilledButton(label: "Done", color: Color(AppColor.DARKEST_BLUE), endIcon: "checkmark") {
                    
                    
                }.padding(.vertical)
            }
        }
    }
}

//struct PublishFacilityScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        PublishFacilityScreen()
//    }
//}

struct UploadStatusView: View {
    
    let status: UploadingStatusIndicator
    let label: String
    private let size = UIScreen.main.bounds.width * 0.04
    
    var body: some View {
        HStack{
            switch status {
            case .initial:
                Circle()
                    .fill(Color(AppColor.GREY))
                    .frame(width: size, height: size)
            case .uploading:
                Circle()
                    .fill(Color(AppColor.YELLOW))
                    .frame(width: size, height: size)
                    
            case .error:
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color(AppColor.RED))
                    .frame(width: size, height: size)
            case .success:
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .foregroundColor(Color(AppColor.ACCENT_GREEN))
                    .frame(width: size, height: size)
            }
            
            
            Text(label)
                .font(Font.custom("Poppins-Regular", size: 16, relativeTo: .title))
                .foregroundColor(status == .error ? Color(AppColor.RED) : Color(AppColor.DARKEST_BLUE))
        }
    }
    

}

struct PublishFacilityDefaultView: View {
    
    @ObservedObject var model: PublishFacilityViewModel
    @Binding var loadingIndicator: Bool
    let facilityName: String
    
    
    var body: some View {
        HStack {
            Spacer()
            
            Image("publish_add_illustration")
                .resizable()
                .scaledToFit()
            
            Spacer()
        }
        
        
        //MARK: - Message
        
        Text("Your facility “\(facilityName)” is ready to be published. You can change everything after publishing.")
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .title))
            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            .padding(.top)
        
        
        
        //MARK: - Continue Button
        
        //            NavigationLink(destination:
        //                            FacilityPicturesScreen(), isActive: $show) {
        //                EmptyView()
        //            }.isDetailLink(false)
        
        Spacer()
        
        FilledButton(label: "Save Unpublished", color: Color(AppColor.LIGHT_VOILET)) {
            
            loadingIndicator.toggle()
            model.saveUnpublished()
            
        }.padding(.top)
        
        
        
        FilledButton(label: "Publish", color: Color(AppColor.DARKEST_BLUE)) {
            
            loadingIndicator.toggle()
            model.publishFacility()
            
        }.padding(.top)
            .background(Rectangle().fill(Color.white.opacity(0.5)))
        
    }
}

enum UploadingStatusIndicator {
    case initial
    case uploading
    case error
    case success
}
