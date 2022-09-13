//
//  FacilitySizeInfoView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - SizeInfoView
struct SizeInfoView: View {
    
    let livingSpace: String
    let livingRooms: String
    let capacity: String
    
    init(space livingSpace: String, rooms livingRooms: String, capacity: String ){
        self.livingSpace = livingSpace
        self.livingRooms = livingRooms
        self.capacity = capacity
    }
    var body: some View {
        HStack{
            
            SizeInfoTileView(size: livingSpace, label: LocalizedStringKey("Living space"))
            
            Spacer()
            
            SizeInfoTileView(size: livingRooms, label: LocalizedStringKey("Living rooms"))
            
            Spacer()
            
            SizeInfoTileView(size: capacity, label: LocalizedStringKey("Capacity"))
            
        }
    }
    
    
    //MARK: - SizeInfoTileView
    private struct SizeInfoTileView: View {
        
        let size: String
        let label: LocalizedStringKey
        
        var body: some View {
            VStack {
                Text(size)
                    .font(.custom("Poppins-Medium", size: 16, relativeTo: .body))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Text(label)
                    .font(.custom("Poppins-Regular", size: 12, relativeTo: .body))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            }
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.width / 5)
            .background(Color(AppColor.BACKGROUND))
            .cornerRadius(8)
            .shadow(radius: 1)
        }
    }
}


