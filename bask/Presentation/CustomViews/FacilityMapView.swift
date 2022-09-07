//
//  FacilityMapView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 07/09/2022.
//

import SwiftUI

struct FacilityMapView: View {
    
    
    var body: some View {
        GeometryReader { geomerty in
            VStack(alignment: .leading){
                
                Text("Location")
                    .font(Font.custom("Poppins-Regular", size: 20))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Rectangle().fill(.orange)
                    
                    
                HStack{
                    
                    Image(systemName: "mappin.circle.fill")
                    
                    Text("Street 3, Al Qatif")
                        .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                }
            }.frame(width: geomerty.size.width, height: geomerty.size.height)
        }
    }
}

struct FacilityMapView_Previews: PreviewProvider {
    static var previews: some View {
        FacilityMapView()
    }
}
