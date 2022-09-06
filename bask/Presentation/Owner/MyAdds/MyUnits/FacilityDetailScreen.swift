//
//  FacilityDetailScreen.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 06/09/2022.
//

import SwiftUI

struct FacilityDetailScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isDragging = false
    @State var newHeight = 0
    @State var currentHeight = 0.610
    var simpleDrag: some Gesture {
            DragGesture()
                .onChanged { value in
                    //self.location = value.location
                    print("Locaion change to \(value.location)")
                    if value.location.y < 0 && currentHeight < 0.90{
                        currentHeight = currentHeight + abs(value.location.y/100)
                        print("Current Height: \(currentHeight)")
                    }
                    self.isDragging = true

                }
                .onEnded {_ in
                    self.isDragging = false
                    
                }
        }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top){
                //                Rectangle()
                //                    .fill(Color.orange)
                Image("sample_resort")
                    .resizable()
                    .brightness(-0.1)
                
                
                
                HStack {
                    FadedBlueButton(icon: "chevron.left") {
                        
                        print("heloo")
                        self.presentationMode.wrappedValue.dismiss()

                        
                    }.frame(width: 42, height: 42)
                    
                    Spacer()
                    
                    FadedBlueButton(icon: "ellipsis") {
                        print("detials")
                    }.frame(width: 42, height: 42)
                }.padding()
                
            }.frame(height: UIScreen.main.bounds.height * 0.375)
                .offset(y: 16)
            
            
            
            VStack(alignment: .leading, spacing: 16){
                Header(price: "800", rating: "4.2", status: "Booked")
                
                Text("Mountaina Resort")
                    .font(Font.custom("Poppins-Regular", size: 26))
                    .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                    
                
                HStack(spacing: 16) {
                    BookedDateTileView(date: "06", type: .checkIn)
                    
                    BookedDateTileView(date: "09", type: .checkOut)
                    
                }
                
                Divider()
                
                CalendarButton()

                Divider()
                
                Spacer()
                
                Button {
                    print("message guest")
                } label: {
                    HStack {
                        Spacer()
                        Text("Message Guest")
                            .foregroundColor(.white)
                            .padding()

                        Spacer()
                    }.background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARK_BLUE)))
                }.padding(.bottom)
                
            }
            .padding()
            .frame(height: UIScreen.main.bounds.height * currentHeight)
            .background(Color.white)
            .roundCorners(radius: 16, [.topLeft, .topRight])
            .gesture(simpleDrag)
            
        }
    }
}

struct FacilityDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityDetailScreen()
    }
}


struct FadedBlueButton: View {
    let icon: String
    let action: () -> Void
    var body: some View {
        GeometryReader { geomerty in
            
            Button {
                action()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(AppColor.DARK_BLUE).opacity(0.5))
                        .frame(width: geomerty.size.width, height: geomerty.size.height)
                    
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .rotationEffect(icon.elementsEqual("ellipsis") ? .degrees(90) : .degrees(0))
                }
            }
            
            
        }
    }
}

struct Header: View {
    let price: String
    let rating: String
    let status: String
    
    var body: some View {
        HStack {
            Text("\(price) SAR")
                .font(.custom("Poppins-Medium", size: 16, relativeTo: .body))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("per night")
                .font(Font.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            
            Divider()
                .frame(height: 32)
            Text("\(rating)")
                .font(Font.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            
            Spacer()
            
            Text("Booked")
                .font(Font.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Image(systemName: "calendar")
                .foregroundColor(.blue)
        }
    }
}

struct BookedDateTileView: View {
    
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

struct CalendarButton: View {
    var body: some View {
        HStack {
            Image(systemName: "calendar")
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("Calendar")
                .font(Font.custom("Poppins-Medium", size: 16))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Spacer()
            
            Button {
                print("Calendar gooo")
            } label: {
                HStack{
                    
                    Text("View")
                        .font(Font.custom("Poppins-Regular", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
            }
        }.padding(.horizontal)
    }
}
