//
//  GuestRatingListItem.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 15/09/2022.
//

import SwiftUI

struct GuestRatingListItem: View {
    @State var style: GuestRatingListItemStyle = .new
    
    let rateGuest: () -> Void
    let complainGuest: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sunny appartment with gym and swimming pool")
                .font(.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
                .padding(.bottom, 4)
            
            Text("Check in: 2 PM, Check out : 3 PM")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                .fontWeight(.light)
                .padding(.bottom, 1)
            
            Text("\(Image(systemName: "mappin.circle.fill")) Al Khuwaildiyah, Al Qatif 32653")
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                .fontWeight(.light)
            
            switch style {
            case .new:
                NewRatingItem({
                    complainGuest()
                }, onRate: {
                    rateGuest()
                })
            case .old:
                RatedGuestItem()
            }
        }.padding()
    }
}

//struct GuestRatingListItem_Previews: PreviewProvider {
//    static var previews: some View {
//        GuestRatingListItem().previewLayout(.sizeThatFits)
//    }
//}


struct NewRatingItem: View {
    
    let newComplain: () -> Void
    let rateGuest: () -> Void
    
    init(_ onComplainTapped: @escaping () -> Void, onRate onRateTapped: @escaping () -> Void){
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
                    Text("15 Jun - 16 May, 2020")
                        .font(Font.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.bottom, 1)
                    
                    Text("Palwandew")
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

struct RatedGuestItem: View {
    @State var isRated: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Rectangle().fill(.black).frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading) {
                    Text("15 Jun - 16 May, 2020")
                        .font(Font.custom("Poppins-Medium", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                        .padding(.bottom, 1)
                    
                    Text("Palwandew")
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
