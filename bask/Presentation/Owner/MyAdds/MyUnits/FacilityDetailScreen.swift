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
    @State var willShowCancelBookingDialog: Bool = false
    let style: FacilityDetailsStyle
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
            //MARK: - Images Slider
            
            FacilityImagesSliderView(isPopupShown: $showPopup, cancelBookingDialog: $willShowCancelBookingDialog, popupStyle: style, onBackTapped: {
                presentationMode.wrappedValue.dismiss()
            }, onPopupTapped: {
                showPopup.toggle()
            })
            
            
            //MARK: - Half Modal Sheet
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16){
                    
                    // MARK: - Status
                    Group {
                        FacilityPriceHeader(price: "800", rating: "4.2", status: style)
                        
                        Text("Mountaina Resort Chilas Diamer Pakistan")
                            .font(Font.custom("Poppins-Regular", size: 26))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_DARK))
                        
                        switch style {
                            
                            //MARK: - Booked Style
                        case .booked:
                            BookingDatesView()
                            
                            Group {
                                Divider().padding(.vertical)
                                
                                CalendarButton()
                                
                                Divider().padding(.vertical)
                                
                                GuestInfoView(name: "Palwandew", rating: "4.2")
                                
                                Divider().padding(.vertical)
                                
                                SizeInfoView(space: "80 m2", rooms: "3", capacity: "8")
                                
                                FacilityAmenitiesView()
                                
                                Divider()
                                    .padding(.vertical)
                            }
                            
                            
                            //MARK: - Available Style
                        case .available:
                            SizeInfoView(space: "80 m2", rooms: "3", capacity: "8")
                            
                            FacilityAmenitiesView()
                            
                            Divider()
                                .padding(.vertical)
                            
                            GuestInfoView(name: "Palwandew", rating: "4.2")
                            
                            Divider()
                                .padding(.vertical)
                        }
                        
                        // MARK: - Location
                        
                        FacilityMapView()
                            .frame(height: UIScreen.main.bounds.height * 0.35)
                            .padding(.bottom)
                        
                        Divider().padding(.vertical)
                        
                        //MARK: - Reviews
                        ReviewsView()
                        
                    }

                    //MARK: - Message Guest Button
                    Button {
                        print("message guest")
                    } label: {
                        HStack {
                            Spacer()
                            Text("Message Guest")
                                .foregroundColor(.white)
                                .padding()
                            
                            Spacer()
                        }.background(RoundedRectangle(cornerRadius: 8).fill(Color(AppColor.DARKEST_BLUE)))
                    }
                }
                .padding()
                
                .background(Color.white)
                .roundCorners(radius: 16, [.topLeft, .topRight])
                .shadow(radius: 4, y: -3)
                //.gesture(simpleDrag)
            }.frame(height: UIScreen.main.bounds.height * currentHeight)
            
        }
        .alertDialog(isShowing: $willShowCancelBookingDialog, content: {
            
            
            //MARK: - Cancel Dialog
            BookingCancelationDialog(onProceedCancelation: {
                print("Send cancelation request")
            }, onDismissDialog: {
                willShowCancelBookingDialog.toggle()
            })
        })
        .navigationBarHidden(true)
    }
}

struct FacilityDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        FacilityDetailScreen(style: .available)
        
        // BookingCancelationDialog()//.previewLayout(.sizeThatFits)
    }
}


//MARK: - BookingCancelationDialog
struct BookingCancelationDialog: View {
    
    let onProceedCancelation: () -> Void
    let onDismissDialog: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16){
            
            HStack {
                Spacer()
                Image("icon_complain")
                Spacer()
            }
            
            Text("cancel_booking_title")
                .font(.custom("Poppins-Regular", size: 20, relativeTo: .body))
                .foregroundColor(Color(AppColor.DARKEST_BLUE))
            
            Text("You want to cancel booking on 08.03-15.03. If you cancel guest`s booking you will be fined on 50% of facility cost.")
                .font(.custom("Poppins-Regular", size: 16, relativeTo: .body))
                .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
            
            HStack {
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 16){
                    
                    Button {
                        onProceedCancelation()
                    } label: {
                        Text("Cancel booking and lose 50%")
                            .font(.custom("Poppins-Regular", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.RED))
                    }
                    
                    Button {
                        onDismissDialog()
                    } label: {
                        Text("Don't cancel the booking")
                            .font(.custom("Poppins-Regular", size: 16, relativeTo: .body))
                            .foregroundColor(Color(AppColor.MAIN_TEXT_LIGHT))
                    }
                    
                }
            }
        }
        .padding(24)
    }
}


//MARK: - View used in the screen.

enum FacilityDetailsStyle{
    case booked
    case available
}




//MARK: - ArrivalDetailsView
struct ArrivalDetailsView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
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
        
        
    }
}
