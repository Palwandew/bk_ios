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
    @State var showPopup: Bool = false
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
        ZStack(alignment: .bottom) {
            Group {
                FacilityImagesSliderView(isPopupShown: $showPopup, onBackTapped: {
                    presentationMode.wrappedValue.dismiss()
                }, onPopupTapped: {
                    showPopup.toggle()
                })
            }
            
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    
                    Group {
                        Header(price: "800", rating: "4.2", status: "Booked")
                        
                        Text("Mountaina Resort")
                            .font(Font.custom("Poppins-Regular", size: 26))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))


                        BookingDatesView()
                    }

                    

                    Group {
                        Divider()
                        
                        CalendarButton()

                        Divider()
                        
                        GuestInfoView(name: "Palwandew", rating: "4.2")
                        
                        Divider()
                    }

                    
                    
                    Group {
                        HStack{
                            
                            Image(systemName: "clock.fill")
                                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            
                            Text("Arrival after 3 PM")
                                .font(Font.custom("Poppins-Medium", size: 14))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            
                        }
                        
                        HStack{
                            
                            Image(systemName: "calendar")
                                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            
                            Text("Free cancellation until 72 hours before booking time")
                                .font(Font.custom("Poppins-Medium", size: 14))
                                .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                            
                        }
                    }
                    
                    Divider()
                    
                    Group {
                        HStack{
                            
                            SizeInfoView(size: "80 m2", label: "Living space")
                            
                            Spacer()
                            
                            SizeInfoView(size: "3", label: "Living rooms")
                            
                            Spacer()
                            
                            SizeInfoView(size: "20", label: "Capacity")
                            
                        }
                    }
                    
                    
                    // Amenity car
                    Group {
                        Text("Amenities")
                            .font(Font.custom("Poppins-Regular", size: 20))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 16){
                                
                                AmenityCard(icon: "icon_parking", label: "Parking")
                                
                                AmenityCard(icon: "icon_parking", label: "WiFi")
                                
                                AmenityCard(icon: "icon_parking", label: "Indoor pool")
                                
                                AmenityCard(icon: "icon_parking", label: "Barbeque")
                                
                                AmenityCard(icon: "icon_parking", label: "Barbeque")
                                
                            }
                            .padding(2)
                        
                        }
                        
                        // MARK: - Location
                        
                        FacilityMapView()
                            .frame(height: UIScreen.main.bounds.height * 0.35)
                            .padding(.bottom)
                        
                        ReviewsView()
                    }
                    
                    
                    
                    
                    //MARK: - Message Guest Button
//                    Button {
//                        print("message guest")
//                    } label: {
//                        HStack {
//                            Spacer()
//                            Text("Message Guest")
//                                .foregroundColor(.white)
//                                .padding()
//
//                            Spacer()
//                        }.background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARK_BLUE)))
//                    }
                }
                .padding()
                
                .background(Color.white)
                .roundCorners(radius: 16, [.topLeft, .topRight])
                .shadow(radius: 4, y: -3)
            //.gesture(simpleDrag)
            }.frame(height: UIScreen.main.bounds.height * currentHeight)
            
        }.navigationBarHidden(true)
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

struct GuestInfoView: View {
    
    let name: String
    let rating: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Rectangle().fill(.gray).frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Guest")
                        .font(Font.custom("Poppins-Regular", size: 12))
                        .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    
                    Text(name)
                        .font(Font.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                }
                
                Spacer()
                
                Text(rating)
                    .font(Font.custom("Poppins-Medium", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
            }
            
            
            
            HStack{
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                Text("Complain")
                    .font(Font.custom("Poppins-Regular", size: 16))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
                Image(systemName: "arrow.right")
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                
            }
        }
    }
}

struct SizeInfoView: View {
    
    let size: String
    let label: String
    
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

struct BookingDatesView: View {
    var body: some View {
        HStack(spacing: 16) {
            BookedDateTileView(date: "06", type: .checkIn)
            
            BookedDateTileView(date: "09", type: .checkOut)
            
        }
    }
}

struct PopupView: View {
    
    fileprivate let onButtonTapped: (PopupButton) -> Void
    
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .leading) {
                Button {
                    onButtonTapped(.cancel)
                } label: {
                    Text("Cancel booking")
                        .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                        .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.top, 4)
                }
                
                Button {
                    onButtonTapped(.edit)
                } label: {
                    Text("Edit Description")
                    .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.top, 4)
                }
                
                Button {
                    onButtonTapped(.unpublish)
                } label: {
                    Text("Unpublish Item")
                    .font(.custom("Poppins-Regular", size: 14, relativeTo: .body))
                    .foregroundColor(Color(AppColor.DARKEST_BLUE))
                    .padding(.top, 4)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(8)
        }.padding(.trailing)
    }
}

fileprivate enum PopupButton{
    case cancel
    case edit
    case unpublish
}

struct FacilityImagesSliderView: View {
    
    @Binding var isPopupShown: Bool
    let onBackTapped: () -> Void
    let onPopupTapped: () -> Void
    
    var body: some View {
        VStack{
            //                Rectangle()
            //                    .fill(Color.orange)
            ZStack(alignment: .top) {
                
                Image("sample_resort")
                    .resizable()
                    .brightness(-0.1)
                
                VStack(spacing: -8) {
                    HStack {
                        FadedBlueButton(icon: "chevron.left") {
                            
                            onBackTapped()
                            
                            
                        }.frame(width: 42, height: 42)
                        
                        Spacer()
                        
                        FadedBlueButton(icon: "ellipsis") {
                            
                            withAnimation {
                                onPopupTapped()
                            }
                            
                        }.frame(width: 42, height: 42)
                    }.padding()
                    
                    if isPopupShown{
                        PopupView(onButtonTapped: { button in
                            switch button {
                            case .cancel:
                                print("Cancel")
                            case .edit:
                                print("edit")
                            case .unpublish:
                                print("Unpub")
                            }
                        })
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing)))
                    }
                    
                }
                
            }.frame(height: UIScreen.main.bounds.height * 0.375)
            
            
            
            
            
            Spacer()
        }
    }
}
