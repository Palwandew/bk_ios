//
//  BookingDatesInfoView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 09/09/2022.
//

import SwiftUI

//MARK: - BookingDatesView
struct BookingDatesView: View {
    
    let checkInDate: LocalDate
    let checkOutDate: LocalDate
    var body: some View {
        HStack(spacing: 16) {
            BookedDateTileView(date: checkInDate, type: .checkIn)
            
            BookedDateTileView(date: checkOutDate, type: .checkOut)
            
        }
    }
    
    private struct BookedDateTileView: View {
        
        let date: LocalDate
        let type: TileType
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8){
                HStack {
                    
                    switch type {
                    case .checkIn:
                        Text("Check in")
                            .font(.custom("Poppins-Regular", size: 14))
                    case .checkOut:
                        Text("Check out")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                    
                    
                    
                    Spacer()
                    
                    Image(systemName: "clock.fill")
                        .foregroundColor(Color(AppColor.LIGHT_VOILET))
                }
                
                HStack(alignment: .lastTextBaseline) {
                    Text(date.day)
                        .font(Font.custom("Poppins-Regular", size: 33))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    
                    Text(date.month + " " + date.year)
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
