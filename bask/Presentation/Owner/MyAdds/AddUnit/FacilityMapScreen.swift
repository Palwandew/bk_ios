//
//  FacilityMapScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 05/08/2022.
//

import SwiftUI
import MapKit

struct FacilityMapScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: AddNewUnitViewModel
//    @StateObject var viewModel: AddNewUnitViewModel = AddNewUnitViewModel(useCase: CreateFacilityUseCase(repository: CreateFacilityReopositoryImpl()))

    @State var progress: Float = 0.332
    @State private var map = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.19970898091148, longitude: 45.11031652737802), span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 22))
     
    @State var showCheckIn: Bool = false 
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Confirm location")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
            
            //MARK: - Map
            
            ZStack {
                Map(coordinateRegion: $map, interactionModes: [.zoom, .pan])
                
                Image("map_pin")
                    .resizable()
                    .frame(width: 35, height: 41)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
            }.ignoresSafeArea(.all, edges: .bottom)
            
            
            //MARK: - Continue Button
                
                
                    
                    NavigationLink(destination:
                                    FacilityTimeScreen(), isActive: $viewModel.willShowCheckInScreen) {
                        EmptyView()
                    }
                    
                    
                    FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                        
                        viewModel.updateFacilityLocation(with: map.center)
                        
                        
                    }.padding([.horizontal, .top])
                        .padding(.bottom, 8)
                        .background(Rectangle().fill(Color.white.opacity(0.5)))
                    
                    
            
            
            
        }
        .background(Color.white)
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

//struct FacilityMapScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        FacilityMapScreen()
//    }
//}
