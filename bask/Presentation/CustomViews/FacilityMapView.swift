//
//  FacilityMapView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/09/2022.
//

import SwiftUI
import MapKit

struct FacilityMapView: View {
    
    @State var maps: UIImage? = nil
    
    var body: some View {
        GeometryReader { geomerty in
            VStack(alignment: .leading){
                
                Text("Location")
                    .font(Font.custom("Poppins-Regular", size: 20))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                if maps == nil {
                    Rectangle().fill(Color(AppColor.BACKGROUND))
                } else {
                    Image(uiImage: maps!)
                        .resizable()
                        .frame(width: geomerty.size.width, height: geomerty.size.height)
                        .overlay(Image("map_pin"))
                }

                    
                    
                HStack{
                    
                    Image(systemName: "mappin.circle.fill")
                    
                    Text("Street 3, Al Qatif")
                        .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                }
            }.frame(width: geomerty.size.width, height: geomerty.size.height)
                .onAppear {
                    take(size: CGSize(width: geomerty.size.width, height: geomerty.size.height))
                }
        }
    }
    
    
    func take(size: CGSize)  {
        let snapshotOptions = MKMapSnapshotter.Options()
        
        snapshotOptions.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 24.19970898091148, longitude: 45.11031652737802), span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        
        snapshotOptions.mapType = .standard
        snapshotOptions.showsBuildings = false
        snapshotOptions.size = size
        
        let snapshotter = MKMapSnapshotter(options: snapshotOptions)
        
        snapshotter.start(with: .main) { snapshot, error in
            if let _ = error {
                return
            }
            
            guard let snapshot = snapshot else { return }
            
            maps = snapshot.image
        }
    }
}

struct FacilityMapView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityMapView()
    }
}
