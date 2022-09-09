//
//  BookingDatesInfoView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - BookingDatesView
struct BookingDatesView: View {
    var body: some View {
        HStack(spacing: 16) {
            BookedDateTileView(date: "06", type: .checkIn)
            
            BookedDateTileView(date: "09", type: .checkOut)
            
        }
    }
    
    private struct BookedDateTileView: View {
        
        let date: String
        let type: TileType
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8){
                HStack {
                    
                    switch type {
                    case .checkIn:
                        Text("Check in")
                    case .checkOut:
                        Text("Check out")
                    }
                    
                    
                    
                    Spacer()
                    
                    Image(systemName: "clock.fill")
                        .foregroundColor(Color(AppColor.LIGHT_VOILET))
                }
                
                HStack(alignment: .lastTextBaseline) {
                    Text(date)
                        .font(Font.custom("Poppins-Regular", size: 33))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    
                    Text("MARCH 2022")
                        .font(Font.custom("Poppins-Regular", size: 14))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.BACKGROUND)))
            .shadow(radius: 1)
        }
        
        enum TileType{
            case checkIn
            case checkOut
        }
    }
}
