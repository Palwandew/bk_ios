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
    @State var progress: Float = 0.332
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            //MARK: - Title
            
            
            Text("Confirm location")
                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.leading)
            
            //MARK: - Map
            
            ZStack {
                Map(coordinateRegion: $region, interactionModes: [.zoom])
                
                Image("map_pin")
                    .resizable()
                    .frame(width: 35, height: 41)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
            //MARK: - Continue Button
                
                VStack {
                    
                    Spacer()
                    
                    FilledButton(label: "Continue", color: Color(AppColor.DARKEST_BLUE)) {
                        
                        print("tapped")
                        //print(region.center)
                        //showCountries.toggle()
                        
                        
                    }.padding([.horizontal, .top])
                        .padding(.bottom, 42)
                        .background(Rectangle().fill(Color.white.opacity(0.5)))
                    
                    
                }
            }.ignoresSafeArea(.all, edges: .bottom)
            
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

struct FacilityMapScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityMapScreen()
    }
}
