//
//  FacilityMapCoordinatesStep.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 16/11/2022.
//

import SwiftUI
import MapKit

struct FacilityMapCoordinatesStep: View {
    
    @ObservedObject var model: FacilityLocationViewModel
    @State private var map = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.19970898091148, longitude: 45.11031652737802), span: MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 22))
     
    
    var body: some View {
        
            
//            //MARK: - Title
//
//
//            Text("Confirm location")
//                .font(Font.custom("Poppins-Medium", size: 26, relativeTo: .title))
//                .foregroundColor(Color(AppColor.DARKEST_BLUE))
//                .padding(.leading)
            
            //MARK: - Map
            
            ZStack {
                Map(coordinateRegion: $map, interactionModes: [.zoom, .pan])
                
                Image("map_pin")
                    .resizable()
                    .frame(width: 35, height: 41)
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
            }
            .background(Color.white)
            .navigationBarBackButtonHidden(true)
            .onDisappear {
                model.updateMapPin(with: map.center)
            }
    }
}
