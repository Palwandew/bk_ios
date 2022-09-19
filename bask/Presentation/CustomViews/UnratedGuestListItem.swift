//
//  GuestRatingListItem.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct UnratedGuestListItem: View {
    let model: UnratedGuestViewModel
    let rateGuest: () -> Void
    let complainGuest: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            
            FacilityInfo(name: model.facilityName, address: model.facilityAddress, checkInTime: model.chechInTime, checkOutTime: model.checkOutTime)
            
            NewRatingItem(model.name, model.startDate, model.endDate, complainGuest, onRate: rateGuest)
            
        }.padding()
    }
}

struct FacilityInfo: View {
    
    let name: String
    let address: String
    let checkInTime: String
    let checkOutTime: String
    
    var body: some View {
        Text(name)
            .font(.custom("Poppins-Regular", size: 20))
            .foregroundColor(Color(AppColor.DARKEST_BLUE))
            .padding(.bottom, 4)
        
        Text("Check in: \(checkInTime), Check out : \(checkOutTime)")
            .font(.custom("Poppins-Regular", size: 14))
            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
            .fontWeight(.light)
            .padding(.bottom, 1)
        
        Text("\(Image(systemName: "mappin.circle.fill")) \(address)")
            .font(.custom("Poppins-Regular", size: 12))
            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            .fontWeight(.light)
    }
}

struct NewRatingItem: View {
    
    let guestName: String
    let startDate: String
    let endDate: String
    let newComplain: () -> Void
    let rateGuest: () -> Void
    
    init(_ name: String,
         _ startDate: String,
         _ endDate: String,
         _ onComplainTapped: @escaping () -> Void, onRate onRateTapped: @escaping () -> Void){
        self.guestName = name
        self.startDate = startDate
        self.endDate = endDate
        self.newComplain = onComplainTapped
        self.rateGuest = onRateTapped
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Rectangle().fill(.black).frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("\(startDate) - \(endDate)")
                        .font(Font.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.bottom, 1)
                    
                    Text(guestName)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
            
            Divider()
                .foregroundColor(Color.green)
                .padding(.vertical, 4)
            
            HStack {
                Button {
                    newComplain()
                } label: {
                    HStack {
                        Spacer()
                        Text("Complain")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                            .padding(8)
                        Spacer()
                            
                    }.background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(AppColor.DARK_BLUE), lineWidth: 1)
                            
                )
                    
            }
                Spacer(minLength: 16)
                
                Button {
                    rateGuest()
                } label: {
                    HStack {
                        Spacer()
                        Text("Rate")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(.white)
                            .padding(8)
                        Spacer()
                            
                    }.background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(AppColor.DARKEST_BLUE))
                            
                )
                    
            }
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

struct RatedGuestListItem: View {
    let model: UnratedGuestViewModel
    let viewDetails: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            
            FacilityInfo(name: model.facilityName, address: model.facilityAddress, checkInTime: model.chechInTime, checkOutTime: model.checkOutTime)
            
            
            RatedGuestItem(guestName: model.name, startDate: model.startDate, endDate: model.endDate, isRated: model.isRated, showDetails: viewDetails)
            
        }.padding()
    }
}

//struct GuestRatingListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        GuestRatingListItem().previewLayout(.sizeThatFits)
//    }
//}




struct RatedGuestItem: View {
    let guestName: String
    let startDate: String
    let endDate: String
    let isRated: Bool
    let showDetails: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Rectangle().fill(.black).frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("\(startDate) - \(endDate)")
                        .font(Font.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.bottom, 1)
                    
                    Text(guestName)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
            
            Divider()
                .foregroundColor(Color.green)
                .padding(.vertical, 4)
            
            HStack {
                
                if isRated {
                    RatingStars(rating: 3)
                }

                else {
                    Group {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.yellow)
                        
                        Text("Complain")
                            .font(Font.custom("Poppins-Regular", size: 14))
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    }
                }
                
                Spacer()
                
                Button {
                    print("message guest")
                    showDetails()
                } label: {
                    
                    HStack {
                        
                        
                        Text("View details")
                                .font(Font.custom("Poppins-Regular", size: 14))
                                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        
                        Image(systemName: "arrow.forward")
                            .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

struct RatingStars: View {
    let rating: Int
    var body: some View {
        ForEach(1...5, id:\.self){ index in
            Image(systemName: index <= rating ? "star.fill" : "star")
                .foregroundColor(.yellow)
        }
    }
}

enum GuestRatingListItemStyle{
    case new
    case old
}

enum RatedGuestListItemStyle {
    case rating
    case complain
}
